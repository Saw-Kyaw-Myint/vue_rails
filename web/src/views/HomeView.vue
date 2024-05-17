<script setup>
import TheWelcome from '../components/TheWelcome.vue'
import { onMounted, ref, watchEffect } from 'vue'
import { useRoute } from "vue-router";
const route = useRoute();
const Auth = ref('');

watchEffect(() => {
  Auth.value = localStorage.getItem('auth') || "true";
  if (Auth.value === "true") {
    localStorage.setItem('auth', false);
    Auth.value = localStorage.getItem('auth');
    location.reload();
  }
})
</script>

<template>
  <main>
    <TheWelcome />
  </main>
</template>
<style>
a {
  text-decoration: none !important;
}

.pagination {
  display: flex;
  list-style: none;
  padding: 10px;
  background: white;
  padding-left: 0;
  list-style: none;
}

.page-item {
  padding: 10px;
  border: 1px solid #e3e3e3;
  background-color: #fff;
  box-shadow: rgba(0, 0, 0, 0.09) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 0px 0px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.04) 0px 16px 8px, rgba(0, 0, 0, 0.04) 0px 32px 16px;

}

.page-item:first-child {
  border-radius: 10px 0 0 10px;
}

.page-item:last-child {
  border-radius: 0px 10px 10px 0px;
}

.active {
  background-color: rgb(26, 26, 249);
}

.active .page-link {
  color: white;
}</style>