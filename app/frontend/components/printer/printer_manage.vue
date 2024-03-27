<template>
  <div class="mb-3">
    <h1>Printer Management</h1>
    <b-card-group deck>
      <printer-environment></printer-environment>
      <printer-selection></printer-selection>
    </b-card-group>
    <!-- <div>
      <img id="labelImage" />
    </div>
    <b-button variant="success" @click="renderPreview()">Preview</b-button>
    <b-button variant="success" @click="doPrint()">Print</b-button> -->
  </div>
</template>

<script>
import printerMixin from "@/mixins/printer.mixin"
import PrinterEnvironment from "./printer_environment.vue"
import PrinterSelection from "./printer_selection.vue"

export default {
  name: "PrinterManage",
  mixins: [
    printerMixin
  ],
  components: {
    PrinterEnvironment,
    PrinterSelection
  },
  data() {
    return {
      previewImage: null
    }
  },
  methods: {
    // renderPreview: function() {
    //   this.selectPrinter(this.printers[0].name)
    //   this.generateLabel({ name: "Henry Balen", number: "1111" });
    //   this.previewImage = this.generatePreview({name: "Henry Balen", number: "1111"});
    //   var labelImage = document.getElementById('labelImage');
    //   labelImage.src = "data:image/png;base64," + this.previewImage;
    // }
  },
  mounted() {
    // this.initPrinter()
    // .then(
    //   () => {
    //     this.getPrinters()
    //   }
    // )
  } 
}
</script>

<style></style>
