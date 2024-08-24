<script setup>
/**
 * A demo of Redstone Search page.
 *
 * @component RDSerachView
 * @description 红石图寻 Demo 页面
 * @props {string} text - The text to be displayed on the button.
 * @event click - Triggered when the button is clicked.
 *
 * know problems:
 * - 真的应该用url-polyfill吗？
 */

import { ref, inject, onMounted } from "vue";
import "url-polyfill";

import ToolTop from "@/components/toolbar/ToolTop.vue";

const { API_URL: api_base_str = "/api/" } = inject("globalConfig");

const api_base = new URL("redstonesearch/", api_base_str);
const api_new_quiz = new URL("newquiz", api_base);
const api_quiz_img = new URL("quizimg", api_base);
const api_quiz_check = new URL("quizcheck", api_base);

const apiNewQuiz = async () => {
  const url = new URL(api_new_quiz);
  url.searchParams.set("t", Date.now());
  return (
    fetch(url)
      .then((res) => res.json())
      .then((data) => data.id) || null
  );
};

const apiQuizImg = async (quiz_id) => {
  const url = new URL(api_quiz_img);
  url.searchParams.set("id", quiz_id);
  return fetch(url).then((res) => res.blob()) || null;
};

const apiQuizCheck = async (quiz_id, ans_link) => {
  const url = new URL(api_quiz_check);
  url.searchParams.set("id", quiz_id);
  url.searchParams.set("ans", ans_link);
  return (
    fetch(url)
      .then((res) => res.json())
      .then((data) => data.score) || null
  );
};

const quiz_id = ref(null);
const quiz_img = ref(null);
const ans_link = ref("");
const score = ref(0);

const AsyncStatus = Object.freeze({
  uninited: Symbol("uninited"),
  in_progress: Symbol("in_progress"),
  done: Symbol("done"),
  error: Symbol("error"),
});

const loading_status = ref(AsyncStatus.uninited);
const newQuiz = async () => {
  loading_status.value = AsyncStatus.in_progress;

  const res = await (async () => {
    const id = await apiNewQuiz();
    if (id == null) return false;

    const img_blob = await apiQuizImg(id);
    if (img_blob == null) return false;

    quiz_id.value = id;
    quiz_img.value = URL.createObjectURL(img_blob);
    return true;
  })();

  loading_status.value = res ? AsyncStatus.done : AsyncStatus.error;
};

const checking_status = ref(AsyncStatus.uninited);
const check = async () => {
  if (loading_status.value != AsyncStatus.done || quiz_id.value === null)
    return;
  checking_status.value = AsyncStatus.in_progress;
  const checked_score = await apiQuizCheck(quiz_id, ans_link);
  if (checked_score >= 0 && checked_score <= 100) {
    score.value = checked_score;
    checking_status.value = AsyncStatus.done;
  } else {
    checking_status.value = AsyncStatus.error;
  }
};

onMounted(newQuiz);
</script>

<template>
  <div id="page">
    <ToolTop />
    <div id="container">
      <h1>红石图寻 demo</h1>
      <p>API URL: {{ api_base }}</p>
      <img class="quiz-img" v-if="quiz_img" :src="quiz_img" />
      <div class="bar">
        <span>{{ `相似度：${score}%` }}</span>
        <button @click="newQuiz">
          {{
            (() => {
              switch (loading_status) {
                case AsyncStatus.in_progress:
                  return "Loading...";
                case AsyncStatus.error:
                  return "Error";
                default:
                  return "New";
              }
            })()
          }}
        </button>
      </div>
      <div class="bar">
        <input v-bind:value="ans_link" />
        <button @click="check">
          {{
            (() => {
              switch (checking_status) {
                case AsyncStatus.in_progress:
                  return "Checking...";
                case AsyncStatus.error:
                  return "Error";
                default:
                  return "Check";
              }
            })()
          }}
        </button>
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

.quiz-img {
  width: 50vw;
}

.bar {
  width: 50vw;
  display: flex;
  flex-direction: row;
  align-items: stretch;
  gap: 10px;
  height: 30px;
}

.bar :first-child {
  flex-grow: 1;
}

.bar button {
  background: #505050;
  border-radius: 5px;
  border: 1px solid #a0a0a0;
  color: white;
}

.bar button :hover {
  background: #404040;
  color: #f0f0f0;
}
</style>
