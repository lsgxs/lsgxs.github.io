---
title: "快速安装和使用hugo"
date: 2022-11-01T22:32:10+08:00
draft: false
cover:  
  image: "冰山.jpg"
ShowCodeCopyButtons: true
---

#### 安装hugo

* hugo一个快速的博客生成器，只需要下载一个二进制的可执行文件即可。下载后可以保持下面的目录结构：
  * c:/hugo/bin   --把这个目录的路径添加在Windows的系统path里。
  * c:/hugo/sites

* 新建一个hugo 站点
  ~~~
  cd sites
  hugo new site quickstart 
  cd quickstart
  git init 
  git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
  -- 修改config.toml文件，添加theme  = "theme-name"
  ~~~

* 新建一个文档

  hugo new  posts/your-first-post.md        --posts是hugo项目保存marddown文档的目录

  ~~~
   hugo new posts/以文档的名字作为目录名称-不能包含空格/index.md     
  
   --真正的markdown文档是index.md ，以目录为核心来组织文档，在index.md的同级目录下建立image目录，保存文档引用的图片。
   --用这种方式来组织hugo文档，在渲染文档引用的图片时不易出错。
  ~~~

  

* hugo server -D   --注意这里是大写字母D   --把生成的静态网页文件保存在public目录，然后

  ​                                                                         --在浏览器用http://localhost:1313可以浏览文档

* 一般可以采用hugo `--cleanDestinationDir` 来全新生成博客文档


