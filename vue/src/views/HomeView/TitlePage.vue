<script setup>
import ToolTop from '@/components/toolbar/ToolTop.vue'

const { pagesNum } = defineProps(['pagesNum'])

// const p = ref(0);
</script>

<template>
  <!-- top=0px width=变量 -->
  <div :style="{ top: '0px', height: `${pagesNum == 0 ? 100 : 0}%` }">
    <!-- 页面容器 -->
    <div class="page-container">
      <!-- 顶部工具栏 -->
      <ToolTop />
      <!-- 内容容器 -->
      <div class="content-container">
        <!-- 红色标题 -->
        <span class="title-red">红石</span>
        <!-- 线条容器 -->
        <div class="lines-wrapper">
          <span class="line red-line"></span>
          <span class="line white-line"></span>
        </div>
        <!-- 白色标题 -->
        <span class="title-white">日报</span>
      </div>

      <p class="inspiration-text">/ 发现, 并创造自己的灵感 /</p>
    </div>
  </div>
</template>

<style scoped>
.page-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('/assets/background/Fparrot_CPU.png');
  background-size: 100% 100%;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
}

.content-container {
  height: 270px;
  display: inline-block;
  font-size: 100px;
  position: relative;
  top: calc(100vh * 0.05);
  left: 60px;
}

.title-red {
  color: #ff0000;
  position: absolute;
  width: 200px;
}

.title-white {
  color: #ffffff;
  position: absolute;
  width: 200px;
  top: 80px;
  left: 220px;
}

.lines-wrapper {
  position: absolute;
}

.line {
  width: 180px;
  height: 3px;
  transform: rotate(-46deg);
  display: inline-block;
  position: absolute;
}

.red-line {
  background-color: red;
  top: 102px;
  left: 152px;
}

.white-line {
  background-color: white;
  top: 140px;
  left: 93px;
}

.inspiration-text {
  padding-left: 60px;
  font-size: 40px;
  color: #ffffff;
}
</style>
