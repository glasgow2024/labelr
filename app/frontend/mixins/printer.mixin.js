import { mapState, mapMutations } from 'vuex';
import { SET_PRINTERS, SELECT_PRINTER, SET_ENVIRONMENT } from '@/store/printer.store'
import badgeXML from '@/data/badge.xml?raw'

export const printerMixin = {
  data() {
    return {
      badgexml: badgeXML,
      label: null
    }
  },
  computed: {
    ...mapState([
      'environment',
      'printers',
      'selected_printer'
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
    getPrinters() {
      let printers = dymo.label.framework.getPrinters()
      this.setPrinters(printers)
      if (printers && printers.length == 1) {
        this.selectPrinter(printers[0].name)
      }
      return printers
    },
    generateLabel({ name = "", number = "", country = "", title = "" }) {
      let label = dymo.label.framework.openLabelXml(this.badgexml)
      let valid = label.isValidLabel();

      if (!valid) return null;

      if (name) {
        label.setObjectText('MemberName', this.split_name(name));
      } else {
        label.setObjectText('MemberName', "");
      }
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
    split_name(name) {
      if (name.length < 19) return name;

      let elements = name.split(' ')
      let res = ""
      let count = 0
      let split = false

      elements.forEach(
        (s) => {
          if ((res.length + s.length < 18) || split) {
            res = `${res} ${s}`
            count = res.length
          } else {
            split = true
            res = `${res}\n${s}`
          }
        }
      )

      return res;
    },
    generatePreview({name ="", number = "", country = "", title = ""}) {
      try {
        this.label = this.generateLabel({ name: name, number: number, country: country, title: title });
        if (!this.label) return null;
        return this.label.render();
      } catch(err) {
        console.debug("**** ERROR", err)
        // 
        this.checkEnvironment()
        return null;
      }
    },
    doPrint(label = null) {
      if (label) this.label = label;
      if (!this.label) return;
      if (!this.selected_printer) return;

      this.label.print(this.selected_printer);
    },
    checkEnvironment() {
      console.debug("**** CHECK ENV")
      dymo.label.framework.checkEnvironment(
        (env) => {
          this.setEnvironment(env)
          console.debug("*** ENV: ", env)
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
      return new Promise(() => {
        // Initialize the Dymo franework
        dymo.label.framework.init(
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
