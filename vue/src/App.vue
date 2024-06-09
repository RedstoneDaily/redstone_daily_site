<script setup>
// import { RouterLink, RouterView } from 'vue-router'
import HomeView from './views/HomeView.vue'
</script>

<template>
  <div class="container">
    <HomeView />
  </div>
</template>

<style scoped>
.container {
  width: 100%;
  height: 100vh;
  background-image: url("./assets/background/Fparrot_CPU.png");
  background-size: 100% 100%; /* 图片自适应并填充容器 */
  background-position: center; /* 图片居中显示 */
  background-repeat: no-repeat; /* 防止图片重复 */
  background-attachment: fixed;
}
</style>
