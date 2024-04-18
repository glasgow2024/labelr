<template>
  <div class="mb-3">
    <registrants-table :model="model"></registrants-table>
    <registrant-sidebar :model="model"></registrant-sidebar>
  </div>
</template>

<script>
import RegistrantsTable from './registrants_table.vue';
import RegistrantSidebar from './registrant_sidebar.vue';
import { staffModel as model } from '@/store/staff.store'

export default {
  name: "StaffManage",
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
