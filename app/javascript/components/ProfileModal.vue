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
              <!-- <input
                v-model="userProfiles.birthday"
                :class="{ 'error': errors['birthday'] }"
                class="input"
                type="date"
                name="birthday"
              > -->
              <input
                class="input"
                type="date"
                name="birthday"
              >
            </div>
            <!-- <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!errors['birthday']"
                >
                  {{ errors["birthday"][0] }}
                </li>
              </ul>
            </div> -->
          </div>
          <div class="field">
            <label class="label">性別</label>
            <div class="control">
              <label class="radio">
                <!-- <input
                  v-model="userProfiles.gender"
                  value="men"
                  type="radio"
                  name="men"
                > -->
                <input
                  value="men"
                  type="radio"
                  name="men"
                >
                男性
              </label>
            </div>
            <div class="control">
              <label class="radio">
                <!-- <input
                  v-model="userProfiles.gender"
                  value="women"
                  type="radio"
                  name="women"
                > -->
                <input
                  value="women"
                  type="radio"
                  name="women"
                >
                女性
              </label>
            </div>
            <!-- <div class="has-text-danger">
              <ul>
                <li
                  v-if="!!errors['gender']"
                >
                  {{ errors["gender"][0] }}
                </li>
              </ul>
            </div> -->
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
  // data() {
  //   return {
  //     userProfiles: null,
  //   };
  // },
  // created() {
  //   this.userProfiles = this.profiles;
  // },
  // methods: {
  //   profileSubmit() {
  //     this.$emit("profileUpdate", this.userProfiles);
  //   }
  // }
};
</script>
