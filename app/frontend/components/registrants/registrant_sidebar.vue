<template>
  <sidebar-vue :model="model">
    <template #header v-if="selected">
      <h1>{{ selected.first_name }} {{ selected.last_name }}</h1>
      <div>Attending: {{attending_status}}</div>
    </template>
    <template #content v-if="selected">
      <div class="mx-auto" style="width: 400px;">
        <img id="labelImage" :src="preview" />
      </div>
      <b-button variant="success" @click="onPrint()">Print</b-button>
      <div>
        <dl>
          <dt>Ticket Number</dt>
          <dd class="font-italic ml-2">{{ selected.ticket_number }}</dd>
          <dt>Name</dt>
          <dd class="font-italic ml-2">{{ selected.first_name }} {{ selected.last_name }}</dd>
          <dt>Preferred Name</dt>
          <dd class="font-italic ml-2">{{ selected.preferred_name_first }} {{ selected.preferred_name_last }}</dd>
          <dt>Badge Name</dt>
          <dd class="font-italic ml-2">{{ selected.badge }}</dd>
          <dt>Country</dt>
          <dd class="font-italic ml-2">{{ selected.address_country }}</dd>
        </dl>
      </div>
    </template>
  </sidebar-vue>
</template>

<script>
import SidebarVue from '@/components/shared/sidebar_vue.vue';
import { modelMixin } from '@/mixins/model.mixin';
import printerMixin from "@/mixins/printer.mixin"

export default {
  name: 'RegistrantSidebar',
  components: {
    SidebarVue
  },
  mixins: [
    printerMixin,
    modelMixin
  ],
  data() {
    return {
      previewImage: null
    }
  },
  computed: {
    attending_status: function() {
      if (!this.selected) return "";

      if (this.selected.attending_status == 1) {
        return "Not Attending"
      } else if (this.selected.attending_status == 2) {
        return "In Person"
      } else if (this.selected.attending_status == 3) {
        return "Online"
      } else if (this.selected.attending_status == 4) {
        return "Programme"
      } else if (this.selected.attending_status == 5) {
        return "Finalist"
      } else if (this.selected.attending_status == 6) {
        return "Volunteer"
      } else {
        return "Unknown"
      }
    },
    badge_name: function() {
      if (!this.selected) return "";

      if (this.selected.badge){
        return this.selected.badge
      } else if (this.selected.preferred_name_last || this.selected.preferred_name_first) {
        return `${this.selected.preferred_name_first} ${this.selected.preferred_name_last}`
      } else {
        return `${this.selected.first_name} ${this.selected.last_name}`
      }
    },
    badge_content: function() {
      if (!this.selected) return null;

      return {
        name: this.badge_name,
        number: this.selected.ticket_number,
        country: this.selected.address_country,
        title: this.selected.badge_title
      }
    },
    preview: function () {
      // this.generateLabel({ name: selected.first_name + selected.last_name, number: "1111" });
      this.previewImage = this.generatePreview(this.badge_content);
      // var labelImage = document.getElementById('labelImage');
      return "data:image/png;base64," + this.previewImage;
    }
  },
  methods: {
    onPrint() {
      this.doPrint()
    }
  }
}
</script>
