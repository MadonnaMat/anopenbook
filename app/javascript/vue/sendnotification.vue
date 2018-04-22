<template lang="pug">
</template>

<script>
export default {
  props: ['flashes'],
  mounted() {
    let flashes = JSON.parse(this.flashes);
    this.$nextTick(() => {
      console.log(this.$notifiy);
      flashes.forEach(flash => {
        let type = 'success';
        if (flash[0] == 'alert') {
          type = 'error';
        }
        this.$notify({
          text: flash[1],
          type: type,
          duration: -1,
          width: '500px',
        });
      });
    });
  },
};
</script>
