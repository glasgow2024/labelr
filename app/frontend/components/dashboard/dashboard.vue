<template>
  <!-- TODO: put in instructions etc. -->
  <div class="row justify-content-center mt-5">
    <div class="col-md-6" v-if="loggedIn">
      <div class="d-flex m-2">
      <!-- <div class="col" v-if="loggedIn"> -->
        <b-card
          title="Check Printer"
          tag="labels"
          style="width: 45%;"
          class="mr-2"
        >
          <b-card-text>
            Setup printer for the convention
          </b-card-text>

          <b-button href="/printer" variant="primary">Setup Printer</b-button>
        </b-card>
        <b-card
          title="Print Labels"
          tag="labels"
          style="width: 45%;"
        >
          <b-card-text>
            Print labels for members of the convention
          </b-card-text>

          <b-button href="/registrants" variant="primary">Go Print Labels</b-button>
        </b-card>
      </div>
    </div>
  </div>
</template>

<script>
import { userSessionMixin} from '@/mixins/user_session.mixin';
// import RegistrantsManage from '@/components/registrants/registrants_manage.vue';

export default {
  name: "Dashboard",
  components: {
    // RegistrantsManage
  },
  mixins: [ userSessionMixin ]
}
</script>
