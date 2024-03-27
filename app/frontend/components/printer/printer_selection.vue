<template>
  <b-card title="Printers" style="max-width: 50%;">
    <b-card-body>
      <b-button variant="success" @click="refresh()">Check for Printers</b-button>
      <!-- {{ selectedPrinter }} -->
      {{ selected_printer }}
      <!-- {{ options }} -->
      <b-form-select v-model="selected" @change="onChange" :options="options"></b-form-select>
    </b-card-body>
  </b-card>
</template>

<script>
import printerMixin from "@/mixins/printer.mixin"

export default {
  name: "PrinterSelection",
  data() {
    return {
      selected: null
    }
  },
  // watch: {
  //   selectedPrinter: function (newVal, oldVal) {
  //     console.debug("****** ", newVal, oldVal)
  //     this.selected_printer = newVal
  //   },    
  // },
  mixins: [
    printerMixin
  ],
  computed: {
    options: function () {
      if (this.printers.length == 0) return []

      let opts = []
      this.printers.forEach(
        (p) => {
          opts.push({
            value: p.name,
            text: p.name
          })
        }
      )
      return opts;
    }    
  },
  methods: {
    onChange(arg) {
      this.selectPrinter(arg)
    },
    refresh() {
      this.getPrinters()
    }
  },
  mounted() {
    this.selected = this.selected_printer
  }
}
</script>

<style></style>
