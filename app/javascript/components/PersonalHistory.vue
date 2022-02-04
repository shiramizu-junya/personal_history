<template>
  <div>
    <graph
      :text-judgement-flag="textJudgementFlag"
      :graph-label="graphLabel"
      :graph-data="graphData"
      :graph-image-flag="graphImageFlag"
      @changeGraphImageFlag="changeGraphImageFlag"
    />
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
      @addEventSuccessGetGraphData="getGraphData"
      @addEventSuccess="addEventFlagChange"
    />
    <edit-event-modal
      :class="{ 'is-active' : editEventFlag }"
      :event="event"
      @editEventSuccessGetGraphData="getGraphData"
      @editEventSuccess="editEventFlagChange"
      @canselEditEvent="editEventFlagChange"
    />
    <time-line
      v-if="timeLineFlag"
      :text-judgement-flag="textJudgementFlag"
      @editEventFlagChange="editEventFlagChange"
      @deleteEventSuccessGetGraphData="getGraphData"
      @deleteEventSuccess="changeTimeLineFlag"
    />
    <profile-modal
      :class="{ 'is-active': profileModalFlag }"
      @updateProfileSuccess="profileModalFlagChange"
    />
  </div>
</template>

<script>
import Graph from "./Graph.vue";
import HistoryCard from "./HistoryCard.vue";
import ProfileModal from "./ProfileModal.vue";
import CreateMyHistoryModal from "./CreateMyHistoryModal.vue";
import EditMyHistoryModal from "./EditMyHistoryModal.vue";
import TimeLine from "./TimeLine.vue";
import AddEventModal from "./AddEventModal.vue";
import EditEventModal from "./EditEventModal.vue";
import _ from "lodash";
import axios from "axios";

export default {
  name: "PersonalHistory",
  components: {
    Graph,
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
      textJudgementFlag: true,
      graphImageFlag: false,
      event: {
        data: {},
        key: null,
        index: null,
      },
      graphLabel: [],
      graphData: [],
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
    // 新規作成 or 編集で取得するデータを変える
    let last_path_name = window.location.pathname.split("/").pop();
    if(last_path_name === "edit"){
      this.$store.dispatch("getMyHistory").then((graph_data) => {
        this.graphLabel = Object.keys(graph_data);
        this.graphData = Object.values(graph_data);
        this.changeTimeLineFlag();
      });
      this.textJudgementFlag = false;
    }
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
    },
    getGraphData() {
      axios.get("/api/my_history/graph_data").then((response) => {
        this.graphLabel = Object.keys(response.data);
        this.graphData = Object.values(response.data);
        this.graphImageFlag = true;
      });
    },
    changeGraphImageFlag() {
      this.graphImageFlag = false;
    }
  }
};
</script>

<style>
.modal-card-title {
  color: #272343;
  font-weight: 700;
}
</style>
