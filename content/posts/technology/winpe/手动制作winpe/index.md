---
title: "手动制作winpe"
date: 2023-07-02T13:29:48+08:00
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
    image: "images/冰山.jpg" # image path/url
---

#### 以win7为例手动创建winpe

##### 准备工作

* 在hyper-v下新建虚拟机，在新建的虚拟机里安装Windows7x64旗舰版
* 注册表修改工具Registry WorkShop、wim文件处理工具和7zip和wimtool
* 开文件夹选项对话框，选择`显示隐藏的文件、文件夹、驱动器`，去掉`隐藏受保护的操作系统文件`选项
* Windows7下的文件夹权限设置基础
* 新建一个目录software,在该文件夹下新建winre和iso_install_windows两个子文件夹，分别用来保存从wim包文件中提取处理的注册表配置单元文件

##### 基本思路

这里以winre.wim文件为基础进行修改，制作winpe（也可以用Windows ADK环境下用copype生成的boot.wim为基础制作winpe）

* 分别从install.wim文件和winre.wim文件中提取出注册表配置单元software（windows\system32\config\software），保存在自定义建立的目录software\iso_install_windows和software\winre目录下。
* 修改iso_install_windows\software注册表配置单元（修改从原windows7镜像文件中复制的注册表配置单元）
* 修改winre\software注册表配置单元，并导出为ToImport.reg（修改winre中的注册表配置单元，并导出以后合并）
* 挂载修改后的iso_install_windows\software注册表配置单元，双击合并ToImport.reg文件。（合并）
* 把修改后的iso_install_windows\software注册表配置单元文件替换到winre.wim包文件中（替换）
* 运行regedit,加载winre.wim的software为pe-soft,找到【HKEY-LOCAL-MACHINE|pe-soft|MicroSoft\Windows NT|CurrentVersion|Winlogon】,修改shell的键值为explorer.exe
* 从Windows系统目录添加Explorer相关支持文件到winre.wim中（添加Explorer支持文件）
* 把修改后的winre.wim替换到c:\revovery目录下的winre.wim即可完成手（覆盖c:\recovery目录下的winre.wim）
* 重启Windows,连续按下F8进入的系统修复模式，选择CMD命令窗口，输入explorer就可以显示基础的Explorer。
* 如果想要进一步的自定义explorer，就需要学习pecmd或者winxshell(WimBuilder2)。
