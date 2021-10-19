<template>
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
            佐藤さんの自分史
          </p>
          <p class="subtitle">
            <span class="card">
              <i class="fas fa-user" />
            </span>
            現在の年齢：{{ userProfiles.birthday ? calcAge(userProfiles.birthday ) : "" }}歳
          </p>
        </div>
        <footer class="card-footer">
          <p class="card-footer-item">
            <button class="button is-edit-title">
              タイトル編集
            </button>
          </p>
          <p class="card-footer-item">
            <button
              class="button is-add-event"
              @click="isTimeLineModalShown = true"
            >
              イベント追加
            </button>
          </p>
          <!-- タイムラインモーダル -->
          <time-line-modal
            :class="{ 'is-active': isTimeLineModalShown }"
            @canselEvent="canselEvent"
            @addEvent="addEvent"
          />
        </footer>
      </div>
    </div>
  </div>
</template>

<script>
import TimeLineModal from "./TimeLineModal.vue";

export default {
  name: "HistoryCard",
  components: { TimeLineModal },
  props: {
    profiles: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      isTimeLineModalShown: false,
      userProfiles: null,
    };
  },
  created() {
    this.userProfiles = this.profiles;
  },
  methods: {
    canselEvent() {
      this.isTimeLineModalShown = false;
    },
    addEvent(event) {
      console.log(event);
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
    }
  }
};
</script>
