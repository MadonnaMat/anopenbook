<template>
  <h2 v-if="loggedIn">{{ $tc('votes_left.msg', votesLeft) }}</h2>
</template>

<script>
import titleCase from 'voca/title_case';
import {mapState, mapMutations} from 'vuex';
import linkArray from './link_array';
export default {
  props: ['votes'],
  computed: {
    ...mapState(['loggedIn', 'votesLeft']),
  },
  created() {
    this.setVotesLeft(this.votes);
  },
  methods: mapMutations(['setVotesLeft']),
};
</script>

<style lang="scss" scoped></style>
