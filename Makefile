## dist目录
dist ?= ../../dist

# 仓库名
repo ?= gitbook-overview

# 部署
.PHONY: deploy
deploy:
	make pull;make node_modules;make build

# 拉取代码
.PHONY: pull
pull:
	git pull

# 安装gitbook插件
node_modules: book.json
	gitbook install

# 编译gitbook
.PHONY: pull
build:
	gitbook build ./ $(dist)/$(repo)

# 启动gitbook服务器
.PHONY: serve
serve:
	gitbook serve
