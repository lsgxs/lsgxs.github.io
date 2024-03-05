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

* 鼠标右键点击桌面的网络图标，在弹出的快捷菜单中选择【属性】菜单项，打开网络和共享中心窗口。然后选择窗口左侧的【更改高级共享设置】，选择启用网络发现、启用文件和打印机共享、关闭密码保护共享这三个选项。

* 在控制面板的管理工具中，打开本地策略，点击【安全选项】，在右侧底部列表中选择开启guest。如下图所示：

  ![img](images/Securities.jpg)

* 选择本地策略下的用户权限分配，在右侧列表中找到【拒绝从网络访问这台计算机】，从中删除guest项目，也就是允许guest通过网络访问这台计算机。如下图所示：

  ![img](images/connectByGuest.jpg)

* 选择本地策略下的用户权限分配，在右侧列表中找到【从网络访问这台计算机】,根据需要添加用户（比如everyone、guest，具体可以测试一下）。
  ![img](images/access-from-network.png)

  ![img](images/access-from-network-2.png)

* 在本机Windows左下角打开搜索框，输入如下格式的目标主机IP地址

  ```
  \\10.121.x.x
  ```

  正常情况下应该能看到目标计算机上共享的打印机，双击共享打印机图标安装驱动，驱动安装成功后可以共享打印机。

* 如果上面几个步骤都做好了，还是不能访问目标计算机的共享打印机，在安全前提下，可以先临时关闭目标打印机所在计算机的防火墙，应该就可以访问共享打印机。有时间可以研究一下防火墙的设置项目，只是开启ip的ping功能即可（可以在防火墙的高级设置中设置文件和打印机访问的入站规则）。具体可以多多实践。如果可以把以上几个步骤做成一个批处理就再好不过了，运行批处理实现局域网共享打印机功能。也可以试试联想公司官方提供的局域网共享工具。
  

> 此文档内容是在Windows7下完成设置的，windows10的上的设置原理相同，操作界面有不同之处。

> 总结一下：
>
> * 设置共享
>
>   * 设置共享打印机
>   * 设置高级共享（启用网络发现、启用文件和打印机共享、关闭密码保护共享）
>
> * 设置账号（在控制面板的管理工具中打开本地安全策略）
>
>   * 启用来宾账号guest（控制面板->管理工具->本地安全策略->本地策略->安全选项->帐户：来宾帐户状态->启用）
>   
>   * 本地帐户的共享和安全模型：控制面板->管理工具->本地安全策略->本地策略->安全选项->网络访问：本地帐户的共享和安全模型(仅来宾)
>   
>   * 从网络中访问此计算机按中允许访问中添加guest（控制面板->管理工具->本地安全策略->本地策略->用户权限分配->从网络访问此计算机->添加gues用户）
>   
>   * 拒绝从网络中访问此计算机中删除guest（控制面板->管理工具->本地安全策略->本地策略->用户权限分配->删除guest用户）
>   
>     
>
> 也可以试试批处理的方法实现，下面的代码先保存，有机会试试再修改一下

```bash
@echo off  
setlocal enabledelayedexpansion  
  
echo ====1.Enable network discovery and file and printer sharing====
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Network\LanmanServer" /v "EnableNetBIOS" /t 

REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\NetworkProvider" /v "NPAllowUniversalXPNSearch" /t 

REG_DWORD /d 1 /f  
net share * /GRANT:Everyone,FULL /REMARK:"Password Protected Shares Disabled"  
  
echo 2. 设置本地安全策略...  
REM 这里需要手动打开本地安全策略管理器并进行设置，无法通过批处理脚本自动完成。  
  
echo ====3.Enable the guest account and configure access permissions====  
net user Guest /active:yes  
net user Guest /add  
net localgroup "Guests" Guest /add  
net localgroup "Deny access to this computer from the network" | findstr /i /c:"Guest" > nul  
if %errorlevel%==0 (  
    net localgroup "Deny access to this computer from the network" /delete Guest > nul  
    if %errorlevel%==0 (  
        echo Guest user has been removed from the "Deny access to this computer from the network" list.  
    ) else (  
        echo Failed to remove Guest user from the list.  
    )  
) else (  
    echo Guest user is not in the "Deny access to this computer from the network" list.  
)  
  
echo ====4.Turn off the firewall and prompt the user to restart the computer====

netsh advfirewall set publicprofile state off  
netsh advfirewall set privateprofile state off  
set /p answer="Do you want to restart your computer to apply the new settings? (y/n): "  
if /i "%answer%"=="y" (  
    echo Restarting the computer...  
    shutdown /r /t 0  
) else (  
    echo No restart requested. Please restart manually to apply the changes.  
)

echo.  
echo Operations completed. Do you want to restart the computer? (Y/N):  
set /p choice="Please enter Y or N: "  
  
if /i "!choice!"=="Y" (  
    echo You have chosen to restart the computer.  
    shutdown /r /t 0  
) else if /i "!choice!"=="N" (  
    echo You have chosen not to restart the computer.  
) else (  
    echo Invalid input. Please enter Y or N.  
    pause  
)  


```

