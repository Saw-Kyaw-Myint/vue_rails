<script setup>
import { RouterLink, RouterView } from "vue-router";
import Navbar from "./views/NavbarView.vue";
import LoginNav from "./views/LoginNavView.vue";
import { ref, watch, onMounted, watchEffect, reactive } from "vue";
import axios from "axios";

let Authuser = ref();
const Auth = reactive({
  data: localStorage.getItem("user") ? true : false,
});
onMounted(() => {
  // console.log("hello");
});
</script>

<template>
  <LoginNav v-if="Auth.data"></LoginNav>
  <Navbar v-else />

  <RouterView />
</template>

<style scoped></style>
