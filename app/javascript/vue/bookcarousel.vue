<template lang="pug">
  b-container.mt-5
    b-row.justify-content-md-center
      b-col(cols="10")
        h2(v-t="title")
        slick(ref="slick", :options="slickOptions",
        @beforeChange='handleBeforeChange',
        @afterChange='handleAfterChange')
          bookitem(v-for="book in books", :book="book", :moving='moving')

</template>

<script>
import Bookitem from './bookitem.vue';
import Slick from 'vue-slick';
export default {
  data() {
    return {
      slickOptions: {
        slidesToShow: 4,
        infinite: false,
        variableWidth: true,
        responsive: [
          {
            breakpoint: 850,
            settings: {
              slidesToShow: 3,
            },
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 2,
            },
          },
        ],
      },
      page: 2,
      onPage: 0,
      onBook: 0,
      books: JSON.parse(this.first_pages || '[]'),
      complete: this.init_complete,
      moving: false,
    };
  },
  props: ['type', 'first_pages', 'init_complete', 'linkGet'],
  components: {Slick, Bookitem},
  computed: {
    randomSrc() {
      var text = '';
      var possible =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

      for (var i = 0; i < 5; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

      return `https://api.adorable.io/avatars/55/${text}`;
    },
    title() {
      return `book_carousel.${this.type}.title`;
    },
  },
  methods: {
    handleBeforeChange(e, s, currBook, nextBook) {
      this.onBook = nextBook;
      this.moving = true;
    },
    handleAfterChange() {
      this.checkAjax();
      this.moving = false;
    },
    checkAjax() {
      if (this.linkGet && !this.complete) {
        let nextAjax = this.onPage * 4 + 2;
        if (nextAjax == this.onBook) {
          if (this.page <= this.onPage + 2) {
            this.axios
              .get(this.linkGet, {
                params: {
                  page: this.page,
                  type: this.type,
                },
              })
              .then(({data}) => {
                let {books, last} = data;
                this.complete = last;
                this.$refs.slick.destroy();
                this.page += 1;
                this.books = this.books.concat(books);
                this.$nextTick(() => {
                  this.$refs.slick.create();
                  this.$nextTick(() =>
                    this.$refs.slick.goTo(this.onBook, true),
                  );
                });
              });
          }
        } else {
          if (this.onBook % 4 == 0) {
            this.onPage = this.onBook / 4;
          }
        }
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.slick-slider /deep/ {
  .slick-slide > div > * {
    padding: 10px;
  }
}
</style>
