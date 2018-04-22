/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.
import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import Notifications from 'vue-notification';
import axios from 'axios';
import VueAxios from 'vue-axios';
import App from 'vue/app.vue';
import Login from 'vue/login.vue';

Vue.use(TurbolinksAdapter);
Vue.use(BootstrapVue);
Vue.use(Notifications);
Vue.use(VueAxios, axios);

document.addEventListener('turbolinks:load', () => {
  axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector(
    'meta[name=csrf-token]',
  ).content;
  axios.defaults.headers.common['HTTP_X_REQUESTED_WITH'] = 'XMLHttpRequest';
  axios.defaults.headers.common['Accept'] = 'application/json';
  axios.defaults.headers.common['Content-Type'] = 'application/json';
  const app = new Vue({
    el: '#app',
    data: {
      message: 'Can you say hello?',
    },
    components: {App, Login},
  });
});
