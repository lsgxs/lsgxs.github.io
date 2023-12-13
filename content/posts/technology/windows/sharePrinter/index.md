---
title: "Windows局域网共享打印机"
date: 2023-12-13T16:02:02+08:00
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
    image: "images/clound_grass.jpg" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
---

#### 在Windows局域网中共享打印机

* 把要访问的印机设置为共享打印机

* 鼠标右键弹出快捷菜单并选择属性，打开网络和共享中心窗口。然后选择窗口左侧的【更改高级共享设置】，选择启用文件和打印机共享，并关闭密码访问计算机选项。

* 在控制面板的管理工具中，打开本地策略，点击【安全选项】，在右侧底部列表中选择开启guest。如下图所示：

  ![img](images/Securities.jpg)

* 选择本地策略下的用户权限分配，在右侧列表中找到【拒绝从网络访问这台计算机】，从中删除guest项目，也就是允许guest通过网络访问这台计算机。如下图所示：

  ![img](images/connectByGuest.jpg)

* 在本机Windows左下角打开搜索框，输入如下格式的目标主机IP地址

  ```
  \\10.121.x.x
  ```

  正常情况下应该能看到目标计算机上共享的打印机，双击直接安装驱动成功就可以共享打印机。

* 如果上面几个项目都做好了，但是还是不能访问目标计算机的共享打印机，在安全前提下，可以先临时关闭目标打印机的防火墙，应该就可以访问共享打印机。有时间可以研究一下防火墙的设置项目，只是开启ip的ping功能即可。具体可以多多实践。如果可以把以上几个步骤做成一个批处理就再好不过了，运行批处理实现局域网共享打印机功能。
