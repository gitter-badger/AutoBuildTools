- [1. Docsify 简介](#1-docsify-简介)
  - [1.1 Docsify 特性](#11-docsify-特性)
  - [1.2 Docsify 模板](#12-docsify-模板)
- [2. Node.js 安装配置](#2-nodejs-安装配置)
- [3. docsify-cli 工具安装](#3-docsify-cli-工具安装)
- [3. 项目初始化](#3-项目初始化)
---

# 1. Docsify 简介

一个神奇的文档网站生成器。docsify 可以快速帮你生成文档网站。不同于 `GitBook`、`Hexo` 的地方是它不会生成静态的 `.html` 文件，所有转换工作都是在运行时。如果你想要开始使用它，只需要创建一个 `index.html` 就可以开始编写文档。

[官方入门文档](https://docsify.js.org/#/zh-cn/)

## 1.1 Docsify 特性

- 无需构建，写完文档直接发布
- 容易使用并且轻量 (压缩后 ~21kB)
- 智能的全文搜索
- 提供多套主题
- 丰富的 API
- 支持 Emoji
- 兼容 IE11
- 支持服务端渲染 SSR (示例)

## 1.2 Docsify 模板

模板源码：<https://github.com/YSGStudyHards/Docsify-Guide>

模板预览：<https://ysgstudyhards.github.io/Docsify-Guide/#/>

# 2. Node.js 安装配置

[Nodejs下载地址](http://nodejs.cn/download/)

![image](https://user-images.githubusercontent.com/26021085/163298955-4ba7fd85-343d-40c6-b78f-40a1110df031.png)

Linux下直接下载二进制文件包，解压，然后添加路径到环境变量即可。

``` bash
PATH=$PATH:/home/lodge/nodejs/bin
```

最后在终端能查看版本号，说明安装成功

![image](https://user-images.githubusercontent.com/26021085/163299161-c36a5831-65e2-44d0-afe8-79d636a5c4d2.png)

# 3. docsify-cli 工具安装

推荐全局安装 `docsify-cli` 工具，可以方便地创建及在本地预览生成的文档。

``` bash
npm i docsify-cli -g
```

成功安装后如下：

![image](https://user-images.githubusercontent.com/26021085/163303235-948e7101-25c3-426b-b191-c260f4519afb.png)

# 3. 项目初始化

在项目的文档目录里可以直接通过 `init` 初始化项目。

``` bash
docsify init ./Docsify-Guide
```

初始化成功后，可以看到目录下创建的几个文件

index.html 入口文件
README.md 会做为主页内容渲染
.nojekyll 用于阻止 GitHub Pages 忽略掉下划线开头的文件
直接编辑 docs/README.md 就能更新文档内容，当然也可以添加更多页面。

