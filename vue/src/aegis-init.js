import Aegis from 'aegis-web-sdk';

// Aegis 观测上报环境
const AegisENVs = Object.freeze({
  // 生产环境
  prod: 'Aegis.environment.production',
  // 开发环境
  dev: 'Aegis.environment.development',
  // 灰度环境
  gray: 'Aegis.environment.gray',
  // 预发布环境
  pre: 'Aegis.environment.pre',
  // 日发布环境
  daily: 'Aegis.environment.daily',
  // 本地环境
  local: 'Aegis.environment.local',
  // 测试环境
  test: 'Aegis.environment.test',
  // 其他环境
  others: 'Aegis.environment.others'
});

import {aegis_env as env_option} from './config.json'
const env = AegisENVs[env_option] || AegisENVs.prod;

// Generate UIN
const UIN_Length = 10;
let uin = '';
for (let i = 0; i < UIN_Length; i++) {
  uin += Math.floor(Math.random() * 10);
}
uin = Date.now() + "-" + uin;

if (typeof Aegis === 'function') {
  const aegis = new Aegis({
    // Env
    id: 'mZxy9hL2PY1GozZLD9',
    uin: uin,
    env: env,
    hostUrl: 'https://rumt-zh.com',

    // Speed Report
    reportApiSpeed: true,
    pagePerformance: true,
    reportAssetSpeed: true,
    speedSample: false,

    // Error Report
    onError: true,

    // SPA Set
    spa: true,

    // API
    api: {
      // Report
      apiDetail: true,
      reportRequest: true,
      websocketHack: true,
      usePerformanceTiming: true,

      // Trace Header
      // injectTraceHeader: 'traceparent',

      // Header Report
      // reqHeaders: ['traceparent'],
      resHeaders: ['content-type', 'server'],

      // Ignore URL
      // injectTraceIgnoreUrls: ['/gstatic.com/', '/bilibili.com/'],

      // RC Report
      // retCodeHandler(data, url, xhr) {

      // }
    }
  });
  console.log(aegis || 'Aegis is not a function');
}