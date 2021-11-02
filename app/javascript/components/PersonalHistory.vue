<template>
  <div>
    <history-card
      @myHistoryFlagChange="myHistoryFlagChange"
      @editMyHistoryFlagChange="editMyHistoryFlagChange"
    />
    <edit-my-history-modal
      v-if="getMyHistory.title"
      :title="getMyHistory.title"
      :class="{ 'is-active': editHistoryModalFlag }"
      @editMyHistorySuccess="editMyHistoryFlagChange"
      @cancelEditMyHistoryTitle="editMyHistoryFlagChange"
    />
    <create-my-history-modal
      v-else
      :class="{ 'is-active': myHistoryModalFlag }"
      @addMyHistorySuccess="myHistoryFlagChange"
      @cancelMyHistoryTitle="myHistoryFlagChange"
    />
    <time-line-modal />
    <time-line />
    <profile-modal
      :class="{ 'is-active': profileModalFlag }"
      @updateProfileSuccess="profileModalFlagChange"
    />
  </div>
</template>

<script>
import HistoryCard from "./HistoryCard.vue";
import TimeLineModal from "./TimeLineModal.vue";
import TimeLine from "./TimeLine.vue";
import ProfileModal from "./ProfileModal.vue";
import CreateMyHistoryModal from "./CreateMyHistoryModal.vue";
import EditMyHistoryModal from "./EditMyHistoryModal.vue";

export default {
  name: "PersonalHistory",
  components: { HistoryCard, TimeLineModal, TimeLine, ProfileModal, CreateMyHistoryModal, EditMyHistoryModal },
  data() {
    return {
      profileModalFlag: false,
      myHistoryModalFlag: false,
      editHistoryModalFlag: false,
    };
  },
  computed: {
    getUserProfile: function() {
      return this.$store.getters.getUserProfile;
    },
    getMyHistory: function() {
      return this.$store.getters.getMyHistory;
    }
  },
  mounted() {
    this.$store.dispatch("getUserProfile").then(() => {
      this.profileAndTitleModalFlagChange();
    });
  },
  methods: {
    profileAndTitleModalFlagChange() {
      if(this.getUserProfile.birthday === null || this.getUserProfile.gender === null){
        this.profileModalFlag = !this.profileModalFlag;
      }else if(this.getMyHistory.title === null){
        this.myHistoryModalFlag = !this.myHistoryModalFlag;
      }
    },
    profileModalFlagChange() {
      this.profileModalFlag = !this.profileModalFlag;
      this.profileAndTitleModalFlagChange();
    },
    myHistoryFlagChange() {
      this.myHistoryModalFlag = !this.myHistoryModalFlag;
    },
    editMyHistoryFlagChange() {
      this.editHistoryModalFlag = !this.editHistoryModalFlag;
    }
  }
};
</script>
