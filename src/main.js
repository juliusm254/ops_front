import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import "./style.css";

axios.defaults.baseURL = "https://9340-2c0f-2a80-10d8-b610-00-b59.ngrok-free.app";

createApp(App).use(store).use(router, axios).mount("#app");
