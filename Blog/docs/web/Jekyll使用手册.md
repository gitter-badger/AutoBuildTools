# 目录

- [目录](#目录)
- [1. jekyll说明](#1-jekyll说明)
- [2. 搭建过程](#2-搭建过程)
  - [2.1. 新建仓库](#21-新建仓库)
  - [2.2. 仓库clone](#22-仓库clone)
  - [2.3. 安装ruby环境](#23-安装ruby环境)
  - [2.4. 安装Jekyll环境](#24-安装jekyll环境)
- [3. 创建博客](#3-创建博客)
- [4. 添加文章](#4-添加文章)
- [5. 发布](#5-发布)

# 1. jekyll说明

`jekyll` 是一个可以把你写的 `MarkDown` 转化成 `html` 的纯前端框架，为什么说它纯前端呢？因为你的文章都是以 `MarkDown` 文件的形式保存的，无需数据库。配合 `Liquid` 可以灵活自由的生成动态 `Html` 页面。`Github` 原生支持 `jekyll`，你不需要在本地 `build`，直接把项目 `push` 到 `Github`，`Github` 会自动帮你生成 `html`。

`Github Pages` + `jekyll` 是 `github` 官方推荐的，用来搭建静态网站的一种非常有效并且便捷的方式。我们可以很方便地将静态网站的所有代码托管到 `github` 的 `Repository` 中，这样就可以通过网络来访问我们的网站。同时 `jekyll` 支持在本地预览我们使用 `MarkDown` 编写的博客，我们可以在本地预览无误之后，再提交到 `github` 上，提升了博客的编写效率。

[官方入门文档](https://docsify.js.org/#/zh-cn/)

# 2. 搭建过程

## 2.1. 新建仓库

首先在 `github` 上创建一个特殊的代码仓库，名字必须是`xxx.github.io`，`xxx`是你的`github`昵称。

![image](https://user-images.githubusercontent.com/26021085/163766697-d6371493-7de8-4151-b3a0-bdb39265a762.png)

## 2.2. 仓库clone

然后把仓库 clone 到本地

`这里是我自己的git，用来举例`
``` bash
git clone git@github.com:EchoHeim/EchoHeim.github.io.git
cd EchoHeim.github.io
```

## 2.3. 安装ruby环境

``` bash
sudo apt install ruby
sudo apt install bundler
```

## 2.4. 安装Jekyll环境

在项目根目录下新增文件 `Gemfile`，添加以下内容

``` text
source 'https://rubygems.org'
gem "github-pages", group: :jekyll_plugins
```

然后运行
``` bash
sudo bundle update
sudo bundle install
```

运行成功后，就可以使用`Jekyll`创建博客内容了。

# 3. 创建博客

删除你项目主目录下的`Gemfile`和`Gemfile.lock`文件，然后使用终端在该目录下运行`jekyll new ./`。成功后，直接运行`jekyll serve`就可以在本地预览效果了。在浏览器输入`http://127.0.0.1:4000/`，可以查看效果。

注：

开启服务报错的话，可以尝试执行 `bundle update`
然后再执行 `bundle exec jekyll serve` 或者 `jekyll serve` 就 OK 了。


打开项目目录下的`Gemfile`文件，为了兼容`Github`默认的`Jekyll`，需要把`gem "jekyll", "3.4.3"`替换成`gem "github-pages", group: :jekyll_plugins`。

# 4. 添加文章
在`_posts`目录下按照`年-月-日-名称.markdown`的文件名格式创建新文章。文章内容可以参考自带的文章示例。

# 5. 发布
最后我们把项目的内容都`push`到`Github`上，就可以访问你的个人博客啦。地址如下：

![image](https://user-images.githubusercontent.com/26021085/163786760-15bf650d-f76d-411d-bd7c-109f813fdc29.png)




