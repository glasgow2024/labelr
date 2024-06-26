<template>
  <b-form-group :id="formGroupId" :label="passwordLabel" :label-for="formInputId" :invalid-feedback="invalidMessage"
    :state="valid" :description="passwordDescription">
    <b-form-input :id="formInputId" type="password" novalidate :value="value" @input="$emit('input', $event)"
      :state="valid" @focus="onPasswordFocus" @blur="onPasswordUnfocus"></b-form-input>
  </b-form-group>
</template>

<script>
import {
  LOGIN_MISSING_PASSWORD,
  LOGIN_PASSWORDS_DO_NOT_MATCH,
  LOGIN_SHORT_PASSWORD,
} from "@/constants/strings";

export default {
  name: "LoginPasswordField",
  props: {
    value: {
      type: String,
    },
    mustMatch: {
      type: String,
      default: "",
    },
    newPassword: {
      type: Boolean,
      default: false,
    },
    confirmation: {
      type: Boolean,
      default: false,
    },
    validateNow: {
      type: Function,
    },
  },
  data: () => ({
    valid: null,
  }),
  computed: {
    formInputId: function () {
      if (this.newPassword) {
        return "input-new-password";
      }
      if (this.confirmation) {
        return "input-confirm-password";
      }
      return "input-password";
    },
    formGroupId: function () {
      if (this.newPassword) {
        return "input-group-new-password";
      }
      if (this.confirmation) {
        return "input-group-confirm-password";
      }
      return "input-group-password";
    },
    invalidMessage: function () {
      if (this.value.length < 1 || (!this.newPassword && !this.confirmation)) {
        return LOGIN_MISSING_PASSWORD;
      }
      if (this.confirmation) {
        return LOGIN_PASSWORDS_DO_NOT_MATCH;
      }
      return LOGIN_SHORT_PASSWORD;
    },
    passwordLabel: function () {
      if (this.newPassword) {
        return "New Password";
      }
      if (this.confirmation) {
        return "Re-enter Your New Password";
      }
      return "Password";
    },
    passwordDescription: function () {
      if (!this.newPassword && !this.confirmation) {
        return "Passwords must contain: 6 or more characters. Password cannot contain: the word 'password' or your username";
      }
      return "";
    },
  },
  watch: {
    validateNow: function (val) {
      this.validate();
      val(true);
    },
  },
  methods: {
    validate: function (event) {
      const minLength = this.newPassword ? 6 : 1;
      const matching = this.confirmation ? this.value === this.mustMatch : true;
      if (this.value.length < minLength || !matching) {
        this.valid = false;
      }
      this.$emit("validated", this.valid);
    },
    onPasswordFocus: function (event) {
      this.valid = null;
      this.$emit("validated", this.valid);
    },
    onPasswordUnfocus: function (event) {
      this.validate(event);
    },
  },
};
</script>
