import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import VueDevTools from "vite-plugin-vue-devtools";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), VueDevTools()],
  base: "/vue/",
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  // 给大家表演一手精神分裂.jpg
  experimental: {
    renderBuiltUrl(_, { type }) {
      if (type === "asset") {
        return { relative: true };
      }
    },
  },
});
