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

  如果安装的Windows ADK的版本和所使用的的Windows版本不匹配，使用copype命令时会提示找不到amd64架构处理器，如下图所示：

  ![](images/copype_err.png)
所以，在下载Windows ADK和Winpe加载项之前，查看当前使用的Windows系统的版本，下载对应的Windows ADK和Winpe加载项。
* MakeWinpeMedia   /UFD    d:\win10pe   X:

  制作可启动的U盘，此时的U盘盘符为X，会删除U盘上所有的数据，注意核对正确（ MakeWinPEMedia will format your Windows PE drive as FAT32）

* 使用制作好的U盘启动，运行只有CMD窗口的Winpe
  * 运行notepad
  * 选择File /open，打开文件系统浏览器，查看下载好的Windows安装盘所在的驱动器和目录（可以提前把下载好的原版Windows安装盘加压到指定的驱动器或者另外一个U盘）
  * 切换到安装文件所在的目录，运行setup,就可以正常完成Windows安装

+++

下面的内容是微软公司官方文档的部分内容：

### Create a bootable Windows PE USB drive

1. Attach a USB drive to your technician PC.

2. Start the **Deployment and Imaging Tools Environment** as an administrator.

3. **Optional** You can format your USB key prior to running MakeWinPEMedia.  MakeWinPEMedia will format your Windows PE drive as FAT32. If you want  to be able to store files larger than 4GB on your Windows PE USB drive,  you can create a multipartition USB drive that has an additional  partition formatted as NTFS. See [Create a multipartition USB drive](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe--use-a-single-usb-key-for-winpe-and-a-wim-file---wim?view=windows-11#option-1-create-a-multiple-partition-usb-drive) for instructions.

4. Use **MakeWinPEMedia** with the `/UFD` option to format and install Windows PE to the USB flash drive, specifying the USB key's drive letter:

   Windows Command Prompt 	

1. ```cmd
   MakeWinPEMedia /UFD C:\WinPE_amd64 X:
   ```

    Warning: This command reformats the partition.

   See [MakeWinPEMedia command line options](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/makewinpemedia-command-line-options?view=windows-11) for all available options.

The bootable Windows PE USB drive is ready. You can use it to [boot a PC into Windows PE](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/boot-to-uefi-mode-or-legacy-bios-mode?view=windows-11).
