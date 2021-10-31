<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="timeLineModalFlagChange"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          イベント追加
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">年齢</label>
            <div class="control">
              <input
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
                class="textarea"
                name="episode"
              />
            </div>
          </div>
          <div class="field">
            <label class="label">充実度</label>
            <div class="control">
              <input
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
          @click="addTimeLine"
        >
          追加
        </button>
        <button
          class="button"
          @click="timeLineModalFlagChange"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "TimeLineModal",
  data() {
    return{
      timeline: {
        age: "",
        title: "",
        episode: "",
        happiness: "",
      },
      formError: {},
    };
  },
  methods: {
    timeLineModalFlagChange() {
      this.$emit("timeLineModalFlagChange");
    },
    addTimeLine() {
      this.$store.dispatch("addTimeLine", this.timeline)
        .then(() => {
          this.timeline.age = "";
          this.timeline.title = "";
          this.timeline.episode = "";
          this.timeline.happiness = "";
          this.formError = {};
          this.$emit("addTimeLine");
        })
        .catch((error) => {
          this.formError = error;
        });
    }
  }
};
</script>
