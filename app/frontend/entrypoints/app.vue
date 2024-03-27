<!--  -->
<template>
  <app-layout>
    <router-view></router-view>
  </app-layout>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin";
import AppLayout from "@/layouts/app_layout.vue"
import printerMixin from "@/mixins/printer.mixin"

export default {
  name: "LabelrApp",
  components: {
    AppLayout
  },
  mixins: [
    userSessionMixin,
    printerMixin
  ],
  mounted() {
    this.initPrinter()
  }
}
</script>

<style lang="scss" scoped></style>