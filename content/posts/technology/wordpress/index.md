---
title: "在本地计算机安装Wordpress"
date: 2022-12-16T22:23:57+08:00
draft: false
# weight: 2
tags: ["wordpress"]
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
ShowCodeCopyButtons: true
cover:
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

####   安装  xampp、下载 wordpress

* 把解压后的wordperss目录复制在xampp的htdocs目录下，这里为c:\xampp\htdocs\wordpress

* 启动xampp面板，选择 start  Apache、start mysql。如果有别的web服务器启动，需要先停止服务。比如本机自动启动caddy的话，终止caddy服务，解决端口冲突，因为这里有Apache启动。

#### 使用phpMyAdmin创建mysql数据库。

* 打开浏览器，在地址栏输入localhost，此时会显示`Welcome to XAMPP for Windows `，点击屏幕顶部的`phpMyAdmin`，进入数据库设置面板。或者直接在地址栏输入`localhost/wordperss/phpMyAdmin`

* 选择左侧目录树顶部的`新建`，输入数据库名称，序规则选择 utf8mb4_general_ci。之后，点击“创建”按钮继续

  ![](images/wordpress-setup.png)
  ![](images/wordpress-setup-create-database.png)
  ![](images/wordpress-setup-create-database-2.png)
  这里设置root用户的密码暂时为空密码
  
 #### 连接数据库

   在浏览器地址栏输入`localhost/wordpress` ，配置连接数据库的参数。需要输入前边创建的数据库名称和用户名(root)

 ![](images/wordpress-setup-create-database-3.png)
  提示信息显示wordpress已经可以和新建的数据库通讯了，开始安装wordpress.

 #### 安装wordpress

  ![](images/wordpress-setup-create-database-4.png)

####  wordpress dashboard

登录wordpress的管理界面dashboard（在没有学会重置密码前，最好记录好数据库用户名、密码和站点登录的用户名和密码，时间长了可能会忘记）

![](images/dashboard.png)



下面就可以在dashborad里熟悉各种功能，比如下载和应用themes,让你自己的网站符合自己的审美需求。

#### 总结

wordpress是用php开发的基于Web(Apache)和数据库(mysql等)的内容管理系统(CMS)。而xampp是方便用户使用wordpress的本地集成环境。

  
