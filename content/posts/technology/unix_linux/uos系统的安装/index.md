---
title: "Uos系统的安装"
date: 2023-07-24T19:56:18+08:00
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
   
---

十年前玩过linux,感觉熟悉了基本的玩法，但是并没有做笔记的习惯，发现好多以前了解比较深入和细致的知识点，现在好多都忘记了，甚至要从新再拾起来。工作中也许有机会更换到linux平台。先记录个最基本的入门知识，安装linux的发行版通信UOS，一个国产Linux发行版，是收购了Deepin Linux之后的发行版。毕竟是国产的发行版，使用起来简单很多。在熟悉unix&linux基本知识之前，最基础的应该是对分区的认识。下面是几种常见的分区方案：

#### 三种分区方案

* 两个分区：linux的根分区/（至少10G以上空间）和一个swap分区

* 三个分区：linux根分区/、swap分区和boot分区

* 多个分区： 

  * linux根分区/,类型是主分区，文件系统ext4,挂载与/，须大于10G

  * swap分区，交换分区，文件类型为linux-swap，相当于windows的虚拟内存。物理内存小于4G的，swap设置为2倍内存大小；内存大于4g且小于16G,设置为内存大小的swap空间。
  * boot分区，存储引导信息，一般设置为2G
  * home分区,用于存放文件，设置为100G
  * /usr/local  存储应用软件安装信息，
  * opt分区  
  * var分区   系统日志信息。一般是服务器用的分区，普通电脑可不用新建此分区, 分区大小根据服务器功能多少决定分区空间大小。
  * recovery   在尾部的一个恢复分区，设置为10G

最好一个分区一个挂载点， 建立交换分区和恢复分区时，自动分配挂载及磁盘文件系统格式， 其他分区要手动挂载并且手动选磁盘文件系统格式，选EXT4就行。最好不要只分单一分区即只有1个根分区，如果根分区被破坏了，那整个电脑资料就丢失了。分配多个分区的话，某一个分区坏掉了，不会影响其他分区的数据。

#### 安装

从上面的分区方案来看，除了Windows之外，至少留两个以上的主分区。如果一台机器上只安装linux在分区要简单点，可以直接选择UOS提供的全部安装，会自动创建以上分区。新入门最好选择手动安装，熟悉一下多分区的创建。

* 下载UOS ISO镜像

* 在Deepin linux的网站上下载deepin-boot-make制作U盘安装工具。也可以使用rufus.exe来制作UOS安装U盘

* U盘启动后，选择手动安装模式，新建根分区(/,20G)、boot分区(3G)、swap分区(8G)、home分区(30G)、/usr/local (30G),把系统装在/分区。

* 安装完毕后，系统重启，如果有Windows系统共存，会显示多启动菜单。如下图：

  ![img](images/bootmgr.jpg)

* 登录系统后，显示类似X-windwos的可视化窗口，操作起来和windows很像。如果网络通畅的话，可以在应用商店里应用程序

  ![img](images/appstore.png)

* 可以在控制中里找到通用，然后找到启动菜单(设置启动延迟)、开发者模式（开启root用户权限）

![img](images/ControlCenter.png)

到这里就可以使用UOS来完成基本的办公环境的构建，如果国产替代把办公设备的硬件适配做的再好点，国产替代也是很有市场和希望的，国产加油。

#### Unix&Linux的基础知识学习

##### Unix&Linux的发展历史

懒的不想再码字，不想去翻翻书本的描述，这里有网上的链接:[Unix&Linux发展史](https://blog.csdn.net/Tach1banA/article/details/118395964),可以快速学习一下，如果想深入了解，还是翻翻还没有阅读大部头Linux书本，记得要做好笔记。这里想认识一下一下Debian、Ubuntu、Redhat、CentOS这几个Linux发行版。作为新手就先从Ubuntu入手吧。

##### Linux的常见命令

U