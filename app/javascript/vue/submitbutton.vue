<template lang="pug">
b-button(v-if="loggedIn && linkView", v-t="{ path: 'submit_button.view', args: { type: typeTitle } }", :href="linkView" )
b-button(v-else-if="loggedIn && linkEdit", v-t="{ path: 'submit_button.edit', args: { type: typeTitle } }", :href="linkEdit") )
b-button(v-else-if="loggedIn", v-t="{ path: 'submit_button.submit', args: { type: typeTitle } }", :href="linkNew") )
</template>

<script>
import titleCase from 'voca/title_case';
import {mapState} from 'vuex';
import linkArray from './link_array';
export default {
  props: linkArray(['new', 'edit', 'view']).concat(['type']),
  computed: {
    typeTitle() {
      return titleCase(this.type);
    },
    ...mapState(['loggedIn']),
  },
};
</script>

<style lang="scss" scoped></style>
