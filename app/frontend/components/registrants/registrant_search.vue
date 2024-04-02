<template>
  <div class="d-flex justify-content-between my-3">
    <b-input-group>
      <b-input-group-prepend>
        <b-input-group-text>
          <b-icon icon="search" />
        </b-input-group-text>
      </b-input-group-prepend>
      <b-form-input type="text" v-model="registrant_text" debounce="500" v-on:keyup.enter="onSearch"></b-form-input>
      <b-input-group-append>
        <b-button variant="primary" @click="onSearch">Search</b-button>
      </b-input-group-append>
    </b-input-group>
    <!-- TODO: we put in the search by product and attending status (these are AND) -->
    <!-- product_id -->
    <!-- attending_status -->
    <div class="w-75"></div>
  </div>
</template>

<script>
import searchStateMixin from '@/store/search_state.mixin'
const SAVED_SEARCH_STATE = "REGISTRANT SEARCH STATE";

export default {
  name: "RegistrantSearch",
  data: () => ({
    registrant_text: null,
    product_id: null,
    attending_status: null,
    match: 'all',
  }),
  components: {
  },
  mixins: [
    searchStateMixin
  ],
  methods: {
    fields_to_query() {
      let queries = {
        "op": this.match,
        "queries": []
      }

      if (this.registrant_text) {
        queries["queries"].push(
          {
            "op": "any",
            "queries": [
              ["first_name", "contains", this.registrant_text],
              ["last_name", "contains", this.registrant_text],
              ["preferred_name_first", "contains", this.registrant_text],
              ["preferred_name_last", "contains", this.registrant_text],
              ["badge", "contains", this.registrant_text],
              ["badge_title", "contains", this.registrant_text],
              ["address_country", "contains", this.registrant_text],
            ]
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
      if (this.attending_status) {
        queries["queries"].push(
          ["attending_status", "=", this.attending_status],
        )
      }

      return queries
    },
    onSearch: function (event) {
      this.setSearchState({
        key: SAVED_SEARCH_STATE,
        setting: {
          registrant_text: this.registrant_text,
          product_id: this.product_id,
          attending_status: this.attending_status
        }
      })
      this.$emit('change', this.fields_to_query())
    },
    init() {
      let saved = this.getSearchState()(SAVED_SEARCH_STATE)
      if (saved) {
        this.registrant_text = saved.registrant_text
        this.product_id = saved.product_id
        this.attending_status = saved.attending_status
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
