<template>
  <div class="modal">
    <div class="modal-background" />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          プロフィール編集
        </p>
      </header>
      <section class="modal-card-body">
        <form>
          <div class="field">
            <label class="label">生年月日</label>
            <div class="control">
              <input
                v-model="profile.birthday"
                :class="{ 'error' : formError['birthday'] }"
                class="input"
                type="date"
                name="birthday"
              >
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['birthday']"
                >
                  {{ formError["birthday"][0] }}
                </li>
              </ul>
            </div>
          </div>
          <div class="field">
            <label class="label">性別</label>
            <div class="control">
              <label class="radio">
                <input
                  v-model="profile.gender"
                  :class="{ 'error' : formError['gender'] }"
                  value="men"
                  type="radio"
                  name="gender"
                >
                男性
              </label>
            </div>
            <div class="control">
              <label class="radio">
                <input
                  v-model="profile.gender"
                  :class="{ 'error' : formError['gender'] }"
                  value="women"
                  type="radio"
                  name="gender"
                >
                女性
              </label>
            </div>
            <div class="control">
              <label class="radio">
                <input
                  v-model="profile.gender"
                  :class="{ 'error' : formError['gender'] }"
                  value="no_answer"
                  type="radio"
                  name="gender"
                >
                未回答
              </label>
            </div>
            <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!formError['gender']"
                >
                  {{ formError["gender"][0] }}
                </li>
              </ul>
            </div>
          </div>
        </form>
      </section>
      <footer class="modal-card-foot">
        <!-- <button
          class="button is-success"
          @click="profileSubmit"
        > -->
        <button
          class="button is-success"
          @click="updateProfile"
        >
          更新
        </button>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  name: "ProfileModal",
  // props: {
  //   profiles: {
  //     type: Object,
  //     required: true
  //   },
  //   errors: {
  //     type: Object,
  //     required: true
  //   }
  // },
  data() {
    return {
      profile: {
        birthday: "",
        gender: ""
      },
      formError: {},
    };
  },
  // created() {
  //   this.userProfiles = this.profiles;
  // },
  methods: {
    updateProfile() {
      this.$store.dispatch("updateProfile", this.profile)
        .then(() => {
          this.profile.birthday = "";
          this.profile.gender = "";
          this.formError = {};
          this.$emit("updateProfileSuccess");
        })
        .catch((error) => {
          this.formError = error;
        });
    }
  }
};
</script>
