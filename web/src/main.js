import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import SummernoteEditor from "vue3-summernote-editor";
import vSelect from "vue-select";
// import the package
import VueAwesomePaginate from "vue-awesome-paginate";

// import the necessary css file
import "vue-awesome-paginate/dist/style.css";

import "./assets/main.css";
// sweetalert

const app = createApp(App);

app.use(router);
app.component("v-select", vSelect);
app.component("SummernoteEditor", SummernoteEditor);
app.mount("#app");
app.use(VueAwesomePaginate);

import "vue-select/dist/vue-select.css";

document.addEventListener("DOMContentLoaded", function () {
  const fallbackImageUrl =
    "https://dnm.nflximg.net/api/v6/BvVbc2Wxr2w6QuoANoSpJKEIWjQ/AAAAQSYvFWEjX4WN-4SJuogTJ1Jsolstp-CFXZEm4Hp6MiWPengGwUugw_pGIR6KdjOCOz5WFuNH1EP6n2S_3ZRkEkib4F6A31Uus7e9nSBeDkZquFxlDLLbkfzB-Qchb5wUHJryKVy2PlRFELVZLCAyNB5JwoI.jpg?r=957";
  const images = document.querySelectorAll("img");
  images.forEach(function (img) {
    img.onerror = function () {
      this.onerror = null;
      this.src = fallbackImageUrl;
    };
  });
});

// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap/dist/js/bootstrap.js'
