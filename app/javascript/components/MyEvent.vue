<template>
  <li>
    <span v-if="isEdit">
      <input
        v-model="updatedEvent.title"
        type="text"
      >
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
    event: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      isEdit: false,
      updatedEvent: {},
    };
  },
  created() {
    this.updatedEvent = this.event;
  },
  methods: {
    handleSubmit() {
      this.isEdit = false;
      this.$emit("update", this.updatedEvent);
    },
  },
};
</script>
