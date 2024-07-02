<script setup>
import { ref, watch, toRefs } from 'vue'

const props = defineProps(['pagesNum'])
const { pagesNum } = toRefs(props)

const positions = ref([
  'AnimationBlock11',
  'AnimationBlock12',
  'AnimationBlock21',
  'AnimationBlock22',
  'AnimationBlock1',
  'AnimationBlock2'
])

const num = ref(0)
let timers = []

watch(pagesNum, (newVal) => {
  // 清除所有之前的定时器
  timers.forEach((timer) => clearTimeout(timer))
  timers = []

  num.value = 0
  console.log(newVal)

  const incrementNum = (index) => {
    if (index < 4) {
      const timer = setTimeout(() => {
        num.value = index + 1
        incrementNum(index + 1)
      }, 100) // 300ms 的间隔时间
      timers.push(timer)
    }
  }
  incrementNum(0)
})
</script>

<template>
  <div
    :style="{
      backgroundColor: '#f2f2f2',
      top: 'auto',
      height: pagesNum >= 1 && pagesNum <= 4 ? '100%' : '0%'
    }"
  >
    <div class="main">
      <div :class="positions[pagesNum >= 1 && pagesNum <= 2 ? pagesNum - 1 : 4]"></div>
      <div :class="positions[pagesNum >= 3 && pagesNum <= 4 ? pagesNum - 1 : 5]"></div>
      <div>
        <img :class="pagesNum == 1 ? 'img11' : 'img10'" src="../../assets/image/clock.png" alt="" />
        <img
          :class="pagesNum == 2 ? 'img21' : 'img20'"
          src="../../assets/image/knowledge_book.png"
          alt=""
        />
        <img
          :class="pagesNum == 3 ? 'img31' : 'img30'"
          src="../../assets/image/mojang_banner_pattern.png"
          alt=""
        />
        <img
          :class="pagesNum == 4 ? 'img41' : 'img40'"
          src="../../assets/image/recovery_compass_07.png"
          alt=""
        />
      </div>
      <div class="content_box">
        <div class="content_box1" v-if="pagesNum == 1">
          <h1 :class="{ display: num >= 1 }">一时间 . . .</h1>
          <h1 :class="{ display: num >= 2 }">获得第一手信息。</h1>
          <p :class="{ display: num >= 3 }">
            我们每日都会排查并分析对你有帮助的红石视频，以便您研究时查看最新进展。
          </p>
          <button :class="{ display: num >= 4 }">按钮</button>
        </div>
        <div class="content_box2" v-if="pagesNum == 2">
          <h1 :class="{ display: num >= 1 }">励志打造全国最大的</h1>
          <h1 :class="{ display: num >= 2 }">红石信息库</h1>
          <button :class="{ display: num >= 3 }">按钮</button>
          <p :class="{ display: num >= 4 }">
            通过每日的日报数据，长年累月即可形成庞大的数据库供查询。
          </p>
        </div>
        <div class="content_box3" v-if="pagesNum == 3">
          <h1 :class="{ display: num >= 1 }">查看我们的成果 . . .</h1>
          <button :class="{ display: num >= 2 }">按钮</button>
          <button :class="{ display: num >= 3 }">按钮</button>
          <!-- 内容 -->
        </div>
        <div class="content_box4" v-if="pagesNum == 4">
          <h1 :class="{ display: num >= 1 }">除此之外 . . .</h1>
          <h1 :class="{ display: num >= 2 }">这里还有其他功能</h1>
          <button :class="{ display: num >= 3 }">按钮</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.main {
  position: absolute;
  width: 100vw;
  height: 100vh;
  left: 0;
  right: 0;
  top: auto;
  bottom: 0;
}

/* 动画块，根据应用给定的页数，动态设置位置 */
/* 块初始大小颜色动画等 */
[class^='AnimationBlock'] {
  position: absolute;
  top: 0;
  width: 100vw;
  height: 100vh;
  background-color: #740000;
  transition: all 0.7s ease 0s;
}

/* 第一个块的初始位置，及其形状 */
[class^='AnimationBlock1'] {
  left: -100vw;
  clip-path: polygon(0 0, 80% 0, 100% 100%, 0 100%);
}

/* 第二个块的初始位置，及其形状 */
[class^='AnimationBlock2'] {
  right: -100vw;
  clip-path: polygon(20% 0, 100% 0, 80% 100%, 0 100%);
}

/* 各个动画块特定样式（位置将在Vue中动态设置） */
.AnimationBlock11 {
  left: -60vw;
}

.AnimationBlock12 {
  left: -20vw;
}

.AnimationBlock21 {
  right: -20vw;
}

.AnimationBlock22 {
  right: 0vw;
}

/* 所有图片初值值 */
[class^='img'] {
  position: absolute;
  image-rendering: pixelated;
  opacity: 0.2;
  transition: all 0.5s ease 0s;
  width: 512px;
}

/* 所有图片初始位置 */
.img10 {
  left: calc(20vw - 256px - 20px);
  top: calc(50vh - 256px);
  opacity: 0;
}

.img20 {
  left: calc(75vw - 256px + 20px);
  top: calc(50vh - 256px);
  opacity: 0;
}

.img30 {
  left: calc(25vw - 256px - 20px);
  top: calc(50vh - 256px);
  width: 530px;
  opacity: 0;
}

.img40 {
  right: 0;
  bottom: calc(0vh - 128px);
  width: 580px;
  opacity: 0;
  transform: rotate(20deg);
}

/* 所有图片最终位置 */
.img11 {
  left: calc(20vw - 256px);
  top: calc(50vh - 256px);
  transform: rotate(-20deg);
  opacity: 1;
}

.img21 {
  left: calc(75vw - 256px);
  top: calc(50vh - 256px);
  transform: rotate(-20deg);
  opacity: 1;
}

.img31 {
  left: calc(25vw - 256px);
  top: calc(50vh - 256px);
  transform: rotate(-10deg);
  width: 530px;
  opacity: 1;
}

.img41 {
  right: -3vw;
  bottom: calc(0vh - 128px);
  width: 580px;
  opacity: 1;
  transform: rotate(20deg);
}

.content_box {
  position: absolute;
  height: 100vh;
  width: 100vw;
}

.content_box1 > *,
.content_box2 > *,
.content_box3 > *,
.content_box4 > * {
  opacity: 0;
  transition: opacity 0.5s ease-in-out;
}

.content_box1 > .display,
.content_box2 > .display,
.content_box3 > .display,
.content_box4 > .display {
  opacity: 1;
}

.content_box > div {
  position: absolute;
  font-size: 46px;
  transition: all 0.5s ease 0s;
  /* transform: translateY(20px); */
}

/* .display {
    opacity: 1;
    transform: translateY(-20px);
} */

.content_box1 {
  position: absolute;
  color: black;
  right: 0;
  top: 10%;
  width: 60vw;
}

.content_box2 {
  position: absolute;
  color: white;
  left: 0;
  top: 10%;
  width: 60vw;
}

.content_box3 {
  position: absolute;
  color: white;
  right: 0;
  top: 10%;
  width: 60vw;
}

.content_box4 {
  position: absolute;
  color: white;
  left: 50%;
  top: 10%;
  width: 60vw;
  transform: translate(-50%); /* 50%为自身尺寸的一半 */
}
</style>
