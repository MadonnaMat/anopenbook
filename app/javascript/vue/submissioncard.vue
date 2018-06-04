<template lang="pug">
  b-card(class="w-100 mb-4")
    b-row
      b-col(cols="1" align-self="center")
        icon(v-if="is_votable" name="arrow-up" scale="2")
        icon(v-else name="arrow-up" scale="2" class="text-muted", v-b-popover.hover="noVoteText")
      b-col(cols="5" v-on:click="visitPage", class="clickable")
        h4 {{submission.title}}
        h5(v-t="{ path: 'submission_card.user', args: { type: typeTitle, username: submission.author } }")
      b-col(cols="6" v-on:click="visitPage", class="clickable")
        p(v-html="submission.shortend_body")
</template>

<script>
import titleCase from 'voca/title_case';
export default {
  data() {
    return {
      submission: this.sub,
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
  },
  props: ['sub', 'type', 'votable'],
  methods: {
    visitPage() {
      window.location = this.submission.sub_path;
    },
  },
};
</script>

<style lang="scss" scoped>
.clickable {
  cursor: pointer;
}
</style>
