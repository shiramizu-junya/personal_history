import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";
import axios from "axios";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // ユーザープロフィール情報
    profile: {
      birthday: null,
      gender: null,
      id: null,
      name: null,
    },
  },
  mutations: {
    // ユーザープロフィールを更新機能
    setUserProfile(state, user) {
      state.profile = user;
    },
  },
  actions: {
    // ユーザープロフィールを取得
    getUserProfile({ commit }) {
      return new Promise((resolve) => {
        axios.get("/api/profile").then((response) => {
          commit("setUserProfile", response.data);
          resolve();
        });
      });
    },
    // プロフィール更新
    updateProfile({ commit }, profile) {
      return new Promise((resolve, reject) => {
        axios
          .patch("/api/profile", {
            profile,
          })
          .then((response) => {
            commit("setUserProfile", response.data);
            resolve();
          })
          .catch((error) => {
            if (error.response.data && error.response.data.errors) {
              reject(error.response.data.errors);
            }
          });
      });
    },
  },
  getters: {
    getUserProfile: function(state) {
      return state.profile;
    },
  },
});
