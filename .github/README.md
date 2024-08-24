# Github Actions 文档

## 调用结构

- 主程序 / 事件触发层：
	- `.github/workflows/`
		- `on-pull-request.yml`
		- `push-main.yml`
		- `workflow-test.yml`
	
	以上工作流文件均为主程序，负责调用其他工作流文件。

- 主程序之1
	- CI：`ci.yml`
		- 构建 Flutter 版页面： `ci-build-flutter.yml`
		- 构建 Vue 版页面： `ci-build-vue.yml`
	- CD：`cd.yml`
		- SSH 部署：`cd-ssh-deploy.yml`
		- 静态 CDN 上传：`cd-upload-cdn.yml` / EO 刷新（仅当部署到prod环境时）：`cd-refresh-eo.yml`

## 环境标识

请在项目内统一使用以下名称区分环境：

- `prod` 生产环境
- `dev` 开发环境

多数工作流文件需要输入`ENV_TYPE`参数以标识环境，可选值为上述环境标识。

（btw为什么GA不能弄成全局依赖呢 要传进每个角落里做体操好烦
