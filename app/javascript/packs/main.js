import Vue from "vue/dist/vue.esm";
import App from "../App.vue";
import store from "../store/store";
import axios from "axios";
import { csrfToken } from "rails-ujs";
import VueAxiosPlugin from "./plugins/vue-axios";

Vue.use(VueAxiosPlugin, { axios: axios, csrfToken: csrfToken });

Vue.config.productionTip = false;

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    store,
    render: (h) => h(App),
  }).$mount("#app");
});
