# redstone_daily_site

[红石日报 Redstone Daily 介绍](https://github.com/RedstoneDaily/redstone_daily)

本仓库为红石日报的前端仓库，包含 Flutter 工程和 Vue 工程，Flutter 工程已被废弃，未来将基于 Vue 工程进行开发

## 开发流程 / devops

- 本仓库使用 Github Actions 进行 CI/CD，详见 [.github/README.md](./.github/README.md)

- **对于组织内开发者：**
	- 请在 `main` 分支上创建新分支进行开发（分支名尽量起成 `dev/xxx` ）；
	- 基础性开发完成后提交 Merge Request 到 `main` 分支；
	- 在 Merge Request 开启后可在开发分支上继续 commit，每次提交都会触发 CI/CD 流程自动尝试部署到开发环境服务器上，可在开发版网站上进行查验和测试，不断调整代码直至达到预期效果；
	- 摇一位 Reviewer 让ta看眼代码并 Approval，Merge Request 审核通过后即可合并；
	- 重大更新通知管理员补个 changelog
	- 合并到 main 分支上的更新会通过 CI/CD 流程会自动部署到生产环境服务器上，生产版网站会自动更新。

[changelog](./changelog.md)

[Flutter版文档](./flutter_project/README.md)

[Vue版文档](./vue_project/README.md)

[Github Actions文档](./.github/README.md)