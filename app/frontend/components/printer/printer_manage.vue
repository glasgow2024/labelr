<template>
  <div class="mb-3">
    <h1>Printer Management</h1>
    <div class="m-2 p-2 shadow rounded-lg bg-light">
      If there is a problem detecting the printer etc please try clicking refresh: 
      <b-button variant="success" @click="refresh()">Refresh</b-button>
    </div>
    <b-card-group deck>
      <printer-environment></printer-environment>
      <printer-selection></printer-selection>
    </b-card-group>
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
  methods: {
    refresh() {
      this.initPrinter()
    }
  }
}
</script>

<style></style>
