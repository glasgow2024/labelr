<template>
  <div class="mb-3">
    <h1>Printer Management</h1>
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
  }
}
</script>

<style></style>
