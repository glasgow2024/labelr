<template>
  <div class="mb-3">
    <users-table></users-table>
  </div>
</template>

<script>
import UsersTable from './users_table.vue';
import { userModel as model } from '@/store/user.store'

export default {
  name: "UsersManage",
  data: () => ({
    model
  }), 
  components: {
    UsersTable
  },
  mixins: [
  ]
}
</script>

<style></style>
