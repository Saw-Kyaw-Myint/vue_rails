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

// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap/dist/js/bootstrap.js'
