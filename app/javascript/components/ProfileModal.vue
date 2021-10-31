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
            <div
              class="select"
              :class="{ 'error' : formError['birthday'] }"
            >
              <select
                id="user_gender"
                v-model="profile.gender"
                name="gender"
              >
                <option
                  v-for="gender in genders"
                  :key="gender.value"
                  :value="gender.value"
                >
                  {{ gender.text }}
                </option>
              </select>
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
  data() {
    return {
      profile: {
        birthday: "",
        gender: ""
      },
      genders: [
        { text: "選択してください", value: "" },
        { text: "男性", value: "men" },
        { text: "女性", value: "women" },
        { text: "その他", value: "other" },
        { text: "未回答", value: "no_answer" },
      ],
      formError: {},
    };
  },
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
