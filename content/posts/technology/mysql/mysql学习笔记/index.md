---
title: "Mysql学习笔记"
date: 2023-12-25T20:14:00+08:00
draft: false
# weight: 2
tags: ["first"]
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
searchHidden: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
UseHugoToc: false
ShowCodeCopyButtons: true
cover:
    image: "images/冰山.jpg" 
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

#### 获取指定版本的mysql

* 根据使用的操作系统：unix /linux、windows  、macOS，选择下载对应版本的[MySQL](https://dev.mysql.com/doc/refman/8.0/en/getting-mysql.html)
* 使用MD5等校验工具，检测下载的MySQL与官网是否一致。

#### 在Windows下安装mysql

在Windows下安装mysql的最简单的方法是使用[MySQL  installer](https://dev.mysql.com/downloads/installer/),建议在64位的Windows下使用MySQL。使用MySQL installer安装MySQL时，有四个安装类型选择：

* **development**
* **server only**
* **Dedicated**
* **Manual**

#### 在Windows的cmd下操作mysql

* 连接到mysql数据库服务器

  ```
  mysql  -u  root -p
  
  #或者指定hostname
  #当然在本机不需要指定-h  127.0.0.1，只是需要了解这种格式。mysql服务默认使用3306端口，所以在指定-h hostname 时不许要指定端口号，主机名称也不需要加引号包裹。
  mysql  -h  127.0.0.1   -u  root  -p    
  mysql  -h  10.190.21.23   -u  root  -p
  ```

  