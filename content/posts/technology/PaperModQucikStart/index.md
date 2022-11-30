---
title: "MyPaperModQucikStart"
date: 2022-11-24T17:42:04+08:00
draft: false
tags: ["first"]
weight: 4
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
    image: "images/云山雾绕.jpg" 
---

#### 根据PaperMod的QuickStart记录自己的建站教程

* 安装hugo

  下载扩展版本的hugo二进制应用，在系统环境变量里设置指向hug.exe的path即可在任意目录下运行hugo。在git-bash  terminal下测试安装是否正确：`hugo  version`

​       ![](images/hugo-setup-version.png)

* 建站

  保持下图所示的目录结构：
  
  ![](images/hugo-directoy-structure.png)
  
  `cd  site`
  
  `hugo  new site HuGoPaperMod -f yml `     (这里用-f yml指定建立yml格式的配置文件)
  
  `cd HugoPaperMod `                        (此时新建的HugoPaperMod项目下有下图所示的目录）：
  
  ![](images/hugo-directoy-structure-2.png)
  
  在这些目录下只有archetypes目录下有default.md一个文件，作为新建markdown文档的模板，内容如下：
  
  ~~~
  title: "{{ replace .Name "-" " " | title }}"
  date: {{ .Date }}
  draft: true
  ~~~
  ~~~
  git init    (先初始化当前的站点项目目录，否则下边的git submodule add 不能执行)
  git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod   （--depth=1指定只下载gitchub仓库最近的一次提交，不包括更多的历史提交记录）
  git submodule update --init --recursive   (needed when you reclone your repo,submodules may not get cloned automatically)
  到这里已经把PaperMod主题下载到themes目录下，如果提示`unable to access...`类似的错误信息，就多试几次，可能是因为https协议没有ssh协议稳定。
  ~~~
  
  在config.yml文件里添加`theme : "PaperMod"`。
  
  此时进入themes/PaperMode目录，如下图所示：
  
  ![](images/cloned-PaperMod.png)
  
  > 关键的一步：把PaperMod主题文件夹里面的的一些静态文件和配置文件复制到站点目录下，目的是为了可以自定义博客的样式，而不会改动主题文件夹里的样式，当引用的PaperMod主题有更新的时候，直接在主题目录下git pull就可以，站点目录的修改会优先覆盖主题里的配置，可以实现平滑更新。 
  
  这段文字来自[网友的博客文章](https://www.sulvblog.cn/posts/blog/build_hugo/)，是这段文字让我找到了一个问题：我是直接在themes/PaperMod下自定义部分样式文件(主要是layout目录里面的部分html文件和assets目录里面css文件),没有把这些需要自定义的模板等样式文件复制到博客项目根目录下再自定义，结果导致再本地使用hugo server 、localhost:1313时正常渲染出自定义效果，推送到github仓库浏览时却没有实现自定义效果。网友的回复是，hugo 在编译时会先使用项目根目录下的样式文件，如果没有的话才会到引用的主题下搜索这些样式文件，所以才会导致推送到github时引用的是原PaperMode仓库的样式文件。**所以下载完毕主题并添加配置文件后，把themes/papermod目录下的静态文件复制到项目根目录下覆盖原文件，然后根据需要进行自定义。**这里自定义实现的网页博客的样式，在PaperMod每个文档右侧以缩略图的形式显示cover image，个人挺喜欢这种小巧的样式。经过多次修改终于实现了这个效果，感谢网友分享的的文章。
  
  自定义cover image的网友文章链接：[Hugo博客文章封面图片缩小并移到侧边 | PaperMod主题](https://www.sulvblog.cn/posts/blog/img_right/)



