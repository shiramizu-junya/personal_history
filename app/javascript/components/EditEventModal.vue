<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="canselEditEvent"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          イベント編集
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">年齢</label>
            <div class="control">
              <input
                v-model="editEvent.age"
                class="input"
                type="number"
                name="age"
              >
            </div>
          </div>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-model="editEvent.title"
                class="input"
                type="text"
                name="title"
              >
            </div>
          </div>
          <div class="field">
            <label class="label">エピソード</label>
            <div class="control">
              <textarea
                v-model="editEvent.episode"
                class="textarea"
                name="episode"
              />
            </div>
          </div>
          <div class="field">
            <label class="label">充実度</label>
            <div class="control">
              <input
                v-model="editEvent.happiness"
                class="input"
                type="number"
                name="happiness"
              >
            </div>
          </div>
        </form>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success"
        >
          更新
        </button>
        <button
          class="button"
          @click="canselEditEvent"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "EditEventModal",
  props: {
    event:
    {
      type: Object,
      required: true,
    }
  },
  data() {
    return {
      editEvent: {}
    };
  },
  watch: {
    event: function(newEvent){
      this.editEvent = newEvent;
    }
  },
  methods: {
    canselEditEvent() {
      this.$emit("canselEditEvent");
    }
  }
};
</script>
