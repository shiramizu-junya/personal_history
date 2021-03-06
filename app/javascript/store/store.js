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
    events: {},
  },
  mutations: {
    setUserProfile(state, user) {
      state.profile = user;
    },
    setMyHistory(state, my_history) {
      state.my_history = my_history;
    },
    setGraphEvents(state, graph_events) {
      state.graph_label = Object.keys(graph_events);
      state.graph_data = Object.values(graph_events);
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
    setEventEdit(state, events) {
      for (let i = 0; i < events.length; i++) {
        let event = events[i];
        const age = event.age.toString();

        if (Object.keys(state.events).includes(age)) {
          state.events[age].data.push(event);
        } else {
          Vue.set(state.events, age, {});
          state.events[age]["age"] = age;
          Vue.set(state.events[age], "data", []);
          state.events[age]["data"].push(event);
        }
      }
    },
    editEvent(state, { event, key, index }) {
      let age = event.age.toString();

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
        if (Object.keys(state.events).includes(age)) {
          state.events[age].data.push(event);
        } else {
          // 2-2-2：編集したデータと同じ年齢の枠組みが存在しないなら、まずその枠組みを作ってから、代入する。
          Vue.set(state.events, age, {});
          state.events[age]["age"] = age;
          Vue.set(state.events[age], "data", []);
          state.events[age]["data"].push(event);
        }
      }
    },
    deleteEvent(state, { key, index }) {
      Vue.delete(state.events[key].data, index);
      if (!state.events[key].data.length) {
        Vue.delete(state.events, key, index);
      }
    },
  },
  actions: {
    // 自分史とイベントを取得
    getMyHistory({ commit }) {
      return new Promise((resolve) => {
        axios.get("/api/my_history/edit").then((response) => {
          let my_history = {};
          my_history["id"] = response.data.id;
          my_history["status"] = response.data.status;
          my_history["title"] = response.data.title;
          commit("setEventEdit", response.data.events);
          commit("setMyHistory", my_history);
          resolve(response.data.graph_events);
        });
      });
    },
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
    addMyHistoryTitle({ commit }, my_history) {
      return new Promise((resolve, reject) => {
        axios
          .post("/api/my_history", {
            my_history,
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
    editMyHistoryTitle({ commit }, my_history) {
      return new Promise((resolve, reject) => {
        axios
          .patch("/api/my_history", {
            my_history,
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
      // クローンしないと「event.data.id」と「event: data」が連動して、idが完全に得るので困る
      let data = _.cloneDeep(event.data);
      let key = event.key;
      let index = event.index;
      // ストロングパラメーターでidを許容していないので削除
      delete data["id"];

      return new Promise((resolve, reject) => {
        axios
          .patch(`/api/events/${event.data.id}`, {
            event: data,
          })
          .then((response) => {
            commit("editEvent", {
              event: response.data,
              key: key,
              index: index,
            });
            resolve();
          })
          .catch((error) => {
            if (error.response.data && error.response.data.errors) {
              reject(error.response.data.errors);
            }
          });
      });
    },
    // 自分史のイベント削除
    eventDelete({ commit }, { data, key, index }) {
      return new Promise((resolve) => {
        axios.delete(`/api/events/${data.id}`).then(() => {
          commit("deleteEvent", {
            key: key,
            index: index,
          });
          resolve();
        });
      });
    },
  },
  getters: {
    getUserProfile: function (state) {
      return state.profile;
    },
    getMyHistory: function (state) {
      return state.my_history;
    },
    getEvents: function (state) {
      return state.events;
    },
    getEventsCount: function (state) {
      return Object.keys(state.events).length;
    },
  },
});
