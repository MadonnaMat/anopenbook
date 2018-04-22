<template lang="pug">
  b-navbar(v-if="username")
    b-navbar-nav.mr-2
      b-nav-item(@click="signOut") 
        span(v-t="'login.logout'")
    b-navbar-nav
      b-nav-item(:href='linkEdit')
        img(:src="avatar")
  b-navbar-nav(v-else)
    b-nav-item-dropdown(right)
      template(slot="button-content")
        span(v-t="'login.login'")
      .dropdown-item.login-dropdown.w-auto
        b-form(@submit="onSubmit")
          b-form-group(:label="tEmail", label-for="login-email")
            b-form-input(id="login-email", type="email", v-model="email", required, placeholder="Enter Email")
          b-form-group(:label="tPassword", label-for="login-password")
            b-form-input(id="login-password", type="password", v-model="password", required, placeholder="Enter Password")
          b-form-group
            b-form-checkbox(v-model="remember_me")
              span(v-t="'login.remember_me'")
          b-button(type="submit")
            span(v-t="'buttons.submit'")
      b-dropdown-divider
      b-dropdown-item(:href='linkSignUp')
        span(v-t="'login.sign_up'")
      b-dropdown-item(:href='linkForgotPassword') 
        span(v-t="'login.forgot_pw'")
      b-dropdown-item(:href='linkConfirmationResend')
        span(v-t="'login.conf_resend'")
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
    tEmail() {
      return this.$t('login.email');
    },
    tPassword() {
      return this.$t('login.password');
    },
  },
  props: [
    'Login',
    'SignUp',
    'SignOut',
    'ForgotPassword',
    'ConfirmationResend',
    'Edit',
  ]
    .map(p => `link${p}`)
    .concat(['user']),
  methods: {
    onSubmit(e) {
      e.preventDefault();

      this.axios
        .post(this.linkLogin, {user: this.$data})
        .then(resp => {
          this.$notify({text: this.$t('login.success'), type: 'success'});
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
        this.$notify({text: this.$t('login.logout_success'), type: 'success'});
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
