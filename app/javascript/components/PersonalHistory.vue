<template>
  <div>
    <history-card
      v-if="profiles != null"
      :profiles="profiles"
    />
    <!-- <time-line-modal /> -->
    <time-line />
    <profile-modal
      v-if="profiles != null"
      :profiles="profiles"
      :errors="errors"
      :class="{ 'is-active': profileModalToggleFlug }"
      @profileUpdate="profileUpdate"
    />
  </div>
</template>

<script>
// import axios from "axios";
import HistoryCard from "./HistoryCard.vue";
// import TimeLineModal from "./TimeLineModal.vue";
import TimeLine from "./TimeLine.vue";
import ProfileModal from "./ProfileModal.vue";

export default {
  name: "HelloWorld",
  components: { HistoryCard, TimeLine, ProfileModal },
  data() {
    return {
      profiles: null,
      profileModalToggleFlug: false,
      errors: {}
    };
  },
  created() {
    this.axios.get("/api/profile")
      .then(response => {
        this.profiles = response.data;
        this.profileModalToggleChange();
      })
      .catch(error => console.log(error)); // エラー時にどのように対応するか検討
  },
  methods: {
    profileModalToggleChange() {
      if(this.profiles.birthday === null || this.profiles.gender === null){
        this.profileModalToggleFlug = true;
      }
    },
    profileUpdate() {
      this.axios.patch("/api/profile",{
        birthday: this.profiles.birthday,
        gender: this.profiles.gender
      })
        .then((response) => {
          this.profiles.birthday = response.data.birthday;
          this.profileModalToggleFlug = false;
        })
        .catch((error) => {
          console.log(error.response);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
};
</script>
