<template>
  <div>
    <table-vue
      @new="openNewModal"
      defaultSortBy='name'
      :defaultSortDesc="false"
      :model="model"
      :columns="columns"
      :show-search="true"
      stateName="users-table-search-state"
      ref="users-table"
    >
    </table-vue>
    <b-modal
      cancel-variant="link"
      button-size="sm"
      centered
      scrollable
      v-on="$listeners"
      v-bind="$attrs"
      id="add-user"
      title="Add User"
      @ok="onNew"
    >
      <b-form-group label="Name" label-for="user-name" description="User's Name">
        <b-form-input id="user-name" type="text" v-model="name"></b-form-input>
      </b-form-group>
      <b-form-group label="Email" label-for="user-email" description="User's Email">
        <b-form-input id="user-email" type="text" v-model="email"></b-form-input>
      </b-form-group>
      <b-form-group label="Role" label-for="user-role" description="User's Role">
        <b-form-select id="user-role" v-model="role" :options="options"></b-form-select>
      </b-form-group>
    </b-modal>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import Modal from '@/components/shared/modal.vue';
import TableVue from '@/components/shared/table_vue.vue';
import { user_columns as columns } from './users';
import { NEW_USER, userModel as model } from '@/store/user.store'

export default {
  name: 'UsersTable',
  components: {
    TableVue,
    Modal
  },
  data: () => ({
    columns,
    model,
    name: null,
    email: null,
    role: 'staff',
    options: [
      { value: 'staff', text: 'Staff' },
      { value: 'admin', text: 'Admin' }
    ]
  }),
  methods: {
    ...mapActions({
      newUser: NEW_USER
    }),
    openNewModal() {
      this.name = null;
      this.email = null;
      this.role = 'staff';
      this.$bvModal.show('add-user');
    },
    onNew() {
      if (this.name && this.email) {
        this.newUser({name: this.name, email: this.email, role: this.role}).then(
          () => {
            this.$refs['users-table'].fetchPaged()
          }
        )
      }
    }
  },
  mounted() {
    this.$refs['users-table'].fetchPaged()
  }
}
</script>
