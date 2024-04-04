<template>
  <b-card title="Printers" style="max-width: 50%;" class="shadow">
    <b-card-body>
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
    }
  },
  mounted() {
    this.selected = this.selected_printer
  }
}
</script>

<style></style>
