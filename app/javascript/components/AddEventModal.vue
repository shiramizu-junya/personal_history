<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="canselAddEvent"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          出来事を追加
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-model="addEvent.title"
                :class="{ 'error' : formError['title'] }"
                class="input"
                type="text"
                name="title"
                placeholder="出来事のタイトルを入力してください"
              >
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="formError['title']"
                >
                  {{ formError["title"][0] }}
                </li>
              </ul>
            </div>
          </div>

          <div class="columns is-mobile">
            <div class="column">
              <div class="field">
                <label class="label">年齢</label>
                <div class="control">
                  <input
                    v-model="addEvent.age"
                    :class="{ 'error' : formError['age'] }"
                    class="input"
                    type="number"
                    name="age"
                    placeholder="出来事が起こった年齢は？"
                  >
                </div>
                <p class="help">
                  現在年齢より過去の年齢を入力してください。
                </p>
                <div class="has-text-danger">
                  <ul>
                    <li
                      v-if="formError['age']"
                    >
                      {{ formError["age"][0] }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="column">
              <div class="field">
                <label class="label">充実度</label>
                <div class="control">
                  <input
                    v-model="addEvent.happiness"
                    :class="{ 'error' : formError['happiness'] }"
                    class="input"
                    type="number"
                    name="happiness"
                    placeholder="どれぐらい充実していた？"
                  >
                </div>
                <p class="help">
                  100% 〜 -100%まで入力できます。
                </p>
                <div class="has-text-danger">
                  <ul>
                    <li
                      v-if="formError['happiness']"
                    >
                      {{ formError["happiness"][0] }}
                    </li>
                  </ul>
                </div>
              </div>
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
                placeholder="出来事のエピソードを入力してください"
              />
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="formError['episode']"
                >
                  {{ formError["episode"][0] }}
                </li>
              </ul>
            </div>
          </div>
        </form>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success"
          @click="addMyHistoryEvent"
        >
          追加
        </button>
        <button
          class="button"
          @click="canselAddEvent"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "AddEventModal",
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
    addMyHistoryEvent() {
      this.$store.dispatch("addMyHistoryEvent", this.addEvent)
        .then(() => {
          this.addEvent["age"] = "";
          this.addEvent["title"] = "";
          this.addEvent["episode"] = "";
          this.addEvent["happiness"] = "";
          this.formError = {};
          this.$emit("addEventSuccessGetGraphData");
          this.$emit("addEventSuccess");
        })
        .catch((error) => {
          this.formError = error;
        });
    },
    canselAddEvent() {
      this.addEvent.age = "";
      this.addEvent.title = "";
      this.addEvent.episode = "";
      this.addEvent.happiness = "";
      this.formError = {};
      this.$emit("canselAddEvent");
    },
  }
};
</script>
