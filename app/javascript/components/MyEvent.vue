<template>
  <li>
    <span v-if="isEdit">
      <input type="text" v-model="updatedEvent.title" />
      <button @click="handleSubmit">確定</button>
    </span>
    <span v-else>
      {{ event.title }}
      <button @click="isEdit = true">編集</button>
    </span>
  </li>
</template>

<script>
export default {
  name: "MyEvent",
  props: {
    event: Object,
  },
  created() {
    this.updatedEvent = this.event;
  },
  data() {
    return {
      isEdit: false,
      updatedEvent: {},
    };
  },
  methods: {
    handleSubmit() {
      this.isEdit = false;
      this.$emit("update", this.updatedEvent);
    },
  },
};
</script>
