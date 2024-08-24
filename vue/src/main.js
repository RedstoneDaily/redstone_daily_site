import './assets/main.css'

import { createApp, readonly } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

import config from './config.json'

const app = createApp(App)

app.provide('globalConfig', readonly(config))
app.use(createPinia())
app.use(router)

app.mount('#app')
