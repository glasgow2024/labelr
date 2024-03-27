<template>
  <div>
    <table-vue
      defaultSortBy='ticket_number'
      :defaultSortDesc="false"
      :model="model"
      :columns="columns"
      ref="registrants-table">
    <!--
      defaultFilter='{"op":"all","queries":[["attending_status", "!=", "1"]]}'
      ref="registrants-table"> -->
      <!-- defaultFilter='{"op":"all","queries":[["product_id", "!=", "1"], ["product_id", "!=", "25"], ["product_id", "!=", "35"]]}' -->
      <template #cell(product_data)="{ item }">
        {{ JSON.parse(item.product_data).title }}
      </template>
      <template #cell(attending_status)="{ item }">
        <div v-if="item.attending_status == 1">Not Attending</div>
        <div v-else-if="item.attending_status == 2">In Person</div>
        <div v-else-if="item.attending_status == 3">Online</div>
        <div v-else-if="item.attending_status == 4">Programme</div>
        <div v-else-if="item.attending_status == 5">Finalist</div>
        <div v-else-if="item.attending_status == 6">Volunteer</div>
        <div v-else>{{item.attending_status}}</div>
      </template>
    </table-vue>
  </div>
</template>

<script>
import Modal from '@/components/shared/modal.vue';
import TableVue from '@/components/shared/table_vue.vue';
import { registrant_columns as columns } from './registrants';
import { registrantModel as model } from '@/store/registrant.store'

export default {
  name: 'RegistrantTable',
  components: {
    TableVue,
    Modal
  },
  data: () => ({
    columns,
    model
  }),
  // mixins: [
  // ],
  methods: {
  },
  mounted() {
    this.$refs['registrants-table'].fetchPaged()
  }
}
</script>
