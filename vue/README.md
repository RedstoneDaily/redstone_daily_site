# redstone_daily

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur).

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

```sh
pnpm install
```

### Compile and Hot-Reload for Development

```sh
pnpm dev
```

### Compile and Minify for Production

```sh
pnpm build
```

### Lint with [ESLint](https://eslint.org/)

```sh
pnpm lint
```

# 项目代码都放在src目录下

- App.vue是根组件
- views是放页面的地方
- components是组件
  - 其中tool是放一些通用工具组件的地方，比如说：按钮、链接、表单等
  - 其他文件夹是页面的组件，对应着views文件夹下的页面

## 用了以下依賴：

- 主依赖
  - [Pinia](https://pinia.vuejs.org/)
  - [Vue Router](https://router.vuejs.org/)
- 开发依赖
  - [ESLint](https://eslint.org/)
  - [Vite](https://vitejs.dev/)
  - [vite-plugin-vue-devtools](https://devtools-next.vuejs.org/)