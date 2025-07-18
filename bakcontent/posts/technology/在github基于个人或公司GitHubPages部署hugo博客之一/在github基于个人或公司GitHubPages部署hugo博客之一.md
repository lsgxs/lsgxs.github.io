---
title: "在github基于个人或公司GitHub Pages部署hugo博客之一"
date: 2022-11-14T22:47:45+08:00
draft: false
tags: ["github pages","actions","workflow"]
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Desc Text."
canonicalURL: "https://canonical.url/to/page"
disableHLJS: true # to disable highlightjs
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
UseHugoToc: false
cover:
  image: "images/冰山.jpg"
---



#### 使用github推荐的hugo actions workflow自动化部署hugo博客站点

前一篇文章记录了手动模式推送hugo博客站点到github,采用的是基于项目的仓库，采用username/hugo.git的形式建立仓库，在项目根目录下建立docs目录，把静态博客站点发布在main分支的docs目录。

这篇记录一下基于个人的仓库，采用的是username.github.io形式的仓库。

* 新建username.github.io的空仓

* 根据hugo官网推荐的QuickStart入门教程，建立Hugo博客项目

  ~~~·
  hugo  new   site  hugo
  cd hugo 
  git  init
  git  submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git  themes/ananke
  编辑config.toml文件，在最后新增  theme  =  "ananke"
  修改baseURL = "https://username.github.io"
  hugo  new  posts/文档名称作为目录名/index.md    --编辑自己的文档
  git  add .
  git  commit -m   "新增文档"
  git  push  -u origin  main --第一次推送到空仓username.github.io时要带上-u参数，以后不需要带-u参数
  ~~~

* 新建actions实现自动发布静态站点
  *  github pages自带actions操作方法：进入该仓库，选择settings-pages,在Build and Deployment 的Source部分选择GitHub Actions，直接进入hugo.yml编辑界面，直接点击右侧的commit就可以在仓库新建hugo.yml文件，路径是.github\workflows\hugo.yml，什么有没有修改，可以实现自动发布。
  *  很神奇，在username.github.io仓库的actions下采用了github推荐的hugo站点actions workflow，点击commit后在项目的根目录下新建了hugo.yml文件，新增博客文档后，git-add-commit-push 之后，显示deploy successful，使用https://username.github.io，居然可以正确的显示最新发布的文章，也就是说，什么也没有配置，直接可以发布成功，而且没有用到自己手动建立的gh-pages分支。

    我很好奇，怎么实现的呢？那么多参数，不太明白具体的作用，慢慢来^-^
  hugo.yml

~~~
# Sample workflow for building and deploying a Hugo site to GitHub Pages
name: Deploy Hugo site to Pages

on:
  # Runs on pushes targeting the default branch
  push:
    branches: ["main"]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

# Allow one concurrent deployment
concurrency:
  group: "pages"
  cancel-in-progress: true

# Default to bash
defaults:
  run:
    shell: bash

jobs:
  # Build job
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.102.3
    steps:
      - name: Install Hugo CLI
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.deb \
          && sudo dpkg -i ${{ runner.temp }}/hugo.deb
      - name: Checkout
        uses: actions/checkout@v3
        with:
          submodules: recursive
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v2
      - name: Build with Hugo
        env:
          # For maximum backward compatibility with Hugo modules
          HUGO_ENVIRONMENT: production
          HUGO_ENV: production
        run: |
          hugo \
            --minify \
            --baseURL "${{ steps.pages.outputs.base_url }}/"
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v1
        with:
          path: ./public

  # Deployment job
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1

~~~

点击仓库的actions显示All workflows，选择一个workflows,会在窗口的最下面显示一个artifact,终于看到了熟悉的gh-pages:
![](images/GitHubPagesActions-workflows.png)

![](images/GitHubPagesActions-gh-pages.png)

也就是说这个gh-pages是由系统自己创建的，在这个模式下不需要自己手动建立gh-pages，如果需要指自定义actions，就需要自己建立gh-pages分支发布静态站点文件。

[About publishing sources](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-with-a-custom-github-actions-workflow)

About publishing sources

~~~
You can publish your site when changes are pushed to a specific branch, or you can write a GitHub Actions workflow to publish your site.
If you do not need any control over the build process for your site, we recommend that you publish your site when changes are pushed to a specific branch. You can specify which branch and folder to use as your publishing source. The source branch can be any branch in your repository, and the source folder can either be the root of the repository (/) on the source branch or a /docs folder on the source branch. Whenever changes are pushed to the source branch, the changes in the source folder will be published to your GitHub Pages site.

If you want to use a build process other than Jekyll or you do not want a dedicated branch to hold your compiled static files, we recommend that you write a GitHub Actions workflow to publish your site. GitHub provides starter workflows for common publishing scenarios to help you write your workflow.
~~~

看完Github Docs上关于为github  pages 站点配置发布源的解释就明白了，如果你不需要单独的分支来保存编译后的静态文件、或者你不想使用github后台的编译处理过程，推荐你自己编写GitHub Actions workflow来发布你的站点。读到这里，我就把自己手动建立的gh-pages删除了。剩下的就是慢慢研究这个github推荐的hugo.yml文件的实现细节了。当然，也可以使用单独的gh-pags分支，用仓库的secrets.deploy-token来自定义发布过程，实现同样的效果。
