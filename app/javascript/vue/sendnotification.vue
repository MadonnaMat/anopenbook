<template lang="pug">
</template>

<script>
export default {
  props: ['flashes'],
  mounted() {
    let flashes = JSON.parse(this.flashes);
    this.$nextTick(() => {
      flashes.forEach(flash => {
        let type = 'success';
        if (flash[0] == 'alert' || flash[0] == 'error') {
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
