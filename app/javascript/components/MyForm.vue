<template>
  <div>
    <form>
      <label>タイトル</label>
      <input type="text" v-model="event.title" />
      <button type="button" @click.stop="handleClick">登録</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      event: {
        title: null,
      },
    };
  },
  methods: {
    handleClick() {
      this.$emit("add", this.event);
    },
  },
};
</script>
