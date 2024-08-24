<script setup>
/**
 * A demo of Redstone Search page.
 *
 * @component RDSerachView
 * @description AcaciaMC Demo 页面
 * @props {string} text - The text to be displayed on the button.
 * @event click - Triggered when the button is clicked.
 *
 * know problems:
 * - 真的应该用url-polyfill吗？
 */

// import { ref, inject, onMounted } from "vue";
import "url-polyfill";

import ToolTop from "@/components/toolbar/ToolTop.vue";
</script>

<template>
  <div id="page">
    <ToolTop />
    <div id="container">
      <h1>Acacia编译器 demo</h1>
      <img class="quiz-img" v-if="quiz_img" :src="quiz_img" />
      <div
        style="
          width: 90vw;
          height: 30vw;
          font-size: 5vw;
          display: flex;
          align-items: center;
          justify-content: center;
        "
      >
        To be continued...
      </div>
    </div>
  </div>
</template>

<style scoped>
#page {
  width: 100%;
  height: 100%;
  overflow-y: scroll;
}

#container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}
</style>
