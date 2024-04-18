<template>
  <div>
    <!-- TODO: put in instructions etc. -->
    <div class="row justify-content-center mt-5">
      <div v-if="loggedIn">
        <b-card-group deck>
          <b-card no-body title="Check Printer" tag="labels" class="shadow">
            <b-card-body>
              Setup printer for the convention
            </b-card-body>
            <b-card-footer>
              <b-button href="#printer" variant="primary">Setup Printer</b-button>
            </b-card-footer>
          </b-card>
          <b-card no-body title="Print Labels" tag="labels" class="shadow">
            <b-card-body>
              Print labels for Members of the convention
            </b-card-body>
            <b-card-footer>
              <b-button href="#registrants" variant="primary">Go Print Member Labels</b-button>
            </b-card-footer>
          </b-card>
          <b-card no-body title="Print Labels" tag="labels" class="shadow">
            <b-card-body>
              Print labels for Staff of the convention
            </b-card-body>
            <b-card-footer>
              <b-button href="#staff" variant="primary">Go Print Staff Labels</b-button>
            </b-card-footer>
          </b-card>
        </b-card-group>
      </div>
    </div>
    <div class="row justify-content-center mt-5">
      <div class="p-4 shadow rounded-lg w-50 bg-light">
        <h2>Instructions</h2>
        <p>To be able to print please ensure the following:</p>
        <ol>
          <li>You have installed a DYMO label printer and drivers</li>
          <li>Install the DYMO Connnect Software for your system
            <ul>
              <li>
                <a href="https://download.dymo.com/dymo/Software/Win/DCDSetup1.4.5.1.exe">DYMO Connect Software for Windows</a>
              </li>
              <li>
                <a href="https://download.dymo.com/dymo/Software/Mac/DCDMac1.4.4.18.pkg">DYMO Connect Software for Mac</a>
              </li>
            </ul>
          </li>
        </ol>
      </div>
    </div>
  </div>
</template>

<script>
import { userSessionMixin} from '@/mixins/user_session.mixin';

export default {
  name: "Dashboard",
  mixins: [ userSessionMixin ]
}
</script>
