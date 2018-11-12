<template lang="pug">
  b-container.mt-5
    b-row
      b-col(cols="12")
        div(class="row", v-infinite-scroll="loadMore", infinite-scroll-disabled="busy", infinite-scroll-distance="10")
          submissioncard(v-for="submission in submissions", :sub="submission", :type="type", :votable="votable")
        b-row.justify-content-md-center(v-if="busyAndIncomplete")
          icon(name="spinner" scale="7" spin)

</template>

<script>
import Submissioncard from 'vue/submissioncard.vue';
export default {
  data() {
    return {
      page: 1,
      submissions: JSON.parse(this.first_page || '{}').data || [],
      complete: this.init_complete,
      moving: false,
      busy: false,
    };
  },
  components: {
    Submissioncard,
  },
  props: ['type', 'first_page', 'init_complete', 'linkGet', 'votable'],
  computed: {
    busyAndIncomplete() {
      return this.busy && !this.complete;
    },
  },
  methods: {
    loadMore() {
      this.busy = true;
      this.page += 1;

      if (!this.complete) {
        this.axios
          .get(this.linkGet, {
            params: {
              page: this.page,
            },
          })
          .then(returned => {
            let {data, meta} = returned.data;
            this.complete = meta.last;
            this.submissions = this.submissions.concat(data);
            this.busy = this.complete;
          });
      }
    },
  },
};
</script>

<style lang="scss" scoped></style>
