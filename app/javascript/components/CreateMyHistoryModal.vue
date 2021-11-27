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
                v-model="addMyHistory.title"
                :class="{ 'error' : formError['title'] || formError['exists'] }"
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
                <li
                  v-else-if="!!formError['exists']"
                >
                  {{ formError['exists'][0] }}
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
  name: "CraetMyHistoryModal",
  data() {
    return {
      addMyHistory: {
        title: "",
      },
      formError: {},
    };
  },
  methods: {
    addMyHistoryTitle() {
      this.$store.dispatch("addMyHistoryTitle", this.addMyHistory)
        .then(() => {
          this.$emit("addMyHistorySuccess");
          this.formError = {};
          this.addMyHistory.title = "";
        })
        .catch((error) => {
          this.formError = error;
        });
    },
    cancelMyHistoryTitle() {
      this.$emit("cancelMyHistoryTitle");
      this.formError = {};
      this.addMyHistory.title = "";
    },
  }
};
</script>
