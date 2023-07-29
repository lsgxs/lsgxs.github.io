---
title: "Windows_IE"
date: 2023-07-28T21:55:53+08:00
draft: false
# weight: 2
tags: ["first"]
# author: ["Me", "You"] # multiple authors
showToc: false
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
    image: "images/冰山.jpg" 
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true  
---

#### 批处理设置IE可信站点自定义选项



现在的业务系统大部分时基于Windows IE浏览器的应用，设置好IE浏览器的各项参数，客户端通过浏览器链接到服务端打开应用。但是浏览器经常出现各种小问题，需要重新配置。由于IE的安全标签的可信站点自定义选项很多，手动设置有时候会出错，而且效率低，因此就考虑用批处理自动化设置。在设置之前，了解一下这些参数的保存位置，一般是保存在注册表的HKCU主键下：`HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS\ZONES\2`。花了一下午时间，把这些项目整理在一个表格中，中英文对照更容易理解。

| <span style="display:inline-block;width:40px">自定义项目(中文)</span> | <span style="display:inline-block;width:40px">自定义项目(英文)</span> | <span style="display:inline-block;width:40px">编码</span> | <span style="display:inline-block;width:40px">取值</span> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :-------------------------------------------------------: | --------------------------------------------------------- |
|            1-.NET Framework：XAML 浏览器应用程序             |                  XAML browser applications                   |                           2400                            |                                                           |
|                  2-.NET Framework：XPS文档                   |                        XPS documents                         |                           2401                            |                                                           |
|                  3-.NET Framework：松散XAML                  |                          Loose XAML                          |                           2402                            |                                                           |
|        4-.NET Framework相关组件：带有清单的权限的组件        |          Permissions for components with manifests           |                           2007                            |                                                           |
|   5-.NET Framework相关组件：运行未用Authenticode签名的组件   |         Run components not signed with Authenticode          |                           2004                            |                                                           |
|   6-.NET Framework相关组件：运行已用Authenticode签名的组件   |           Run components signed with Authenticode            |                           2001                            |                                                           |
|           7-ActiveX控件和插件：ActiveX控件自动提示           |           Automatic prompting for ActiveX controls           |                           2201                            |                                                           |
| 8-ActiveX控件和插件：:对标记为可安全执行脚本的ActiveX控件执行脚本 |      Script ActiveX controls marked safe for scripting       |                           1405                            |                                                           |
| 9-ActiveX控件和插件：对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本 | Initialize and script ActiveX controls not marked as safe for scripting |                           1201                            |                                                           |
|          10-ActiveX控件和插件：二进制文件和脚本行为          |                 Binary and script behaviors                  |                           2000                            |                                                           |
| 11-ActiveX控件和插件：仅允许经过批准的域在未经提示的情况下使用ActiveX |   Only allow approved domain to use ActiveX without prompt   |                                                           |                                                           |
|        12-ActiveX控件和插件：下载未签名的ActiveX控件         |              Download unsigned ActiveX controls              |                           1004                            |                                                           |
|        13-ActiveX控件和插件：下载已签名的ActiveX控件         |               Download signed ActiveX controls               |                           1001                            |                                                           |
|            14-ActiveX控件和插件：允许ActiveX筛选             |                   Allow ActiveX Filtering                    |                           2702                            |                                                           |
|             15-ActiveX控件和插件：允许Scriptlet              |                       Allow Scriptlets                       |                           1209                            |                                                           |
| 16-ActiveX控件和插件：允许运行以前未使用的ActiveX控件而不提示 | Allow previously unused ActiveX controls to run without prompt |                           1208                            |                                                           |
|         17-ActiveX控件和插件：运行ActiveX控件和插件          |              Run ActiveX controls and plug-ins               |                           1200                            |                                                           |
|     18-ActiveX控件和插件：在ActiveX空间上运行反恶意软件      |         Run antimalware software on ActiveX controls         |                                                           |                                                           |
| 19-ActiveX控件和插件：在没有使用外部媒体播放机的网页上显示视频和动画 | Display video and animation on a webpage that does not use external media player |                                                           |                                                           |
|                   20-脚本：java小程序脚本                    |                  Scripting of java applets                   |                           1402                            |                                                           |
|                      21-脚本：活动脚本                       |                       Active scripting                       |                           1400                            |                                                           |
|                    22-脚本：启用XSS筛选器                    |                      Enable XSS filter                       |                           1409                            |                                                           |
|              23-脚本：允许对剪贴板进行编程访问               |             Allow Programmatic clipboard access              |                           1407                            |                                                           |
|               24-脚本：允许通过脚本更新状态栏                |             Allow status bar updates via script              |                           2103                            |                                                           |
|          25-脚本：允许网站使用脚本窗口提示获取信息           | Allow websites to prompt for information using scripted windows |                           2105                            |                                                           |
|                   26-其他：呈现旧版筛选器                    |                    Render legacy filters                     |                                                           |                                                           |
|                  27-其他：持续使用用户数据                   |                    User data persistence                     |                           1606                            |                                                           |
|      28-其他：低权限Web内容区域中的网站可以导航到此区域      | Websites in less privileged with content zone can navigate into this zone |                           2101                            |                                                           |
|              29-其他：加载应用程序和不安全文件               |           Launching applications and unsafe files            |                           1806                            |                                                           |
|          30-其他：将文件上载到服务器时包含本地目录           | Inclue local directory path when uploading files to a server |                           160A                            |                                                           |
|                 31-其他：跨域浏览窗口和框架                  |     Navigate windows and frames across different domains     |                                                           |                                                           |
|                    32-其他：启用MIME探查                     |                     Enable MIME Sniffing                     |                                                           |                                                           |
|                33-其他：使用SmartScreen筛选器                |                    Use SmartScreen Filter                    |                                                           |                                                           |
|                34-其他：使用弹出窗口阻止程序                 |                      Use Pop-up Blocker                      |                           1809                            |                                                           |
|                 35-其他：提交非加密表单数据                  |                Submit non-encrypted form data                |                           1601                            |                                                           |
|                  36-其他：通过域访问数据源                   |              Access data sources across domains              |                           1406                            |                                                           |
|               37-其他：拖放或者复制和粘贴文件                |            Drag and drop or copy and paste files             |                           1802                            |                                                           |
|                    38-其他：显示混合内容                     |                    Display mixed content                     |                           1609                            |                                                           |
|                  39-其他：允许META REFRESH                   |                      Allow META REFRESH                      |                           1608                            |                                                           |
|          40-其他：允许Microsoft Web浏览器控件的脚本          |       Allow scripting of Microsoft web bowser control        |                           1206                            |                                                           |
|       41-其他：允许脚本启动的窗口不受大小或者位置限制        | Allow script-initiated windows without size or position constraints |                           2102                            |                                                           |
|         42-其他：允许网页上的活动内容使用限制的协议          | Allow webpages to use restricted protocols for active content |                                                           |                                                           |
|        43-其他：允许网站打开没有地址或者状态栏的窗口         | Allow websites to open windows without address or status bars |                           2104                            |                                                           |
|          44-其他：允许在不同窗口中的域之间拖动内容           | Allow dragging of content between domains into separate windows |                           2709                            |                                                           |
|           45-其他：允许在同一窗口的域之间拖动内容            | Allow dragging of content between domains into the same window |                           2708                            |                                                           |
|              46-其他：在IFRAME中加载程序和文件               |          Launching programs and files in an IFRAME           |                           1804                            |                                                           |
|      47-其他：只存在一个证书时不提示进行客户端证书选择       | Don't prompt for client certificate selection when only one certificate exists |                           1A04                            |                                                           |
|                48-启用.NET Framework安装程序                 |                 Enable .NET Framework setup                  |                           2600                            |                                                           |
|                      49-下载：文件下载                       |                        File download                         |                           1803                            |                                                           |
|                      50-下载：字体下载                       |                        Font download                         |                           1604                            |                                                           |
|                    51-用户身份验证：登录                     |                            Logon                             |                           1A00                            |                                                           |

[Zones-微软公司网站关于可信站点自定义项目的说明文档](https://learn.microsoft.com/en-us/troubleshoot/developer/browsers/security-privacy/ie-security-zones-registry-entries#zones)

这些基本都可以找到对应的项目，只是`120A`、和`120B`的英文文档不知道该如何翻译，直译的话似乎找不到对应的项目，而看编码的话`120B`应该对应的上面表中的第11项：仅允许经过批准的域在未经提示的情况下使用ActiveX|Only allow approved domain to use ActiveX without prompt。至于准确的编码数值，可以使用beyond  compare这个比对工具软件，里面有专门的注册表比对功能，先在左侧面板打开HKEY_CURRENT_USER，然后修改可信站点中的`仅允许经过批准的域在未经提示的情况下使用ActiveX`选项并确定，然后在beyond compare面板的右侧打开HKEY_CURRENT_USER,会自动以粉色表示前后修改过的注册表项机数值。

~~~
Value  Setting
----------------------------------------------------------------------------------
1001   ActiveX controls and plug-ins: Download signed ActiveX controls
1004   ActiveX controls and plug-ins: Download unsigned ActiveX controls
1200   ActiveX controls and plug-ins: Run ActiveX controls and plug-ins
1201   ActiveX controls and plug-ins: Initialize and script ActiveX controls not marked as safe for scripting
1206   Miscellaneous: Allow scripting of Internet Explorer Web browser control ^
1207   Reserved #
1208   ActiveX controls and plug-ins: Allow previously unused ActiveX controls to run without prompt ^
1209   ActiveX controls and plug-ins: Allow Scriptlets
120A   ActiveX controls and plug-ins: ActiveX controls and plug-ins: Override Per-Site (domain-based) ActiveX restrictions
120B   ActiveX controls and plug-ins: Override Per-Site (domain-based) ActiveX restrict ions
1400   Scripting: Active scripting
1402   Scripting: Scripting of Java applets
1405   ActiveX controls and plug-ins: Script ActiveX controls marked as safe for scripting
1406   Miscellaneous: Access data sources across domains
1407   Scripting: Allow Programmatic clipboard access
1408   Reserved #
1409   Scripting: Enable XSS Filter
1601   Miscellaneous: Submit non-encrypted form data
1604   Downloads: Font download
1605   Run Java #
1606   Miscellaneous: Userdata persistence ^
1607   Miscellaneous: Navigate sub-frames across different domains
1608   Miscellaneous: Allow META REFRESH * ^
1609   Miscellaneous: Display mixed content *
160A   Miscellaneous: Include local directory path when uploading files to a server ^
1800   Miscellaneous: Installation of desktop items
1802   Miscellaneous: Drag and drop or copy and paste files
1803   Downloads: File Download ^
1804   Miscellaneous: Launching programs and files in an IFRAME
1805   Launching programs and files in webview #
1806   Miscellaneous: Launching applications and unsafe files
1807   Reserved ** #
1808   Reserved ** #
1809   Miscellaneous: Use Pop-up Blocker ** ^
180A   Reserved #
180B   Reserved #
180C   Reserved #
180D   Reserved #
180E   Allow OpenSearch queries in Windows Explorer #
180F   Allow previewing and custom thumbnails of OpenSearch query results in Windows Explorer #
1A00   User Authentication: Logon
1A02   Allow persistent cookies that are stored on your computer #
1A03   Allow per-session cookies (not stored) #
1A04   Miscellaneous: Don't prompt for client certificate selection when no certificates or only one certificate exists * ^
1A05   Allow 3rd party persistent cookies *
1A06   Allow 3rd party session cookies *
1A10   Privacy Settings *
1C00   Java permissions #
1E05   Miscellaneous: Software channel permissions
1F00   Reserved ** #
2000   ActiveX controls and plug-ins: Binary and script behaviors
2001   .NET Framework-reliant components: Run components signed with Authenticode
2004   .NET Framework-reliant components: Run components not signed with Authenticode
2007   .NET Framework-Reliant Components: Permissions for Components with Manifests
2100   Miscellaneous: Open files based on content, not file extension ** ^
2101   Miscellaneous: Web sites in less privileged web content zone can navigate into this zone **
2102   Miscellaneous: Allow script initiated windows without size or position constraints ** ^
2103   Scripting: Allow status bar updates via script ^
2104   Miscellaneous: Allow websites to open windows without address or status bars ^
2105   Scripting: Allow websites to prompt for information using scripted windows ^
2200   Downloads: Automatic prompting for file downloads ** ^
2201   ActiveX controls and plug-ins: Automatic prompting for ActiveX controls ** ^
2300   Miscellaneous: Allow web pages to use restricted protocols for active content **
2301   Miscellaneous: Use Phishing Filter ^
2400   .NET Framework: XAML browser applications
2401   .NET Framework: XPS documents
2402   .NET Framework: Loose XAML
2500   Turn on Protected Mode [Vista only setting] #
2600   Enable .NET Framework setup ^
2702   ActiveX controls and plug-ins: Allow ActiveX Filtering
2708   Miscellaneous: Allow dragging of content between domains into the same window
2709   Miscellaneous: Allow dragging of content between domains into separate windows
270B   Miscellaneous: Render legacy filters
270C   ActiveX Controls and plug-ins: Run Antimalware software on ActiveX controls

       {AEBA21FA-782A-4A90-978D-B72164C80120} First Party Cookie *
       {A8A88C49-5EB2-4990-A1A2-0876022C854F} Third Party Cookie *

* indicates an Internet Explorer 6 or later setting
** indicates a Windows XP Service Pack 2 or later setting
# indicates a setting that is not displayed in the user interface in Internet Explorer
^ indicates a setting that only has two options, enabled or disabled
~~~

