<template lang="pug">
b-button(v-if="loggedIn", v-t="{ path: 'submit_button.submit', args: { type: typeTitle } }", :href="linkNew")
</template>

<script>
import titleCase from 'voca/title_case';
import {mapState} from 'vuex';
import linkArray from './link_array';
export default {
  props: linkArray(['new']).concat(['type']),
  computed: {
    typeTitle() {
      return titleCase(this.type);
    },
    ...mapState(['loggedIn']),
  },
};
</script>

<style lang="scss" scoped>
</style>
