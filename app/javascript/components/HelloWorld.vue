<template>
  <div class="hello">
    <ul>
      <my-event
        v-for="event in events"
        :key="event.id"
        :event="event"
        @update="update"
      />
    </ul>
    <my-form
      v-if="isNewFormShown"
      @add="add"
    />
    <button
      type="button"
      @click="isNewFormShown = true"
    >
      追加
    </button>
  </div>
</template>

<script>
import MyForm from "./MyForm";
import MyEvent from "./MyEvent";

export default {
  name: "HelloWorld",
  components: { MyForm, MyEvent },
  data() {
    return {
      isNewFormShown: false,
      events: [
        { id: 1, title: "aaa" },
        { id: 2, title: "bbb" },
        { id: 3, title: "ccc" },
      ],
    };
  },
  methods: {
    update(updatedEvent) {
      alert("ここでPATCH");
      const index = this.events.findIndex(
        (event) => event.id === updatedEvent.id
      );
      this.events[index] = updatedEvent;
    },
    add(event) {
      alert("ここでPOST");
      this.events.push(event);
      this.isNewFormShown = false;
    },
  },
};
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
