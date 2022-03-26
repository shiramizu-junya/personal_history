import Vue from "vue/dist/vue.esm";
import App from "../app.vue";
import store from "../store/store";
import axios from "axios";
import { csrfToken } from "rails-ujs";
import VueAxiosPlugin from "./plugins/vue-axios";
import { Chart, registerables } from "chart.js";
import VueCompositionAPI from "@vue/composition-api";

Chart.register(...registerables);
Vue.use(VueCompositionAPI);
Vue.use(
  VueAxiosPlugin,
  {
    axios: axios,
    csrfToken: csrfToken,
  },
);
// true の場合の方が開発者向けのメッセージがコンソールに表示
Vue.config.productionTip = false;

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    store,
    render: (h) => h(App),
  }).$mount("#app");
});
