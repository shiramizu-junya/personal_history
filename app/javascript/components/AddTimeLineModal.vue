<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="canselAddTimeLine"
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
                v-model="addEvent.age"
                :class="{ 'error' : formError['age'] }"
                class="input"
                type="number"
                name="age"
              >
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['age']"
                >
                  {{ formError["age"][0] }}
                </li>
              </ul>
            </div>
          </div>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-model="addEvent.title"
                :class="{ 'error' : formError['title'] }"
                class="input"
                type="text"
                name="title"
              >
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['title']"
                >
                  {{ formError["title"][0] }}
                </li>
              </ul>
            </div>
          </div>
          <div class="field">
            <label class="label">エピソード</label>
            <div class="control">
              <textarea
                v-model="addEvent.episode"
                :class="{ 'error' : formError['episode'] }"
                class="textarea"
                name="episode"
              />
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['episode']"
                >
                  {{ formError["episode"][0] }}
                </li>
              </ul>
            </div>
          </div>
          <div class="field">
            <label class="label">充実度</label>
            <div class="control">
              <input
                v-model="addEvent.happiness"
                :class="{ 'error' : formError['happiness'] }"
                class="input"
                type="number"
                name="happiness"
              >
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['happiness']"
                >
                  {{ formError["happiness"][0] }}
                </li>
              </ul>
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
          @click="canselAddTimeLine"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "AddTimeLineModal",
  data() {
    return{
      addEvent: {
        age: "",
        title: "",
        episode: "",
        happiness: "",
      },
      formError: {},
    };
  },
  methods: {
    addTimeLine() {
      this.$store.dispatch("addTimeLine", this.addEvent)
        .then(() => {
          for (let key in this.addEvent) {
            this.addEvent[key] = "";
          }
          this.formError = {};
          this.$emit("addTimeLineSuccess");
        })
        .catch((error) => {
          this.formError = error;
          console.log(this.formError);
        });
    },
    canselAddTimeLine() {
      for (let key in this.addEvent) {
        this.addEvent[key] = "";
      }
      this.formError = {};
      this.$emit("canselAddTimeLine");
    },
  }
};
</script>
