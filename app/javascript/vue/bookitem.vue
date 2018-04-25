<template lang="pug">
div(@click="openBook")
  b-card(:title="book.title",
          :img-src="book.cover_path",
          :img-alt="book.title",
          img-top,
          class="ml-1 mr1"
          tag="article")
    p(v-t='title')
</template>

<script>
export default {
  props: ['book', 'moving'],
  computed: {
    title() {
      return `book_carousel.${this.book.genre}.title`;
    },
  },
  methods: {
    openBook() {
      if (!this.moving) window.location = this.book.show_path;
    },
  },
};
</script>

<style lang="scss" scoped>
article {
  width: 12rem;
  min-height: 20rem;
  .card-title {
    font-size: 20px;
    font-size: 1.25rem;
  }
  img {
    border: 1px solid #343a40;
    border-right-width: 3px;
    height: 156px;
    width: 102px;
    margin: auto;
    margin-top: 15px;
  }
}
</style>
