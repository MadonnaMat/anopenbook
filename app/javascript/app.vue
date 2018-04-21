<template lang="pug">
  b-container-fluid.test
    b-row
      b-col
        h1 Welcome
      b-col(col, lg="2")
        p {{ message }}
</template>

<script>
export default {
  data: function() {
    return {
      message: 'Hello Vue!',
    };
  },
};
</script>

<style lang="scss" scoped>
.test {
  p {
    font-size: 2em;
  }
}
</style>
