---
title: "Caddy入门之QuickStart"
date: 2022-12-02T21:31:59+08:00
draft: false
# weight: 2
tags: ["first"]
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

#### 安装caddy

* 获取Caddy

   - [ releases on GitHub](https://github.com/caddyserver/caddy/releases) )

      (expand "Assets")

     - Refer to [Verifying Asset Signatures](https://caddyserver.com/docs/signature-verification) for how to verify the asset signature

   - [caddy download page](https://caddyserver.com/download)

*  安装
   * [把 Caddy作为系统服务安装.](https://caddyserver.com/docs/running#manual-installation) 推荐这种安装方式。
   * 因为caddy本事就是一个独立的可执行文件，不需要再安装，把下载到的caddy.exe放在自己的工作目录下，然后把caddy.exe所在的目录加入系统环境变量。如果需要升级caddy,直接用新的caddy.exe覆盖。
####  命令行运行caddy

首先把目录切换到站点目录下。这里所谓的站点，是至少包含有index.html文件的目录，用来测试caddy的静态文件服务。

     ~~~
     caddy file-server 
     ~~~

在浏览器地址栏输入`http://localhost`或者`localhost`

~~~
caddy file-server --listen  :2015
~~~

第二个命令行加了`--listen`参数和端口号。此时在浏览器地址栏输入：`http://localhost:2015`或者`localhost:2015`。

> 这前边两个命令行显示index.html的内容，如果没有index.html文件，浏览器自然什么也没有，我以为是哪里出错了。

~~~
caddy file-server --browse
~~~

第三个命令行多了一个`--browse`参数，意思是可以在浏览器查看当前站点目录的文件，如果有index.html则显示index.html的内容，如果没有index.html文件，就会显示当前站点的所有目录及文件。也就是说file-server会优先显示站点目录的主页，如果没有主页则会显示站点所有目录及文件列表，文本文件可以直接打开，其他文件可通过浏览器下载。

~~~
caddy file-server --browse --root  c:\tools  
~~~

第四个命令指定了`--root`参数，指定站点根目录为c:\tools

> 注意：
>
> 1、要在站点根目录下编辑一个内容简单的index.html文件，只是输出`hello caddy`也可以。如果没有index.html的话，前两个命令行（没有`--browse`参数）运行后，在浏览器输入`localhost`后什么也没有，不知道是哪里出问题。caddy是一个web服务器，默认你是来搞web站点的，index.html是标配。
>
> 2、在命令行下运行caddy，根据cmd信息提示，并不会自动添加https协议，在浏览器地址栏输入时为：`http:localhsot`,或则直接输入localhost。如下图：

![](caddy-cmd-http.png)

#### 使用Caddyfile运行caddy

* 在站点根目录建立名称为Caddyfile的文本文件，不带扩展名(也可以在编辑好内容之后把扩展名删除）。

~~~
localhost

file_server


#这两行命令是显示站点根目录下的index.html，如果没有自然是空白，以为是哪里出错了。
#以Caddyfile配置文件的方式使用caddy run 启动，会自动转换为https协议
~~~
`caddy  run `

如果站点根目录下没有index.html文件，但是想显示文件列表的话，就在file_server后添加browse参数。关于file_server的详细用法，看最后的官方文档链接。

~~~
localhost
file_server browse
~~~

![](caddy-cmd-https.png)



[file_server](https://caddyserver.com/docs/caddyfile/directives/file_server)参数详细用法

