import Vue from "vue/dist/vue.esm";
import Vuex from "vuex";
import axios from "axios";
import _ from "lodash";

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
    editEvent(state, { event, key, index }) {
      // １、編集対象のデータのageと編集したデータのageが同じであれば、そのまま編集対象のデータを変更する
      if (state.events[key].data[index].age === event.age) {
        Vue.set(state.events[key].data, index, event);
      } else {
        // ２、編集対象のデータのageと編集したデータのageが違う場合
        // 2-1：編集対象のdataの配列の要素を削除する
        Vue.delete(state.events[key].data, index);
        // 2-1-1：編集対象のdataを削除した際に、同年齢のdataの配列に要素がない場合は、同年齢のオブジェクトの塊ごと削除する
        if (!state.events[key].data.length) {
          Vue.delete(state.events, key, index);
        }
        // 2-2：編集したデータを編集したデータの年齢と同じオブジェクトの塊に追加する
        // 2-2-1：編集したデータと同じ年齢の枠組みが存在するなら、そのまま配列の中に代入するだけ
        if (Object.keys(state.events).includes(event.age.toString())) {
          state.events[event.age.toString()].data.push(event);
        } else {
          // 2-2-2：編集したデータと同じ年齢の枠組みが存在しないなら、まずその枠組みを作ってから、代入する。
          Vue.set(state.events, event.age.toString(), {});
          state.events[event.age.toString()]["age"] = event.age.toString();
          Vue.set(state.events[event.age.toString()], "data", []);
          state.events[event.age.toString()]["data"].push(event);
        }
      }
    }
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
    // 自分史のイベントを編集
    editEvent({ commit }, event) {
      let data = _.cloneDeep(event.data);
      let key = event.key;
      let index = event.index;
      delete data["id"];

      return new Promise((resolve, reject) => {
        axios
          .patch(`/api/events/${event.data.id}`, {
            event: data,
          })
          .then((response) => {
            commit("editEvent", { event: response.data, key: key, index: index });
            resolve();
          })
          .catch((error) => {
            console.log("catch", error);
            if (error.response.data && error.response.data.errors) {
              reject(error.response.data.errors);
            }
          });
      });
    }
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
