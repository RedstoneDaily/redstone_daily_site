<script setup>
import ToolTop from '@/components/toolbar/ToolTop.vue';
</script>

<template>
  <div class="home">
    <ToolTop />

    <div class="text-container">
      <span class="text-red">红石</span>
      <div class="lines-container">
        <span class="line red-line"></span>
        <span class="line white-line"></span>
      </div>
      <span class="text-white">日报</span>

    </div>
    
    <p class="">/ 发现, 并创造自己的灵感 /</p>
  </div>
</template>

<style scoped>
.home {
  width: 100%;
  height: 100%;
}

.text-container {
  height: 270px;
  display: inline-block;
  font-size: 100px;
  position: relative;
  top: 40px;
  left: 60px;
}

.text-red {
  color: #ff0000;
  position: absolute;
  width: 200px;

}

.text-white {
  color: #ffffff;
  position: absolute;
  width: 200px;
  top: 80px;
  left: 220px;
}

.lines-container {
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
p {
  padding-left:60px;
  font-size: 40px;
  color: #ffffff;
}
</style>