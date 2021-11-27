<template>
  <div class="modal">
    <div
      class="modal-background"
      @click="cancelEditMyHistoryTitle"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          タイトル編集
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <input
                v-model="editMyHistory.title"
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
          @click="editMyHistoryTitle"
        >
          更新
        </button>
        <button
          class="button"
          @click="cancelEditMyHistoryTitle"
        >
          キャンセル
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "EditMyHistoryModal",
  data() {
    return {
      editMyHistory: {
        title: "",
      },
      formError: {},
    };
  },
  computed: {
    getMyHistory: function() {
      return this.$store.getters.getMyHistory;
    }
  },
  created() {
    this.editMyHistory.title = this.getMyHistory.title;
  },
  methods: {
    editMyHistoryTitle() {
      this.$store.dispatch("editMyHistoryTitle", this.editMyHistory)
        .then((response) => {
          this.formError = {};
          this.editMyHistory.title = response.title;
          this.$emit("editMyHistorySuccess");
        })
        .catch((error) => {
          this.formError = error;
        });
    },
    cancelEditMyHistoryTitle() {
      this.formError = {};
      this.editMyHistory.title = this.getMyHistory.title;
      this.$emit("cancelEditMyHistoryTitle");
    },
  }
};
</script>
