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
    // 自分史のイベント情報
    events: {
      // "25": {
      //   age: "25",
      //   data: [
      //     {
      //       id: "1",
      //       age: 25,
      //       title: "title",
      //       episode: "episode",
      //       happiness: 50
      //     },
      //     {
      //       id: "2",
      //       age: 25,
      //       title: "title_02",
      //       episode: "episode_02",
      //       happiness: 90
      //     },
      //   ]
      // },
      // "30": {
      //   age: "30",
      //   data: [
      //     {

      //     },
      //     {

      //     }
      //   ]
      // }
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
    setEvent(state, event) {
      const age = event.age.toString();

      if (Object.keys(state.events).includes(age)) {
        state.events[age].data.push(event);
      } else {
        Vue.set(state.events, age, {});
        state.events[age]["age"] = age;
        Vue.set(state.events[age], "data", []);
        state.events[age]["data"].push(event);
      }
    },
  },
  actions: {
    // プロフィールを取得
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
    // 自分史タイトルを追加
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
    // 自分史タイトルを編集
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
    // 自分史のイベントを追加
    addMyHistoryEvent({ commit }, event) {
      return new Promise((resolve, reject) => {
        axios
          .post("/api/events", {
            history_id: this.state.my_history.id,
            event,
          })
          .then((response) => {
            commit("setEvent", response.data);
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
    getEvents: function(state) {
      return state.events;
    },
    getEventsCount: function(state) {
      return Object.keys(state.events).length;
    },
  },
});
