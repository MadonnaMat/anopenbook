<template lang="pug">
  #test
    h1 Welcome
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
#test {
  p {
    font-size: 2em;
    text-align: center;
  }
}
</style>
