import { mapState, mapMutations, mapActions } from 'vuex';
import { SET_PRINTERS, SELECT_PRINTER, SET_ENVIRONMENT } from '@/store/printer.store'
import { NEW_IMPRESSION } from '@/store/impression.store'
import badgeXML from '@/data/badge.xml?raw'
import staffBadgeXML from '@/data/staffBadge.xml?raw'
import userSessionMixin from "@/mixins/user_session.mixin"
import modelUtilsMixin from '@/mixins/model_utils.mixin';
import { registrantModel } from '@/store/registrant.store'

export const printerMixin = {
  mixins: [
    userSessionMixin,
    modelUtilsMixin
  ],
  data() {
    return {
      badgexml: badgeXML,
      staffBadgeXML: staffBadgeXML,
      labelType: 'member', // or staff
      label: null,
      labelJson: {}
    }
  },
  computed: {
    ...mapState([
      'environment',
      'printers',
      'selected_printer',
      'selected_registrant'
    ]),
    allSystemsGo: function() {
      return this.environment && this.environment.isBrowserSupported && 
        this.environment.isFrameworkInstalled && 
        this.environment.isWebServicePresent && (this.printers.length > 0)
    }
  },
  methods: {
    ...mapMutations({
      setPrinters: SET_PRINTERS,
      selectPrinter: SELECT_PRINTER,
      setEnvironment: SET_ENVIRONMENT,
    }),
    ...mapActions({
      saveImpression: NEW_IMPRESSION
    }),
    getPrinters() {
      try {
        let printers = dymo.label.framework.getPrinters()
        this.setPrinters(printers)
        if (printers && printers.length == 1) {
          this.selectPrinter(printers[0].name)
        }
        return printers
      } catch (err) {
        return [];
      }
    },

    getObjectElements(label) {
      var objectTypes = ["TextObject"];
      return goog.dom.findNodes(label._doc.documentElement, function (n) {
        return n.nodeType == goog.dom.NodeType.ELEMENT && goog.array.indexOf(objectTypes, n.tagName) >= 0;
      });
    },

    getObjectByNameElement(label, objectName) {
      var objects = this.getObjectElements(label);

      for (var i = 0; i < objects.length; i++) {
        var elem = objects[i];
        var name = dymo.xml.getElementText(dymo.xml.getElement(elem, "Name"));
        if (name == objectName)
          return elem;
      }

      return null;
    },

    setMemberName(label, name) {
      if (name) {
        let split_name = this.split_name(name);
        if (split_name.splits == 0) {
          var el = this.getObjectByNameElement(label, 'MemberName')
          var FormattedText = dymo.xml.getElement(el, "FormattedText");
          var fontSize = dymo.xml.getElements(FormattedText, "FontSize")
          fontSize[0].textContent = 24
        }
        if (split_name.splits == 2) {
          var el = this.getObjectByNameElement(label, 'MemberName')
          var FormattedText = dymo.xml.getElement(el, "FormattedText");
          var fontSize = dymo.xml.getElements(FormattedText, "FontSize")
          fontSize[0].textContent = 12
        }

        label.setObjectText('MemberName', split_name.name);
      } else {
        label.setObjectText('MemberName', "");
      }
    },

    generateMemberLabel({ name = "", number = "", country = "", title = "" }) {
      let label = dymo.label.framework.openLabelXml(this.badgexml)
      let valid = label.isValidLabel();

      if (!valid) return null;

      this.labelJson = { name: name, number: number, country: country, title: title }

      this.setMemberName(label, name)
      
      if (number) {
        label.setObjectText('MembershipNumber', number);
      } else {
        label.setObjectText('MembershipNumber', "");
      }
      if (title) {
        label.setObjectText('BadgeTitle', title);
      } else {
        label.setObjectText('BadgeTitle', "");
      }
      if (country) {
        label.setObjectText('MemberCountry', country);
      } else {
        label.setObjectText('MemberCountry', "");
      }

      return label;
    },

    generateStaffLabel({ name: name, position: position, division: division }) {
      console.debug("***** STAFF LABEL")
      let label = dymo.label.framework.openLabelXml(this.staffBadgeXML)
      let valid = label.isValidLabel();
      console.debug("***** STAFF LABEL", valid)

      if (!valid) return null;

      this.labelJson = { name: name, position: position, division: division }

      this.setMemberName(label, name)
      // label.setObjectText('memberName', name);

      if (position) {
        label.setObjectText('staffPosition', position);
      } else {
        label.setObjectText('staffPosition', "");
      }
      if (division) {
        label.setObjectText('staffDivision', division);
      } else {
        label.setObjectText('staffDivision', "");
      }

      console.debug("***** STAFF LABEL", label)

      return label;
    },

    split_name(name) {
      if (name.length < 19) return { name: name, splits: 0 };

      let elements = name.split(' ')
      let res = ""
      let splits = 0

      elements.forEach(
        (s) => {
          if ((Math.floor((res.length + s.length) / 18) != splits)) {
            res = `${res}\n${s}`
            splits += 1
          } else {
            res = `${res} ${s}`
          }
        }
      )

      return {name: res, splits: splits};
    },

    generateStaffPreview({ name = "", position = "", division = ""}) {
      try {
        this.label = this.generateStaffLabel({ name: name, position: position, division: division });
        console.debug("*** WE HAVE LABEL", this.label)
        if (!this.label) return null;
        return this.label.render();
      } catch (err) {
        this.initPrinter()
        return null;
      }
    },
    generatePreview({name ="", number = "", country = "", title = ""}) {
      try {
        this.label = this.generateMemberLabel({ name: name, number: number, country: country, title: title });
        if (!this.label) return null;
        return this.label.render();
      } catch(err) {
        this.initPrinter()
        return null;
      }
    },
    doPrint(label = null) {
      if (label) this.label = label;
      if (!this.label) return;
      if (!this.selected_printer) return;

      try {
        this.label.print(this.selected_printer)
        let selected_registrant = this.selected_model(registrantModel);
        this.saveImpression({
          user_id: this.currentUser.id,
          registrant_id: selected_registrant.id,
          label_used: this.labelJson,
          user_name: this.currentUser.name,
          label_type: this.labelType
        }).then(
          () => {
            // refresh the selected registrant ...
            this.fetch_model_by_id('registrant', selected_registrant.id);
          }
        )
      } catch (err) {
        this.initPrinter()
        return null;
      }
    },
    checkEnvironment() {
      dymo.label.framework.checkEnvironment(
        (env) => {
          this.setEnvironment(env)
          if (env.errorDetails.length == 0) {
            // See if we can get the list of printers anyway
            this.getPrinters()
          } else {
            console.debug("**** ERR: ", env.errorDetails)
          }
        }

      )
    },
    initPrinter() {
      this.selectPrinter(null)
      this.setPrinters([])
      dymo.label.framework.currentFramework = null

      return new Promise(() => {
        // Initialize the Dymo framework
        let frm = dymo.label.framework.init(
          () => {
            // Get the environment for Dymo
            this.checkEnvironment()
          }
        );
      })
    }
  }
};

export default printerMixin;
