<template>
  <b-card title="Status" style="max-width: 20rem;">
    <b-card-body>
      <div>
        Is Browser Supported
        <b-icon v-if="environment && environment.isBrowserSupported" icon="check-lg" variant="success"></b-icon>
        <b-icon v-else icon="x-lg" variant="danger"></b-icon>
      </div>
      <div>
        Is Framework Installed
        <b-icon v-if="environment && environment.isFrameworkInstalled" icon="check-lg" variant="success"></b-icon>
        <b-icon v-else icon="x-lg" variant="danger"></b-icon>
      </div>
      <div>
        Is Web Service Present
        <b-icon v-if="environment && environment.isWebServicePresent" icon="check-lg" variant="success"></b-icon>
        <b-icon v-else icon="x-lg" variant="danger"></b-icon>
      </div>
      <div>
        Are Printer(s) Available
        <b-icon v-if="printers.length > 0" icon="check-lg" variant="success"></b-icon>
        <b-icon v-else icon="x-lg" variant="danger"></b-icon>
      </div>
    </b-card-body>
  </b-card>
</template>

<script>
import printerMixin from "@/mixins/printer.mixin"

export default {
  name: "PrinterEnvironment",
  mixins: [
    printerMixin
  ]
}
</script>

<style></style>
