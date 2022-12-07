---
title: "Papermod参数设置"
date: 2022-11-22T17:20:56+08:00
draft: false
showToc: true
TocOpen: true
UseHugoToc: false
ShowCodeCopyButtons: true
weight: 2
cover:
  image: "images/冰山.jpg"
---

#### PaperMod主题config.yml文件的常用参数及设置

* paginate : 8  一页显示8个文档
* theme: PaperMod   主题名称
* ShowCodeCopyButtons: 显示代码复制按钮
* UseHogoToc: false      设置为false，可以使用下面两项使用PaperMod自带的toc设置
* showtoc: true
* tocopen: true 
*  weight： 决定这篇文章的优先级，可以把经常需要看的置顶，设置为1、2、3等顺序。
* ProfileMode:
  * enabled :  true  设置为true的话，主题显示为profile mode 风格，设置为false为regular常规模式

* menu下的main : 

  identifier: archives

     name: archives

     url: /archives/

     weight: 10

    \- identifier: posts

     name: posts

     url: /posts/

     weight: 10

    \- identifier: tags

     name: tags

     url: /tags/

     weight: 20

    \- identifier: search

     name: search

     url: /search/

     weight: 10  

​        这里对应的是模板文件：archives、posts、search

先记录这些，基本可以让博客运行起来，其他的可以再测试。

#### Front Matter区域的参数设置

~~~
itle: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
# weight: 1
# aliases: ["/first"]
tags: ["first","删除github分支","github分支"]  
author: "Me"
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: true
draft: false
hidemeta: false
comments: false
description: "Desc Text."
canonicalURL: "https://canonical.url/to/page"
disableHLJS: true # to disable highlightjs
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: true
ShowReadingTime: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: false
ShowRssButtonInSectionTermList: true
UseHugoToc: false
cover:
    image: "images/冰山.jpg" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
~~~

