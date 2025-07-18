---
title: "在github基于项目GitHub Pages部署hugo博客"
date: 2022-11-12T16:43:00+08:00
draft: false
cover:
  image: "images/在github基于项目GitHubPages部署hugo博客/向日葵.jpg"
---
前面有两篇笔记专门记录基于个人或者公司GitHub Pages发布hugo博客站点的方法。这篇笔记记录如何在基于项目的GitHub Pages部署博客站点。
* 在github上建立一个项目类型的空白仓库（不要选择readme文件初始化仓库),仓库名称为hugo。

  * 本地的仓库时现成的.git仓库时，远程的github仓库最好是空仓，操作起来简单。
  * 如果远程是现成的.git仓库，就直接git clone到本地，然后再添加项目。
  
* 设置main分支的docs作为静态网页发布目录

  关于在static目录下存放资源文件的方法，再专门写一篇文章

  ![](images/github-pages-docs.png)

* 参照hugo官网的[QuickStart](https://gohugo.io/getting-started/quick-start/)项目步骤，在本地建立hugo博客项目。

  <!--more-->

  ~~~
  hugo  new site hugo
  cd hugo
  git init 
  git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
  --编辑项目根目录下的config.toml文件，在最后添加theme数据项
  theme = "ananke"
  ~~~

* 添加一些文档

  ~~~
  hugo new posts/quickstart/index.md 
  --这里采用的是文档名作为目录，在目录下面把文档名称修改为index.md的文档结构
  --如果文档不需要引用图片，就可以采用hugo默认的文档结构： hugo new posts/my-first-post.md
  --直接在posts目录生成.md的文档。
  ~~~
  
* 新建docs目录  

* 编辑hugo项目根目录的config.toml文件，添加下面的数据项

  * publishdir = "docs"  # 将生成的静态页面文件夹设置到 docs 下

*  编译文档并在本地发布浏览
  ~~~
  hugo server -D  
    --经试验发现hugo  server 只是在内存中渲染这些文件，通过自带的web服务器显示这些文件，并没有在指定的   --docs目录下生成静态网页文件。
    --要正式生成静态网页文件，需要单独使用hugo或者 hugo  -D  ,参数-D 是包含draft参数为真的文档也会生成   --静态文件
    http://localhost:1313 
    --默认是这个端口，有时候要看server随机分配的端口
    --在发布到github时，必须要设置编辑config.toml文件，设置baseURL数据项，比如：
    --baseURL = 'https://username.github.io/hugo'  
    --如果不设置这个数据项的话，静态文件不能被正常渲染
  ~~~
~~~
经过自定义发布目录的设置，原来默认生成在public目录下的文件，现在会保存在docs目录下。推送到github项目仓库的main分支后，就可以使用https://username.github.io/hugo访问博客，这就是基于项目的pages使用方法。
~~~
* 最后推送到github的hugo仓库main分支
  * git  add .
  * git commit -m "updae $(date)"
  * git push origin main 
  * https://username.github.io/hugo

下面的步骤介绍如何使用单独的gh-pages分支保存发布的静态网页文件。如果不使用单独的分支来保存静态网页文件，就要设定发布源为Github Actions,如下图所示
![](images/github-pages-docs.png)

*    建立独立的分支gh-pages,用来保存发布的静态网页文件

  * git checkout  `--orphan` gh-pages

  * 修改一下readme文件的内容，让下一步可以提交和推送

  * git add .

  * git commit -m "changes readme"

  * git push -u origin gh-pages   `第一次推送到远程需要指定本地分支，默认新建同名的远程分支`

  * git branch -a      `此时就可以查看到刚刚新建的独立分支，如果不修改和添加、提交、推送就看不到新建的分支`

* 在多分支下使用hugo server -D生成public目录时，有时候需要先切换到其他分支，然后再切换回来才能看到生成的public目录及其下面的文件。

* 在新建独立分支gh-pages时，会复制项目的main分支下的内容，gh-pages是用来发布编译后的静态网页文件的，所有这里要删除.git目录之外的所有的内容，然后再次推送到github：
  * git add .
  * git commit -m "delete file in gh-pages copied from main branch of hugo"
  * git push origin gh-pages
  * 此时就把gh-pages分支下的所有内容删除了，将来就可以保存发布的静态网页文件。
  * 在多分支仓库推送到远程时，第一次写出具体的本地分支和远程分支对应关系，以后推送就不用了，直接简写: git push origin 就可以。
