import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import SummernoteEditor from 'vue3-summernote-editor';
import vSelect from "vue-select";


import './assets/main.css'
// sweetalert 


const app = createApp(App)



app.use(router)
app.component("v-select", vSelect)
app.component('SummernoteEditor', SummernoteEditor);
app.mount('#app')

import 'vue-select/dist/vue-select.css'


// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap/dist/js/bootstrap.js'