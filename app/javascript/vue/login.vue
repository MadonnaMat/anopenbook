<template lang="pug">
  b-navbar-nav
    b-nav-item-dropdown(right, text="Login")
      .dropdown-item.login-dropdown.w-auto
        b-form(@submit="onSubmit")
          b-form-group(label="Email", label-for="login-email")
            b-form-input(id="login-email", type="email", v-model="email", required, placeholder="Enter Email")
          b-form-group(label="Password", label-for="login-password")
            b-form-input(id="login-password", type="password", v-model="password", required, placeholder="Enter Password")
          b-form-group
            b-form-checkbox(v-model="remember_me") Remember Me
          b-button(type="submit") Submit
      b-dropdown-divider
      b-dropdown-item(:href='linkSignUp') Sign Up
      b-dropdown-item(:href='linkForgotPassword') Forgot your password?
      b-dropdown-item(:href='linkConfirmationResend') Didn't receive confirmation instructions?
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: '',
      remember_me: false,
    };
  },
  props: ['Login', 'SignUp', 'ForgotPassword', 'ConfirmationResend'].map(
    p => `link${p}`,
  ),
  methods: {
    onSubmit(e) {
      e.preventDefault();

      this.axios
        .post(this.linkLogin, {user: this.$data})
        .then(() => this.$notify({text: 'test', type: 'success'}))
        .catch(error => {
          let errorText = 'Unkown error trying to login';
          if (error.response && error.response.data.error) {
            errorText = error.response.data.error;
          }
          this.$notify({
            text: errorText,
            duration: -1,
            type: 'error',
          });
        });
    },
  },
};
</script>

<style lang="scss" scoped>
ul.navbar-nav /deep/ {
  .dropdown-menu {
    min-width: 20rem;
    .login-dropdown {
      color: inherit;
      background-color: inherit;
    }
  }
}
</style>
