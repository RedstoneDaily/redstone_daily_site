<script setup>
import { useRouter } from 'vue-router';

const props = defineProps({
  name: {
	type: String,
	required: false,
	default: '日报'
  }, 
  dst: {
	type: String,
	required: false,
	default: '/'
  }
})

const router = useRouter()

const navigate = () => {
  router.push(props.dst)
}
</script>

<template>
  <div class="tool-button" @click="navigate">
    <button>{{ props.name }}</button>
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
  transition:
    width 0.3s ease,
    left 0.3s ease;
}

.tool-button:hover::before {
  width: 100%;
  left: 0;
}

.tool-button button:hover {
  color: #ccc; /* 悬停时按钮文本颜色变化 */
}
</style>
