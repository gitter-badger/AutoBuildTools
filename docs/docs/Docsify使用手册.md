# 目录

- [目录](#目录)
- [1. Docsify 简介](#1-docsify-简介)
  - [1.1 Docsify 特性](#11-docsify-特性)
  - [1.2 Docsify 模板](#12-docsify-模板)
- [2. Node.js 安装配置](#2-nodejs-安装配置)
- [3. docsify-cli 工具安装](#3-docsify-cli-工具安装)
- [3. 项目初始化](#3-项目初始化)
- [4. 本地运行 docsify 项目](#4-本地运行-docsify-项目)
- [5. 配置文件介绍](#5-配置文件介绍)
- [6. 实用插件](#6-实用插件)

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

Linux系统直接下载二进制文件包，解压，然后添加路径到环境变量即可。

``` bash
PATH=$PATH:/home/lodge/nodejs/bin
```

最后在终端能查看版本号，说明安装成功

![image](https://user-images.githubusercontent.com/26021085/163299161-c36a5831-65e2-44d0-afe8-79d636a5c4d2.png)

# 3. docsify-cli 工具安装

推荐全局安装 `docsify-cli` 工具，可以方便地创建、以及在本地预览生成的文档。

``` bash
npm i docsify-cli -g
```

成功安装后显示如下：

![image](https://user-images.githubusercontent.com/26021085/163303235-948e7101-25c3-426b-b191-c260f4519afb.png)

# 3. 项目初始化

在项目的文档目录里可以直接通过 `init` 初始化项目。

``` bash
docsify init ./Docsify-Guide
```

- 更多功能查看 [docsify命令行工具](https://github.com/docsifyjs/docsify-cli)

初始化成功后，可以看到目录中自动创建了以下几个文件

- `index.html` 文档主页入口文件
- `README.md` 主页内容渲染文件
- `.nojekyll` 阻止 GitHub Pages 忽略下划线开头的文件

直接编辑 `README.md` 就能更新文档内容，当然也可以[添加更多页面](https://docsify.js.org/#/zh-cn/more-pages)。

# 4. 本地运行 docsify 项目

在项目根目录，可以运行 `docsify serve` 启动一个本地服务器；如果在上级目录，可示通过运行 `docsify serve 项目名称` 启动，然后就可以方便地实时预览效果。

默认本地访问地址 <http://localhost:3000>

# 5. 配置文件介绍

  | 文件作用 | 文件 |
  | :------: | :--: |
基础配置项（入口文件）| index.html
封面配置文件         | _coverpage.md
侧边栏配置文件       |  _sidebar.md
导航栏配置文件       |  _navbar.md
主页内容渲染文件     | README.md
浏览器图标           | favicon.ico

此[网站源码](https://github.com/hsl416604093/AutoBuildTools/tree/master/docs)全部开源。&emsp; 附上[效果预览](https://echoheim.github.io/AutoBuildTools/#/)

# 6. 实用插件

[分页导航插件](https://github.com/imyelo/docsify-pagination#readme)
