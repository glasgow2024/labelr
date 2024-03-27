<template>
  <div class="mb-3">
    <registrants-table></registrants-table>
    <registrant-sidebar :model="model"></registrant-sidebar>
  </div>
</template>

<script>
import RegistrantsTable from './registrants_table.vue';
import RegistrantSidebar from './registrant_sidebar.vue';
import { registrantModel as model } from '@/store/registrant.store'

export default {
  name: "RegistrantsManage",
  data: () => ({
    model
  }),
  components: {
    RegistrantsTable,
    RegistrantSidebar
  },
  mixins: [
  ]
}
</script>

<style></style>
