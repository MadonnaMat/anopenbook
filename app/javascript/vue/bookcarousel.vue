<template lang="pug">
  b-container.mt-5
    b-row.justify-content-md-center
      b-col(cols="10")
        h2(v-t="title")
        slick(ref="slick", :options="slickOptions")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")
          img(:src="randomSrc")

</template>

<script>
import Slick from 'vue-slick';
export default {
  data() {
    return {
      slickOptions: {
        slidesToShow: 6,
        slidesToScroll: 6,
        infinite: false,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 5,
              slidesToScroll: 5,
            },
          },
          {
            breakpoint: 850,
            settings: {
              slidesToShow: 4,
              slidesToScroll: 4,
            },
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 3,
            },
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2,
            },
          },
        ],
      },
    };
  },
  props: ['type'],
  components: {Slick},
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
  methods: {},
};
</script>

<style lang="scss" scoped>
.slick-slider /deep/ {
  .slick-slide > div > * {
    padding: 10px;
  }
}
</style>
