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
### 安装Windows ADK 及Winpe加载项
#### [下载并安装 Windows ADK](https://learn.microsoft.com/zh-cn/windows-hardware/get-started/adk-install#other-adk-downloads)

查看windows系统的版本号，下载对应版本的ADK,运行adksetup。

​     ![](images/adk_winpe.png)

![](images/adk-setup.png)

![](images/adk-setup2.png)

#### [下载并安装WinPe加载项](https://go.microsoft.com/fwlink/?linkid=2022233)

下载对应版本的WINpe加载项并安装

![](images/winpe-load.png)

![](images/winpe-load2.png)
### 创建基础的Winpe

* 安装好ADK和WInpe加载项之后，点击Windows桌面左下角的Windows图标，打开程序菜单，选择【部署和映像工具环境】

  

  ![](images/deploy_tools_env.png)

  打开CMD窗口后运行下面的命令：

  copype   amd64    d:\win10pe   

  执行结果如下图：

  ![](images/copype.png)

  

  如果没有选择从【部署和映像工具环境】打开CMD窗口，而是在CMD窗口中手动切换目录到部署和映像工具所在的目录，使用copype命令时会提示找不到amd64架构处理器，如下图所示：

  ![](images/copype_err.png)
  出现这个问题的根本原因是设置环境变量的问题，如果要手动执行的话，就需要自己修改copype.cmd里的脚本，如下：

  ```
  rem
  rem Set environment variables for use in the script
  rem
  set WINPE_ARCH=%1
  **set WinPERoot=C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment**
  set SOURCE=%WinPERoot%\%WINPE_ARCH%
  **set OSCDImgRoot=C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg**
  set FWFILESROOT=%OSCDImgRoot%\..\..\%WINPE_ARCH%\Oscdimg
  set DEST=%~2
  set WIMSOURCEPATH=%SOURCE%\en-us\winpe.wim
  
  ```

  这段代码是引用自CSDN上一个博主的文章[win10PE iso镜像制作及问题解决](https://blog.csdn.net/weixin_43863487/article/details/116117714)
  
  总结一下：作为新手的我，还是选择从【部署和映像工具环境】菜单项打开CMD，然后执行copye    amd64   d:\win10pe为好。
* MakeWinpeMedia   /UFD    d:\win10pe   X:

  制作可启动的U盘，此时的U盘盘符为X，会删除U盘上所有的数据，注意核对正确（ MakeWinPEMedia will format your Windows PE drive as FAT32）。这里的d:\win10pe是前边`copype  amd64   d:\win10pe`命令行里指定的目录

* 使用制作好的U盘启动，运行只有CMD窗口的Winpe
  * 运行notepad
  * 选择File /open，打开文件系统浏览器，查看下载好的Windows安装盘所在的驱动器和目录（可以提前把下载好的原版Windows安装盘解压到指定驱动器或者另外一个U盘）
  * 切换到安装文件所在的目录，运行setup,就可以正常完成Windows安装

+++

下面的内容是微软公司官方文档的部分内容：

#### [Create bootable Windows PE media](Create bootable Windows PE media)
### 扩展基础Winpe功能之添加Explorer
#### 工作目录及注册表权限的修改

* 鼠标右击目录winpe-amd64(Winpe所在的工作目录)，选择属性，在弹出的对话框中选择安全标签，点击高级。如下图所示：

  ![img](images/security-1.png)
  
* 更改目录的所有者为当前用户(如果不清楚当前用户名，可在cmd命令窗口下用whoami命令显示当前用户名)。

  ![img](images/owner-1.png)

  ​                            ![img](images/search.png)
  ![img](images/selections.png)
* 为当前用户添加权限
  
  ![img](images/add-1.png)
  ![img](images/add-2.png)
  ![img](images/add-3.png)
  ![img](images/add-4.png)
  
  添加权限就两步：第一步是把工作目录的所有者更改为当前用户；第二部是为当前用户添加所有权限；注意继承和替换子容器和对象所有者两个选项都要选，添加权限时选择全部权限。在后边的修改注册表时也用同样的方法设置权限。

#### 搜索并添加Exlorer的支持文件
#### 修改注册表