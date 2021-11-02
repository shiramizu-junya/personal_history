import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";
import axios from "axios";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // ユーザープロフィール情報
    profile: {
      id: null,
      birthday: null,
      gender: null,
      name: null,
    },
    // 自分史の情報
    my_history: {
      id: null,
      status: null,
      title: null,
    },
  },
  mutations: {
    // ユーザープロフィールを更新機能
    setUserProfile(state, user) {
      state.profile = user;
    },
    setMyHistory(state, my_history) {
      state.my_history = my_history;
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
    // 自分史のタイトルを追加
    addMyHistoryTitle({ commit }, history) {
      return new Promise((resolve, reject) => {
        axios
          .post("/api/my_histories", {
            history,
          })
          .then((response) => {
            commit("setMyHistory", response.data);
            resolve();
          })
          .catch((error) => {
            if (error.response.data && error.response.data.errors) {
              reject(error.response.data.errors);
            }
          });
      });
    },
    // 自分史のタイトルを編集
    editMyHistoryTitle({ commit }, history) {
      return new Promise((resolve, reject) => {
        axios
          .patch(`/api/my_histories/${this.state.my_history.id}`, {
            history,
          })
          .then((response) => {
            commit("setMyHistory", response.data);
            resolve(response.data);
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
    getMyHistory: function(state) {
      return state.my_history;
    },
  },
});
