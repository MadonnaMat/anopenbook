<template lang="pug">
  b-navbar(v-if="username")
    b-navbar-nav.mr-2
      b-nav-item(@click="signOut") Log Out
    b-navbar-nav
      b-nav-item
        img(:src="avatar")
  b-navbar-nav(v-else)
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
import $ from 'jquery';
export default {
  data() {
    return {
      email: '',
      password: '',
      remember_me: false,
      username: this.user,
    };
  },
  computed: {
    avatar() {
      return `https://api.adorable.io/avatars/55/${this.username}`;
    },
  },
  props: ['Login', 'SignUp', 'SignOut', 'ForgotPassword', 'ConfirmationResend']
    .map(p => `link${p}`)
    .concat(['user']),
  methods: {
    onSubmit(e) {
      e.preventDefault();

      this.axios
        .post(this.linkLogin, {user: this.$data})
        .then(resp => {
          this.$notify({text: 'test', type: 'success'});
          this.username = resp.data.username;
          this.axios
            .get('/token')
            .then(res =>
              $('meta[name="csrf-token"]').attr('content', res.data.token),
            );
        })
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
    signOut() {
      this.axios.delete(this.linkSignOut).then(() => {
        this.username = null;
        this.$notify({text: 'test', type: 'success'});
        this.axios
          .get('/token')
          .then(res =>
            $('meta[name="csrf-token"]').attr('content', res.data.token),
          );
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
