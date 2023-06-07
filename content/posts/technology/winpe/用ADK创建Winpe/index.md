---
title: "用ADK创建Winpe"
date: 2023-06-08T07:13:44+08:00
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

#### [下载并安装 Windows ADK](https://learn.microsoft.com/zh-cn/windows-hardware/get-started/adk-install#other-adk-downloads)

查看windows系统的版本号，下载对应版本的ADK,运行adksetup。

​     ![](images/adk_winpe.png)

![](images/adk-setup.png)

![](images/adk-setup2.png)

#### [下载并安装WinPe加载项](https://go.microsoft.com/fwlink/?linkid=2022233)

下载对应版本的WINpe加载项并安装

![](images/winpe-load.png)

![](images/winpe-load2.png)

* 安装好ADK和WInpe加载项之后，使用copype复制到指定的目录

  copype   amd64    d:\win10pe   

* MakeWinpeMedia   /UFD    d:\win10pe   X:

  制作可启动的U盘，此时的U盘盘符为X，会删除U盘上所有的数据，注意核对正确 。
