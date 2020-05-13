# node-npm

## 安装

```shell
# ubuntu
sudo apt install nodejs
sudo apt install npm
# 查看版本
node -v
# 输出: V10.19.0
npm -v
# 输出: 6.14.4
```

## 使用

> 首先我们需要将`npm`换为国内的源，否则下载速度很慢

```shell
# 换源
npm config set registry https://registry.npm.taobao.org
# 验证是否成功
npm config get registry
```

```shell
# 初始化项目
npm init

# This utility will walk you through creating a package.json file.
# It only covers the most common items, and tries to guess sensible defaults.
# See `npm help json` for definitive documentation on these fields
# and exactly what they do.
# Use `npm install <pkg>` afterwards to install a package and
# save it as a dependency in the package.json file.

# Press ^C at any time to quit.
# package name: (01) test01
# version: (1.0.0) 1.0.1
# description: 这是一个测试项目
# entry point: (index.js)
# test command:
# git repository:
# keywords: 测试
# author: SamSa
# license: (ISC)
# About to write to /home/sam/Documents/study/web/01/package.json:

# {
#   "name": "test01",
#   "version": "1.0.1",
#   "description": "这是一个测试项目",
#   "main": "index.js",
#   "scripts": {
#     "test": "echo \"Error: no test specified\" && exit 1"
#   },
#   "keywords": [
#     "测试"
#   ],
#   "author": "SamSa",
#   "license": "ISC"
# }


# Is this OK? (yes)

# 项目中安装jquery
# 普通安装, jquery配置不会写在package.json中,同时安装最新版本
npm install jquery
# 安装指定版本
npm install jquery@1.1.6
# 安装指定版本的同时将依赖包卸载package.json中
npm install jquery@1.1.6 --save
```

## npm 根据 package.json 下载包

```shell
# 现有别人的项目, 可以根据他的package.json来下载以来
# 这条命令会自己去package.json中寻找依赖文件名称去下载
npm install
```
