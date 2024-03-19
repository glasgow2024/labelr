<template>
  <div class="mb-3">
    <registrants-table></registrants-table>
    <!-- <organization-sidebar :model="model"></organization-sidebar> -->
  </div>
</template>

<script>
import RegistrantsTable from './registrants_table.vue';
// import OrganizationSidebar from './organization_sidebar.vue';
import { registrantModel as model } from '@/store/registrant.store'

export default {
  name: "RegistrantsManage",
  data: () => ({
    model
  }),
  components: {
    RegistrantsTable,
    // OrganizationSidebar
  },
  mixins: [
  ]
}
</script>

<style></style>
