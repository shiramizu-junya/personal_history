<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="cancelMyHistoryTitle"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          タイトル追加
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-model="myHistory.title"
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
        </form>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button is-success"
          @click="addMyHistoryTitle"
        >
          追加
        </button>
        <button
          class="button"
          @click="cancelMyHistoryTitle"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "MyHistoryModal",
  data() {
    return {
      myHistory: {
        title: "",
      },
      formError: {},
    };
  },
  methods: {
    addMyHistoryTitle() {
      this.$store.dispatch("addMyHistoryTitle", this.myHistory)
        .then(() => {
          this.myHistory.title = "";
          this.formError = {};
          this.$emit("addMyHistorySuccess");
        })
        .catch((error) => {
          this.formError = error;
        });
    },
    cancelMyHistoryTitle() {
      this.$emit("cancelMyHistoryTitle");
    }
  }
};
</script>
