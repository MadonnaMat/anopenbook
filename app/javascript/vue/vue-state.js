import 'es6-promise/auto';
import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';

Vue.use(Vuex);
export default new Vuex.Store({
  state: {
    loggedIn: false,
    onPage: null,
    votesLeft: 0,
  },
  mutations: {
    setLoggedIn(state, loggedIn) {
      state.loggedIn = loggedIn;
    },
    setOnPage(state, page) {
      state.onPage = page;
    },
    setVotesLeft(state, votes) {
      state.votesLeft = parseInt(votes);
    },
  },
});
