import i18next from 'i18next';

const messages = require('js-yaml-loader!../../../config/locales/vue.en.yml');

i18next.init({
  lng: 'en',
  resources: {
    en: {translation: messages.en.vue},
  },
});

const Vuei18nPlugin = {
  install: function(Vue) {
    Vue.t = i18next.t.bind(i18next);
    Vue.prototype.$t = Vue.t;

    console.log(Vue.t);

    Vue.directive('t', function(el, binding) {
      console.log(el, binding, i18next.t(binding.value));
      if (binding.arg) {
        el.setAttribute(binding.arg, i18next.t(binding.value));
      } else {
        el.innerText = i18next.t(el.innerText);
      }
    });
  },
};

export default Vuei18nPlugin;
