<template>
  <!-- TODO: put in instructions etc. -->
  <div class="row justify-content-center mt-5">
    <div v-if="loggedIn">
      <b-card-group deck>
        <b-card no-body title="Check Printer" tag="labels">
          <b-card-body>
            Setup printer for the convention
          </b-card-body>
          <b-card-footer>
            <b-button href="#printer" variant="primary">Setup Printer</b-button>
          </b-card-footer>
        </b-card>
        <b-card no-body title="Print Labels" tag="labels">
          <b-card-body>
            Print labels for members of the convention
          </b-card-body>
          <b-card-footer>
            <b-button href="#registrants" variant="primary">Go Print Labels</b-button>
          </b-card-footer>
        </b-card>
      </b-card-group>
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
