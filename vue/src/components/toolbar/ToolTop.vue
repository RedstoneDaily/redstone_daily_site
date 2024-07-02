<script setup>
import ToolButton from '../tool/ButtonUnderlined.vue'
</script>

<template>
  <div class="main">
    <nav>
      /
      <ToolButton name="红石图寻" dst="/rdsearch" /> / <ToolButton /> / <ToolButton /> /
    </nav>
    <nav>
      /
      <ToolButton /> / <ToolButton /> / <ToolButton /> /
    </nav>
  </div>
</template>

<style scoped>
.main {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  gap: 1rem;
  padding: 20px 40px;
}
</style>
