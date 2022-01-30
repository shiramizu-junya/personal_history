import Vue from "vue/dist/vue.esm";
import App from "../app.vue";
import store from "../store/store";
import axios from "axios";
import { csrfToken } from "rails-ujs";
import VueAxiosPlugin from "./plugins/vue-axios";
import VueJsDialog from "vuejs-dialog";
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
Vue.use(VueJsDialog);
Vue.config.productionTip = false;

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    store,
    render: (h) => h(App),
  }).$mount("#app");
});
