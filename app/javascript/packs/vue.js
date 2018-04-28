/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.
import TurbolinksAdapter from 'vue-turbolinks';
import $ from 'jquery';
import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import Notifications from 'vue-notification';
import VueI18n from 'vue-i18n';
import axios from 'axios';
import VueAxios from 'vue-axios';
import VueCountdown from '@xkeshi/vue-countdown';
import wysiwyg from 'vue-wysiwyg';
import infiniteScroll from 'vue-infinite-scroll';
import 'vue-awesome/icons';
import Icon from 'vue-awesome/components/Icon';
import App from 'vue/app.vue';
import Login from 'vue/login.vue';
import Sendnotification from 'vue/sendnotification.vue';
import Bookcarousel from 'vue/bookcarousel.vue';
import Submitbutton from 'vue/submitbutton.vue';
import Scrollsubmissions from 'vue/scrollsubmissions.vue';

Vue.use(TurbolinksAdapter);
Vue.use(BootstrapVue);
Vue.use(Notifications);
Vue.use(VueAxios, axios);
Vue.use(VueI18n);
Vue.use(infiniteScroll);
Vue.use(wysiwyg, {
  hideModules: {link: true, image: true, separator: true},
});

Vue.component('icon', Icon);

document.addEventListener('turbolinks:load', () => {
  const messages = {
    en: require('js-yaml-loader!../../../config/locales/vue.en.yml').en.vue,
  };

  const i18n = new VueI18n({
    locale: 'en', // set locale
    messages, // set locale messages
  });

  axios.interceptors.request.use(function(config) {
    config.headers = {
      'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,

      HTTP_X_REQUESTED_WITH: 'XMLHttpRequest',
      Accept: 'application/json',
      'Content-Type': 'application/json',
    };
    return config;
  });

  const app = new Vue({
    i18n,
    el: '#app',
    data() {
      return {
        loggedIn: false,
        onPage: null,
        inputEcho: '',
      };
    },
    components: {
      App,
      Login,
      Sendnotification,
      Bookcarousel,
      VueCountdown,
      Submitbutton,
      Scrollsubmissions,
    },
    mounted() {
      let onPage = this.$el.attributes['on-page'];
      this.onPage = onPage ? onPage.value : null;
      this.inputEcho = $('.input-echo').data('value');
    },
    methods: {
      setLoggedIn(loggedIn) {
        this.loggedIn = loggedIn;
      },
    },
  });
});
