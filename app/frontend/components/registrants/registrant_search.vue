<template>
<div>
  <div class="d-flex justify-content-between my-3">
    <b-input-group>
      <b-input-group-prepend>
        <b-input-group-text>
          <b-icon icon="search" />
        </b-input-group-text>
      </b-input-group-prepend>
      <b-form-input type="text" v-model="search_text" debounce="500" v-on:keyup.enter="onSearch"></b-form-input>
      <b-input-group-append>
        <b-button variant="primary" @click="onSearch">Search</b-button>
      </b-input-group-append>
    </b-input-group>
    <div class="w-75"></div>
  </div>
  <b-form-group label="Search By:">
    <div class="d-flex mb-3">
      <span class="mr-2"><strong>Attending Status:</strong></span>
      <div>
        <b-form-select v-model="attendingStatus" :options="attendingOptions"></b-form-select>
      </div>
      <!-- <div class="w-50"></div> -->
    </div>
    <b-form-checkbox
      v-model="searchAllFields"
      @change="toggleSelectAll"
      inline
      class="mr-4"
    >All</b-form-checkbox>
    <b-form-checkbox
      v-for="option in searchOptions"
      v-model="searchFields"
      :key="option.value"
      :value="option.value"
      name="search-fields"
      inline
    >{{ option.text }}</b-form-checkbox>
  </b-form-group>
</div>
</template>

<script>
import searchStateMixin from '@/store/search_state.mixin'
const SAVED_SEARCH_STATE = "REGISTRANT SEARCH STATE";

export default {
  name: "RegistrantSearch",
  data: () => ({
    searchFields: [],
    searchOptions: [
      { text: 'Ticket', value: 'ticket_number' },
      { text: 'First Name', value: 'first_name' },
      { text: 'Last Name', value: 'last_name' },
      { text: 'Email', value: 'email' },
      { text: 'Preferred First Name', value: 'preferred_name_first' },
      { text: 'Preferred Last Name', value: 'preferred_name_last' },
      { text: 'Badge', value: 'badge' },
      { text: 'Badge Title', value: 'badge_title' },
      { text: 'Country', value: 'address_country' },
    ],
    attendingStatus: 2,
    attendingOptions: [
      { value: 1, text: "Not Attending"},
      { value: 2, text: "In Person"},
      { value: 3, text: "Online"},
      { value: 4, text: "Programme"},
      { value: 5, text: "Finalist"},
      { value: 6, text: "Volunteer"}
    ],
    search_text: null,
    product_id: null,
    match: 'all',
  }),
  components: {
  },
  mixins: [
    searchStateMixin
  ],
  computed: {
    searchAllFields: function () {
      return this.searchFields.length == 9
    }    
  },
  methods: {
    toggleSelectAll(arg) {
      if (arg) {
        this.searchFields = this.searchOptions.map(obj => obj.value)
      } else {
        this.searchFields = []
      }
    },
    fields_to_query() {
      let queries = {
        "op": this.match,
        "queries": []
      }

      if (this.search_text) {
        var terms = []
        this.searchFields.forEach(
          (field) => {
            terms.push( [field,"contains", this.search_text])
          }
        )
        queries["queries"].push(
          {
            "op": "any",
            "queries": terms
          }
        )
      }

      // product
      if (this.product_id) {
        queries["queries"].push(
          ["product_id", "=", this.product_id],
        )
      }

      // attending_status
      if (this.attendingStatus) {
        queries["queries"].push(
          ["attending_status", "=", this.attendingStatus],
        )
      }

      return queries
    },
    onSearch: function (event) {
      this.setSearchState({
        key: SAVED_SEARCH_STATE,
        setting: {
          search_text: this.search_text,
          product_id: this.product_id,
          attending_status: this.attending_status,
          searchFields: this.searchFields,
          attendingStatus: this.attendingStatus
        }
      })
      this.$emit('change', this.fields_to_query())
    },
    init() {
      this.searchFields = this.searchOptions.map(obj => obj.value)
      let saved = this.getSearchState()(SAVED_SEARCH_STATE)
      if (saved) {
        this.search_text = saved.search_text
        this.product_id = saved.product_id
        this.attending_status = saved.attending_status
        this.searchFields = saved.searchFields
        this.attendingStatus = saved.attendingStatus
      }
      this.$emit('change', this.fields_to_query())
    }
  },
  mounted() {
    this.init();
  }
}
</script>

<style></style>
