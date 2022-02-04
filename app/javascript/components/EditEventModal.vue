<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="canselEditEvent"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          出来事の編集
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="columns is-mobile">
            <div class="column">
              <div class="field">
                <label class="label">年齢</label>
                <div class="control">
                  <input
                    v-if="editEventTarget.data"
                    v-model="editEventTarget.data.age"
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
                      v-if="!!formError['age']"
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
                    v-if="editEventTarget.data"
                    v-model="editEventTarget.data.happiness"
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
                      v-if="!!formError['happiness']"
                    >
                      {{ formError["happiness"][0] }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-if="editEventTarget.data"
                v-model="editEventTarget.data.title"
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
                v-if="editEventTarget.data"
                v-model="editEventTarget.data.episode"
                :class="{ 'error' : formError['episode'] }"
                class="textarea"
                name="episode"
                placeholder="出来事のエピソードを入力してください"
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
        </form>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success"
          @click="editEvent"
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
    },
  },
  data() {
    return {
      editEventTarget: {},
      formError: {}
    };
  },
  watch: {
    event: function(newEvent){
      this.editEventTarget = newEvent;
    }
  },
  methods: {
    editEvent() {
      this.$store.dispatch("editEvent", this.editEventTarget)
        .then(() => {
          this.formError = {};
          this.$emit("editEventSuccessGetGraphData");
          this.$emit("editEventSuccess");
        })
        .catch((error) => {
          this.formError = error;
        });
    },
    canselEditEvent() {
      this.formError = {};
      this.$emit("canselEditEvent");
    }
  }
};
</script>
