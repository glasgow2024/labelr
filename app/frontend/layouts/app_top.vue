<template>
  <div>
    <div class="row">
      <div class="col-12 px-0">
        <b-navbar toggleable="lg" type="dark" variant="secondary">
          <b-navbar-brand to="/">Labelr</b-navbar-brand>
          <b-navbar-nav class="ml-auto">
            <b-nav-text class="mr-3" v-if="loggedIn">Logged in as: {{currentUser.email ? currentUser.email :
              ''}}</b-nav-text>
            <b-nav-form v-if="loggedIn">
              <b-button size="sm" @click="logout" variant="primary">Logout</b-button>
            </b-nav-form>
          </b-navbar-nav>
        </b-navbar>
      </div>
    </div>
    <div class="row">
      <div class="col-12 px-0">
        <b-nav align="center" class="bg-dark text-white" v-if="loggedIn">
          <b-nav-text v-if="environment && environment.errorDetails.length > 0" class="mr-3">{{ environment.errorDetails
            }}</b-nav-text>
          <b-nav-text v-else-if="allSystemsGo" class="mr-3">Good To Print!</b-nav-text>
          <b-nav-text v-else class="mr-3 text-danger">Unable to Print</b-nav-text>
          <b-nav-text v-if="selected_printer && (printers.length > 0)" class="mr-3">Printer: {{ selected_printer }}</b-nav-text>
          <b-nav-text v-else class="mr-3">Printer: None Detected</b-nav-text>
        </b-nav>
      </div>
    </div>
  </div>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin"
import { authMixin } from '@/mixins/auth.mixin';
import printerMixin from "@/mixins/printer.mixin"

/*
 */
export default {
  name: "AppTop",
  components: {
  },
  mixins: [
    authMixin,
    userSessionMixin,
    printerMixin
  ],
  data() {
    return {
    }
  },
  methods: {
    login() {
      this.$router.push('/login')
    },
    logout() {
      this.signOut().then(() => {
        this.fetchSession({ force: true }).then(
          () => {
            this.$router.push(`/login`)
          }
        )
      })
    }
  }
}
</script>

<style scoped></style>
