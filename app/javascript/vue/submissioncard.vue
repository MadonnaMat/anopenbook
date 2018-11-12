<template lang="pug">
  b-card(class="w-100 mb-4")
    b-row
      b-col(cols="1" align-self="center", v-on:click="toggleVote", v-bind:class="[{active: attributes.voted_on}]")
        icon(v-if="isVotable" name="arrow-up" scale="2")
        icon(v-else name="arrow-up" scale="2" class="text-muted", v-b-popover.hover="noVoteText")
      b-col(cols="5" v-on:click="visitPage", class="clickable")
        h4 {{attributes.title}}
        h5(v-t="{ path: 'submission_card.user', args: { type: typeTitle, username: attributes.author } }")
      b-col(cols="6" v-on:click="visitPage", class="clickable")
        p(v-html="attributes.shortend_body")
</template>

<script>
import titleCase from 'voca/title_case';
import {mapState, mapMutations} from 'vuex';
export default {
  data() {
    return {
      submission: this.sub,
      attributes: this.sub.attributes,
      is_votable: this.votable == 'true',
    };
  },
  computed: {
    typeTitle() {
      return titleCase(this.type);
    },
    noVoteText() {
      return this.$t('submission_card.no_vote');
    },
    ...mapState(['votesLeft', 'loggedIn']),
    isVotable() {
      let votable = this.is_votable;
      let loggedIn = this.$store.state.loggedIn;
      let votesLeft = this.$store.state.votesLeft;
      let votedOn = this.attributes.voted_on;
      return (votedOn || votesLeft > 0) && votable && loggedIn;
    },
  },
  props: ['sub', 'type', 'votable'],
  methods: {
    visitPage() {
      window.location = this.attributes.sub_path;
    },
    toggleVote() {
      this.axios.post(this.attributes.vote_path).then(({data}) => {
        this.submission = data.data;
        this.attributes = data.data.attributes;
        this.setVotesLeft(data.meta.votes_left);
      });
    },
    ...mapMutations(['setVotesLeft']),
  },
};
</script>

<style lang="scss" scoped>
.clickable {
  cursor: pointer;
}
.active {
  color: red;
}
</style>
