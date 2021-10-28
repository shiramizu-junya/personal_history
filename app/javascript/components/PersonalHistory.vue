<template>
  <div>
    <!-- <history-card
      v-if="profiles != null"
      :profiles="profiles"
    /> -->
    <history-card />
    <time-line-modal />
    <time-line />
    <!-- <profile-modal
      v-if="profiles != null"
      :profiles="profiles"
      :errors="errors"
      :class="{ 'is-active': profileModalToggleFlug }"
      @profileUpdate="profileUpdate"
    /> -->
    <profile-modal
      :class="{ 'is-active': profileModalFlag }"
    />
  </div>
</template>

<script>
import HistoryCard from "./HistoryCard.vue";
import TimeLineModal from "./TimeLineModal.vue";
import TimeLine from "./TimeLine.vue";
import ProfileModal from "./ProfileModal.vue";

export default {
  name: "PersonalHistory",
  components: { HistoryCard, TimeLineModal, TimeLine, ProfileModal },
  data() {
    return {
      profileModalFlag: false,
    };
  },
  computed: {
    getUserProfile: function() {
      return this.$store.getters.getUserProfile;
    }
  },
  mounted() {
    this.$store.dispatch("getUserProfile").then(() => {
      this.profileModalFlagChange();
    });
  },
  methods: {
    profileModalFlagChange() {
      if(this.getUserProfile.birthday === null || this.getUserProfile.gender === null){
        this.profileModalFlag = !this.profileModalFlag;
      }
    },
  //   profileUpdate() {
  //     this.axios.patch("/api/profile",{
  //       birthday: this.profiles.birthday,
  //       gender: this.profiles.gender
  //     })
  //       .then((response) => {
  //         this.profiles.birthday = response.data.birthday;
  //         this.profileModalToggleFlug = false;
  //       })
  //       .catch((error) => {
  //         if (error.response.data && error.response.data.errors) {
  //           this.errors = error.response.data.errors;
  //         }
  //       });
  //   }
  }
};
</script>
