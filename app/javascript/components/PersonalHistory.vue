<template>
  <div>
    <history-card
      @myHistoryFlagChange="myHistoryFlagChange"
      @editMyHistoryFlagChange="editMyHistoryFlagChange"
      @addEventFlagChange="addEventFlagChange"
    />
    <edit-my-history-modal
      v-if="getMyHistory.title"
      :class="{ 'is-active' : editHistoryModalFlag }"
      @editMyHistorySuccess="editMyHistoryFlagChange"
      @cancelEditMyHistoryTitle="editMyHistoryFlagChange"
    />
    <create-my-history-modal
      v-else
      :class="{ 'is-active' : myHistoryModalFlag }"
      @addMyHistorySuccess="myHistoryFlagChange"
      @cancelMyHistoryTitle="myHistoryFlagChange"
    />
    <add-event-modal
      :class="{ 'is-active' : addEventFlag }"
      @canselAddEvent="addEventFlagChange"
      @addEventSuccess="addEventFlagChange"
    />
    <edit-event-modal
      :class="{ 'is-active' : editEventFlag }"
      :event="event"
      @editEventSuccess="editEventFlagChange"
      @canselEditEvent="editEventFlagChange"
    />
    <time-line
      v-if="timeLineFlag"
      @editEventFlagChange="editEventFlagChange"
      @deleteEventSuccess="changeTimeLineFlag"
    />
    <profile-modal
      :class="{ 'is-active': profileModalFlag }"
      @updateProfileSuccess="profileModalFlagChange"
    />
  </div>
</template>

<script>
import HistoryCard from "./HistoryCard.vue";
import ProfileModal from "./ProfileModal.vue";
import CreateMyHistoryModal from "./CreateMyHistoryModal.vue";
import EditMyHistoryModal from "./EditMyHistoryModal.vue";
import TimeLine from "./TimeLine.vue";
import AddEventModal from "./AddEventModal.vue";
import EditEventModal from "./EditEventModal.vue";
import _ from "lodash";

export default {
  name: "PersonalHistory",
  components: {
    HistoryCard,
    ProfileModal,
    CreateMyHistoryModal,
    EditMyHistoryModal,
    TimeLine,
    AddEventModal,
    EditEventModal,
  },
  data() {
    return {
      profileModalFlag: false,
      myHistoryModalFlag: false,
      editHistoryModalFlag: false,
      timeLineFlag: false,
      addEventFlag: false,
      editEventFlag: false,
      event: {
        data: {},
        key: null,
        index: null,
      },
    };
  },
  computed: {
    getUserProfile: function() {
      return this.$store.getters.getUserProfile;
    },
    getMyHistory: function() {
      return this.$store.getters.getMyHistory;
    },
    getEvents: function() {
      return this.$store.getters.getEvents;
    },
  },
  mounted() {
    this.$store.dispatch("getUserProfile").then(() => {
      this.profileAndTitleModalFlagChange();
    });

    this.$store.dispatch("getCategory").then(() => {
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
    },
    addEventFlagChange() {
      this.addEventFlag = !this.addEventFlag;
      this.changeTimeLineFlag();
    },
    changeTimeLineFlag() {
      if(this.$store.getters.getEventsCount){
        this.timeLineFlag = true;
      }else{
        this.timeLineFlag = false;
      }
    },
    editEventFlagChange(key, index, flag = false) {
      if(flag){
        // lodashのcloneDeepによりオブジェクトをコピーにより「参照渡し」を「根渡し」に変える
        this.event = { ...this.event, data: _.cloneDeep(this.getEvents[key].data[index]), key: key, index: index };
      }
      this.editEventFlag = !this.editEventFlag;
    }
  }
};
</script>
