<template>
  <div>
    <div class="columns my-6 is-centered is-mobile">
      <div class="column pd-sm is-10-mobile is-three-quarters-tablet is-two-fifths-desktop is-two-thirds-widescreen is-half-fullhd">
        <h1 class="title has-text-centered mb-5">
          自分史作成
        </h1>
        <div class="card">
          <header class="card-header">
            <h4 class="card-header-title title is-4">
              <span class="icon mr-1">
                <i class="fas fa-tag" />
              </span>
              自分史タイトル
            </h4>
          </header>
          <div class="card-content">
            <p class="title">
              {{ getMyHistory.title ? getMyHistory.title : getUserProfile.name + "さんの自分史" }}
            </p>
            <p class="subtitle">
              <span class="card">
                <i class="fas fa-user" />
              </span>
              現在の年齢：{{ getUserProfile.birthday ? calcAge(getUserProfile.birthday) : "" }}歳
            </p>
          </div>
          <footer class="card-footer">
            <p class="card-footer-item">
              <button
                v-if="getMyHistory.title"
                class="button is-edit-title"
                @click="editMyHistoryFlagChange"
              >
                タイトル編集
              </button>
              <button
                v-else
                class="button is-edit-title"
                @click="myHistoryFlagChange"
              >
                タイトル追加
              </button>
            </p>
            <p
              v-if="getMyHistory.title"
              class="card-footer-item"
            >
              <button
                class="button is-add-event"
                @click="addEventFlagChange"
              >
                イベント追加
              </button>
            </p>
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: "HistoryCard",
  computed: {
    getUserProfile: function() {
      return this.$store.getters.getUserProfile;
    },
    getMyHistory: function() {
      return this.$store.getters.getMyHistory;
    }
  },
  methods: {
    myHistoryFlagChange() {
      this.$emit("myHistoryFlagChange");
    },
    editMyHistoryFlagChange() {
      this.$emit("editMyHistoryFlagChange");
    },
    addEventFlagChange() {
      this.$emit("addEventFlagChange");
    },
    // 生年月日から年齢を計算するためのフォーマットの修正
    formatDate(value) {
      const y = value.getFullYear();
      const m = ("00" + (value.getMonth() + 1)).slice(-2);
      const d = ("00" + value.getDate()).slice(-2);
      return y + m + d;
    },
    // 生年月日から年齢を計算
    calcAge(value){
      const today = new Date();
      const formated_today = this.formatDate(today);
      const birth = value.replace(/-/g, "");
      return Math.floor((parseInt(formated_today) - parseInt(birth)) / 10000);
    },
  }
};
</script>
