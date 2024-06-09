<script setup>
// 如果有需要在脚本中定义变量或导入其他模块，可以在这里添加
</script>

<template>
  <div class="tool-button">
    <button>日报</button>
  </div>
</template>

<style scoped>
.tool-button {
  display: inline-block;
  padding: 10px 40px;
  color: #fff;
  text-align: center;
  cursor: pointer;
  position: relative;
}

.tool-button button {
  background: none;
  border: none;
  color: inherit;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  position: relative;
  z-index: 1;
}

.tool-button::before {
  content: '';
  position: absolute;
  width: 0;
  height: 2px;
  bottom: 5px;
  left: 50%;
  background-color: #fff;
  transition: width 0.3s ease, left 0.3s ease;
}

.tool-button:hover::before {
  width: 100%;
  left: 0;
}

.tool-button button:hover {
  color: #ccc; /* 悬停时按钮文本颜色变化 */
}
</style>
