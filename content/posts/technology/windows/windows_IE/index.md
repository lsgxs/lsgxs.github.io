---
title: "Windows_IE"
date: 2023-07-28T21:55:53+08:00
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
---

#### 批处理设置IE可信站点自定义选项



现在的业务系统大部分时基于Windows IE浏览器的应用，设置好IE浏览器的各项参数，客户端通过浏览器链接到服务端打开应用。但是浏览器经常出现各种小问题，需要重新配置。由于IE的安全标签的可信站点自定义选项很多，手动设置有时候会出错，而且效率低，因此就考虑用批处理自动化设置。在设置之前，了解一下这些参数的保存位置，一般是保存在注册表的HKCU主键下：`HKEY_CURRENT_USER\SOFTWARE\WINDOWS\CURRENTVERSION\INTERNET SETTINGS\ZONES\2`。花了一下午时间，把这些项目整理在一个表格中，中英文对照更容易理解。


|序号 | 分类  |  自定义项目(中文) |  自定义项目(英文) | 编码 | 值   |
| :--:| :-------------------: | :-------------: | :--- | :--: | -- |
|  1   |  .NET Framework     |  XAML 浏览器应用程序 |                  XAML browser applications                   | 2400 |      |
|  2   |                                                             |                           XPS文档                            |                        XPS  documents                        | 2401 |      |
|  3   |                                                             |                           松散XAML                           |                          Loose XAML                          | 2402 |      |
|  4   |                   .NET Framework相关组件                    |                     带有清单的权限的组件                     |          Permissions for  components with manifests          | 2007 |      |
|  5   |                                                             |                运行未用Authenticode签名的组件                |         Run components not signed with Authenticode          | 2004 |      |
|  6   |                                                             |                运行已用Authenticode签名的组件                |           Run components signed with Authenticode            | 2001 |      |
|  7   |                      ActiveX控件和插件                      |                     ActiveX控件自动提示                      |          Automatic prompting for ActiveX  controls           | 2201 |      |
|  8   |                                                             |         对标记为可安全执行脚本的ActiveX控件执行脚本          |      Script ActiveX controls marked safe  for scripting      | 1405 |      |
|  9   |                                                             |    对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本     | Initialize and script ActiveX controls not marked as safe for scripting | 1201 |      |
|  10  |                                                             |                     二进制文件和脚本行为                     |                 Binary and script behaviors                  | 2000 |      |
|  11  |                                                             |       仅允许经过批准的域在未经提示的情况下使用ActiveX        |   Only allow approved domain to use ActiveX without prompt   |      |      |
|  12  |                                                             |                   下载未签名的ActiveX控件                    |             Download unsigned ActiveX  controls              | 1004 |      |
|  13  |                                                             |                   下载已签名的ActiveX控件                    |               Download signed ActiveX controls               | 1001 |      |
|  14  |                                                             |                       允许ActiveX筛选                        |                   Allow ActiveX Filtering                    | 2702 |      |
|  15  |                                                             |                        允许Scriptlet                         |                       Allow Scriptlets                       | 1209 |      |
|  16  |                                                             |           允许运行以前未使用的ActiveX控件而不提示            | Allow previously unused ActiveX controls  to run without prompt | 1208 |      |
|  17  |                                                             |                    运行ActiveX控件和插件                     |              Run ActiveX controls and plug-ins               | 1200 |      |
|  18  |                                                             |                在ActiveX空间上运行反恶意软件                 |        Run antimalware software on ActiveX  controls         |      |      |
|  19  |                                                             |        在没有使用外部媒体播放机的网页上显示视频和动画        | Display video  and animation on a webpage that does not use external media player |      |      |
|  20  |                            脚本                             |                        java小程序脚本                        |                  Scripting of java applets                   | 1402 |      |
|  21  |                                                             |                           活动脚本                           |                       Active scripting                       | 1400 |      |
|  22  |                                                             |                        启用XSS筛选器                         |                      Enable XSS filter                       | 1409 |      |
|  23  |                                                             |                   允许对剪贴板进行编程访问                   |             Allow Programmatic clipboard access              | 1407 |      |
|  24  |                                                             |                    允许通过脚本更新状态栏                    |             Allow status bar updates via script              | 2103 |      |
|  25  |                                                             |               允许网站使用脚本窗口提示获取信息               | Allow websites to prompt for information using scripted windows | 2105 |      |
|  26  |                            其他                             |                        呈现旧版筛选器                        |                    Render legacy filters                     |      |      |
|  27  |                                                             |                       持续使用用户数据                       |                    User data persistence                     | 1606 |      |
|  28  |                                                             |          低权限Web内容区域中的网站可以导航到此区域           | Websites in less privileged with content zone can navigate into this zone | 2101 |      |
|  29  |                                                             |                   加载应用程序和不安全文件                   |           Launching applications and unsafe files            | 1806 |      |
|  30  |                                                             |               将文件上载到服务器时包含本地目录               | Inclue local directory path when uploading files to a server | 160A |      |
|  31  |                                                             |                      跨域浏览窗口和框架                      |     Navigate windows and frames across different domains     |      |      |
|  32  |                                                             |                         启用MIME探查                         |                     Enable MIME Sniffing                     |      |      |
|  33  |                                                             |                    使用SmartScreen筛选器                     |                    Use SmartScreen Filter                    |      |      |
|  34  |                                                             |                     使用弹出窗口阻止程序                     |                      Use Pop-up Blocker                      | 1809 |      |
|  35  |                                                             |                      提交非加密表单数据                      |                Submit non-encrypted form data                | 1601 |      |
|  36  |                                                             |                       通过域访问数据源                       |              Access data sources across domains              | 1406 |      |
|  37  |                                                             |                    拖放或者复制和粘贴文件                    |            Drag and drop or copy and paste files             | 1802 |      |
|  38  |                                                             |                         显示混合内容                         |                    Display mixed content                     | 1609 |      |
|  39  |                                                             |                       允许META REFRESH                       |                      Allow META REFRESH                      | 1608 |      |
|  40  |                                                             |              允许Microsoft Web浏览器控件的脚本               |       Allow scripting of Microsoft web bowser control        | 1206 |      |
|  41  |                                                             |            允许脚本启动的窗口不受大小或者位置限制            | Allow script-initiated windows without size or  position constraints | 2102 |      |
|  42  |                                                             |              允许网页上的活动内容使用限制的协议              | Allow webpages to use restricted protocols for active content |      |      |
|  43  |                                                             |             允许网站打开没有地址或者状态栏的窗口             | Allow websites to open windows without address or status bars | 2104 |      |
|  44  |                                                             |               允许在不同窗口中的域之间拖动内容               | Allow dragging of content between domains into separate windows | 2709 |      |
|  45  |                                                             |                允许在同一窗口的域之间拖动内容                | Allow dragging of content between domains into the same window | 2708 |      |
|  46  |                                                             |                   在IFRAME中加载程序和文件                   |          Launching programs and files in an IFRAME           | 1804 |      |
|  47  |                                                             |           只存在一个证书时不提示进行客户端证书选择           | Don't prompt for client certificate selection when only one certificate exists | 1A04 |      |
|  48  |                 启用.NET Framework安装程序                  |                                                              |                 Enable .NET Framework setup                  | 2600 |      |
|  49  |                            下载                             |                           文件下载                           |                        File download                         | 1803 |      |
|  50  |                                                             |                           字体下载                           |                        Font download                         | 1604 |      |
|  51  |                        用户身份验证                         |                             登录                             |                            Logon                             | 1A00 |      |







|      |                            |                                                       |                                                              |      |      |
| ---- | -------------------------- | ----------------------------------------------------- | ------------------------------------------------------------ | ---- | ---- |
| 序号 | 分类                       | 自定义项目(中文)                                      | 自定义项目(英文)                                             | 编码 | 值   |
| 1    | .NET Framework             | XAML 浏览器应用程序                                   | XAML browser applications                                    | 2400 |      |
| 2    |                            | XPS文档                                               | XPS documents                                                | 2401 |      |
| 3    |                            | 松散XAML                                              | Loose XAML                                                   | 2402 |      |
| 4    | .NET Framework相关组件     | 带有清单的权限的组件                                  | Permissions for components with manifests                    | 2007 |      |
| 5    |                            | 运行未用Authenticode签名的组件                        | Run components not signed with Authenticode                  | 2004 |      |
| 6    |                            | 运行已用Authenticode签名的组件                        | Run components signed with Authenticode                      | 2001 |      |
| 7    | ActiveX控件和插件          | ActiveX控件自动提示                                   | Automatic prompting for ActiveX controls                     | 2201 |      |
| 8    |                            | 对标记为可安全执行脚本的ActiveX控件执行脚本           | Script ActiveX controls marked safe for scripting            | 1405 |      |
| 9    |                            | 对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本 | Initialize and script ActiveX controls not marked as safe for scripting | 1201 |      |
| 10   |                            | 二进制文件和脚本行为                                  | Binary and script behaviors                                  | 2000 |      |
| 11   |                            | 仅允许经过批准的域在未经提示的情况下使用ActiveX       | Only allow approved domain to use ActiveX without prompt     |      |      |
| 12   |                            | 下载未签名的ActiveX控件                               | Download unsigned ActiveX controls                           | 1004 |      |
| 13   |                            | 下载已签名的ActiveX控件                               | Download signed ActiveX controls                             | 1001 |      |
| 14   |                            | 允许ActiveX筛选                                       | Allow ActiveX Filtering                                      | 2702 |      |
| 15   |                            | 允许Scriptlet                                         | Allow Scriptlets                                             | 1209 |      |
| 16   |                            | 允许运行以前未使用的ActiveX控件而不提示               | Allow previously unused ActiveX controls to run without prompt | 1208 |      |
| 17   |                            | 运行ActiveX控件和插件                                 | Run ActiveX controls and plug-ins                            | 1200 |      |
| 18   |                            | 在ActiveX空间上运行反恶意软件                         | Run antimalware software on ActiveX controls                 |      |      |
| 19   |                            | 在没有使用外部媒体播放机的网页上显示视频和动画        | Display video and animation on a webpage that does not use external media player |      |      |
| 20   | 脚本                       | java小程序脚本                                        | Scripting of java applets                                    | 1402 |      |
| 21   |                            | 活动脚本                                              | Active scripting                                             | 1400 |      |
| 22   |                            | 启用XSS筛选器                                         | Enable XSS filter                                            | 1409 |      |
| 23   |                            | 允许对剪贴板进行编程访问                              | Allow Programmatic clipboard access                          | 1407 |      |
| 24   |                            | 允许通过脚本更新状态栏                                | Allow status bar updates via script                          | 2103 |      |
| 25   |                            | 允许网站使用脚本窗口提示获取信息                      | Allow websites to prompt for information using scripted windows | 2105 |      |
| 26   | 其他                       | 呈现旧版筛选器                                        | Render legacy filters                                        |      |      |
| 27   |                            | 持续使用用户数据                                      | User data persistence                                        | 1606 |      |
| 28   |                            | 低权限Web内容区域中的网站可以导航到此区域             | Websites in less privileged with content zone can navigate into this zone | 2101 |      |
| 29   |                            | 加载应用程序和不安全文件                              | Launching applications and unsafe files                      | 1806 |      |
| 30   |                            | 将文件上载到服务器时包含本地目录                      | Inclue local directory path when uploading files to a server | 160A |      |
| 31   |                            | 跨域浏览窗口和框架                                    | Navigate windows and frames across different domains         |      |      |
| 32   |                            | 启用MIME探查                                          | Enable MIME Sniffing                                         |      |      |
| 33   |                            | 使用SmartScreen筛选器                                 | Use SmartScreen Filter                                       |      |      |
| 34   |                            | 使用弹出窗口阻止程序                                  | Use Pop-up Blocker                                           | 1809 |      |
| 35   |                            | 提交非加密表单数据                                    | Submit non-encrypted form data                               | 1601 |      |
| 36   |                            | 通过域访问数据源                                      | Access data sources across domains                           | 1406 |      |
| 37   |                            | 拖放或者复制和粘贴文件                                | Drag and drop or copy and paste files                        | 1802 |      |
| 38   |                            | 显示混合内容                                          | Display mixed content                                        | 1609 |      |
| 39   |                            | 允许META REFRESH                                      | Allow META REFRESH                                           | 1608 |      |
| 40   |                            | 允许Microsoft Web浏览器控件的脚本                     | Allow scripting of Microsoft web bowser control              | 1206 |      |
| 41   |                            | 允许脚本启动的窗口不受大小或者位置限制                | Allow script-initiated windows without size or position constraints | 2102 |      |
| 42   |                            | 允许网页上的活动内容使用限制的协议                    | Allow webpages to use restricted protocols for active content |      |      |
| 43   |                            | 允许网站打开没有地址或者状态栏的窗口                  | Allow websites to open windows without address or status bars | 2104 |      |
| 44   |                            | 允许在不同窗口中的域之间拖动内容                      | Allow dragging of content between domains into separate windows | 2709 |      |
| 45   |                            | 允许在同一窗口的域之间拖动内容                        | Allow dragging of content between domains into the same window | 2708 |      |
| 46   |                            | 在IFRAME中加载程序和文件                              | Launching programs and files in an IFRAME                    | 1804 |      |
| 47   |                            | 只存在一个证书时不提示进行客户端证书选择              | Don't prompt for client certificate selection when only one certificate exists | 1A04 |      |
| 48   | 启用.NET Framework安装程序 | 启用.NET Framework安装程序                            | Enable .NET Framework setup                                  | 2600 |      |
| 49   | 下载                       | 文件下载                                              | File download                                                | 1803 |      |
| 50   |                            | 字体下载                                              | Font download                                                | 1604 |      |
| 51   | 用户身份验证               | 登录                                                  | Logon                                                        | 1A00 |      |