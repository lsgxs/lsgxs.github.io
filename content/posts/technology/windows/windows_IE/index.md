---
title: "批处理设置IE安全区域注册表项"
date: 2023-07-28T21:55:53+08:00
draft: false
# weight: 2
tags: ["first"]
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: true
hidemeta: false
comments: false
canonicalURL: "https://canonical.url/to/page"
disableHLJS: true # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
UseHugoToc: false
ShowCodeCopyButtons: true
thumbnail: "images/ActiveX.jpg"
description: "单位现在的业务系统大部分基于Windows IE浏览器的应用，设置好IE浏览器的各项参数，客户端通过浏览器链接到服务端打开应用。但是浏览器经常出现各种小问题，需要重新配置。由于IE的安全标签可信站点自定义选项很多，手动设置有时候会出错，而且效率低，因此就考虑用批处理自动化设置。"    
---

#### 批处理设置IE安全区域注册表项

#### Windows IE安全区域注册表项及取值

单位现在的业务系统大部分基于Windows IE浏览器的应用，设置好IE浏览器的各项参数，客户端通过浏览器链接到服务端打开应用。但是浏览器经常出现各种小问题，需要重新配置。由于IE的安全标签可信站点自定义选项很多，手动设置有时候会出错，而且效率低，因此就考虑用批处理自动化设置。这些参数保存在注册表的HKCU主键下：`HKEY_CURRENT_USER\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS\ZONES\2`。用了一下午时间，把这些项目整理在一个表格中。

| <span style="display:inline-block;width=60px">自定义项目(中文)</span> | <span style="display:inline-block;width=30px">编码</span> | <span style="display:inline-block;width=30px">取值</span> |
| :----------------------------------------------------------: | :-------------------------------------------------------: | :-------------------------------------------------------: |
|            1-.NET Framework：XAML 浏览器应用程序             |                           2400                            |                  0-启用；1-提示；3-禁用                   |
|                  2-.NET Framework：XPS文档                   |                           2401                            |                  0-启用；1-提示；3-禁用                   |
|                  3-.NET Framework：松散XAML                  |                           2402                            |                  0-启用；1-提示；3-禁用                   |
|        4-.NET Framework相关组件：带有清单的权限的组件        |                           2007                            |                  3-禁用；10000-高级安全                   |
|   5-.NET Framework相关组件：运行未用Authenticode签名的组件   |                           2004                            |                  0-启用；1-提示；3-禁用                   |
|   6-.NET Framework相关组件：运行已用Authenticode签名的组件   |                           2001                            |                  0-启用；1-提示；3-禁用                   |
|           7-ActiveX控件和插件：ActiveX控件自动提示           |                           2201                            |                  0-启用；1-提示；3-禁用                   |
| 8-ActiveX控件和插件：:对标记为可安全执行脚本的ActiveX控件执行脚本 |                           1405                            |                  0-启用；1-提示；3-禁用                   |
| 9-ActiveX控件和插件：对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本 |                           1201                            |                  0-启用；1-提示；3-禁用                   |
|           10-ActiveX控件和插件：二进制文件和脚本行           |                           2000                            |                   0-启用；3-禁用；1000                    |
| 11-ActiveX控件和插件：仅允许经过批准的域在未经提示的情况下使用ActiveX |                           120B                            |                **0-禁用；1-提示；3-启用**                 |
|        12-ActiveX控件和插件：下载未签名的ActiveX控件         |                           1004                            |                  0-启用；1-提示；3-禁用                   |
|        13-ActiveX控件和插件：下载已签名的ActiveX控件         |                           1001                            |                  0-启用；1-提示；3-禁用                   |
|            14-ActiveX控件和插件：允许ActiveX筛选             |                           2702                            |                  0-启用；1-提示；3-禁用                   |
|             15-ActiveX控件和插件：允许Scriptlet              |                           1209                            |                  0-启用；1-提示；3-禁用                   |
| 16-ActiveX控件和插件：允许运行以前未使用的ActiveX控件而不提示 |                           1208                            |                  0-启用；1-提示；3-禁用                   |
|         17-ActiveX控件和插件：运行ActiveX控件和插件          |                           1200                            |                  0-启用；1-提示；3-禁用                   |
|     18-ActiveX控件和插件：在ActiveX空间上运行反恶意软件      |                           270C                            |                  0-启用；1-提示；3-禁用                   |
| 19-ActiveX控件和插件：在没有使用外部媒体播放机的网页上显示视频和动画 |                           120A                            |                  0-启用；1-提示；3-禁用                   |
|                   20-脚本：java小程序脚本                    |                           1402                            |                  0-启用；1-提示；3-禁用                   |
|                      21-脚本：活动脚本                       |                           1400                            |                  0-启用；1-提示；3-禁用                   |
|                    22-脚本：启用XSS筛选器                    |                           1409                            |                  0-启用；1-提示；3-禁用                   |
|              23-脚本：允许对剪贴板进行编程访问               |                           1407                            |                  0-启用；1-提示；3-禁用                   |
|               24-脚本：允许通过脚本更新状态栏                |                           2103                            |                  0-启用；1-提示；3-禁用                   |
|          25-脚本：允许网站使用脚本窗口提示获取信息           |                           2105                            |                  0-启用；1-提示；3-禁用                   |
|                   26-其他：呈现旧版筛选器                    |                           270B                            |                  0-启用；1-提示；3-禁用                   |
|                  27-其他：持续使用用户数据                   |                           1606                            |                  0-启用；1-提示；3-禁用                   |
|      28-其他：低权限Web内容区域中的网站可以导航到此区域      |                           2101                            |                  0-启用；1-提示；3-禁用                   |
|              29-其他：加载应用程序和不安全文件               |                           1806                            |                  0-启用；1-提示；3-禁用                   |
|          30-其他：将文件上载到服务器时包含本地目录           |                           160A                            |                  0-启用；1-提示；3-禁用                   |
|                 31-其他：跨域浏览窗口和框架                  |                           1607                            |                  0-启用；1-提示；3-禁用                   |
|                    32-其他：启用MIME探查                     |                           2100                            |                  0-启用；1-提示；3-禁用                   |
|                33-其他：使用SmartScreen筛选器                |                           2301                            |                  0-启用；1-提示；3-禁用                   |
|                34-其他：使用弹出窗口阻止程序                 |                           1809                            |                **0-启用；1-提示；3-禁用**                 |
|                 35-其他：提交非加密表单数据                  |                           1601                            |                  0-启用；1-提示；3-禁用                   |
|                  36-其他：通过域访问数据源                   |                           1406                            |                  0-启用；1-提示；3-禁用                   |
|               37-其他：拖放或者复制和粘贴文件                |                           1802                            |                  0-启用；1-提示；3-禁用                   |
|                    38-其他：显示混合内容                     |                           1609                            |                  0-启用；1-提示；3-禁用                   |
|                  39-其他：允许META REFRESH                   |                           1608                            |                  0-启用；1-提示；3-禁用                   |
|          40-其他：允许Microsoft Web浏览器控件的脚本          |                           1206                            |                  0-启用；1-提示；3-禁用                   |
|       41-其他：允许脚本启动的窗口不受大小或者位置限制        |                           2102                            |                  0-启用；1-提示；3-禁用                   |
|         42-其他：允许网页上的活动内容使用限制的协议          |                           2300                            |                  0-启用；1-提示；3-禁用                   |
|        43-其他：允许网站打开没有地址或者状态栏的窗口         |                           2104                            |                  0-启用；1-提示；3-禁用                   |
|          44-其他：允许在不同窗口中的域之间拖动内容           |                           2709                            |                  0-启用；1-提示；3-禁用                   |
|           45-其他：允许在同一窗口的域之间拖动内容            |                           2708                            |                  0-启用；1-提示；3-禁用                   |
|              46-其他：在IFRAME中加载程序和文件               |                           1804                            |                  0-启用；1-提示；3-禁用                   |
|      47-其他：只存在一个证书时不提示进行客户端证书选择       |                           1A04                            |                  0-启用；1-提示；3-禁用                   |
|                48-启用.NET Framework安装程序                 |                           2600                            |                  0-启用；1-提示；3-禁用                   |
|                      49-下载：文件下载                       |                           1803                            |                  0-启用；1-提示；3-禁用                   |
|                      50-下载：字体下载                       |                           1604                            |                  0-启用；1-提示；3-禁用                   |
|                    51-用户身份验证：登录                     |                           1A00                            |                    参照IE具体选项取值                     |



本来是在一张表格里显示`自定义项目(中文)`、`自定义项目(英文)`、`编码`、`取值`这四列数据，可是typora的markdown表格里无法全部显示，最后一列的取值不能全部显示，取值如果有错误的话在实际工作中注意核对一下。列标题加上了`<span>style="display:inline-block;width:70px"</span>`指定列宽也无法全部显示四列数据，只好分成两个表试试。

|自定义项目(中文) | 自定义项目(英文) |  编码 |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :-------------------------------------------------------: |
|            1-.NET Framework：XAML 浏览器应用程序             |                  XAML browser applications                   |                           2400                            |
|                  2-.NET Framework：XPS文档                   |                        XPS documents                         |                           2401                            |
|                  3-.NET Framework：松散XAML                  |                          Loose XAML                          |                           2402                            |
|        4-.NET Framework相关组件：带有清单的权限的组件        |          Permissions for components with manifests           |                           2007                            |
|   5-.NET Framework相关组件：运行未用Authenticode签名的组件   |         Run components not signed with Authenticode          |                           2004                            |
|   6-.NET Framework相关组件：运行已用Authenticode签名的组件   |           Run components signed with Authenticode            |                           2001                            |
|           7-ActiveX控件和插件：ActiveX控件自动提示           |           Automatic prompting for ActiveX controls           |                           2201                            |
| 8-ActiveX控件和插件：:对标记为可安全执行脚本的ActiveX控件执行脚本 |      Script ActiveX controls marked safe for scripting       |                           1405                            |
| 9-ActiveX控件和插件：对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本 | Initialize and script ActiveX controls not marked as safe for scripting |                           1201                            |
|          10-ActiveX控件和插件：二进制文件和脚本行为          |                 Binary and script behaviors                  |                           2000                            |
| 11-ActiveX控件和插件：仅允许经过批准的域在未经提示的情况下使用ActiveX | **Only allow approved domain to use ActiveX without prompt** |                           120B                            |
|        12-ActiveX控件和插件：下载未签名的ActiveX控件         |              Download unsigned ActiveX controls              |                           1004                            |
|        13-ActiveX控件和插件：下载已签名的ActiveX控件         |               Download signed ActiveX controls               |                           1001                            |
|            14-ActiveX控件和插件：允许ActiveX筛选             |                   Allow ActiveX Filtering                    |                           2702                            |
|             15-ActiveX控件和插件：允许Scriptlet              |                       Allow Scriptlets                       |                           1209                            |
| 16-ActiveX控件和插件：允许运行以前未使用的ActiveX控件而不提示 | Allow previously unused ActiveX controls to run without prompt |                           1208                            |
|         17-ActiveX控件和插件：运行ActiveX控件和插件          |              Run ActiveX controls and plug-ins               |                           1200                            |
|     18-ActiveX控件和插件：在ActiveX空间上运行反恶意软件      |         Run antimalware software on ActiveX controls         |                           270C                            |
| 19-ActiveX控件和插件：在没有使用外部媒体播放机的网页上显示视频和动画 | **Display video and animation on a webpage that does not use external media player** |                           120A                            |
|                   20-脚本：java小程序脚本                    |                  Scripting of java applets                   |                           1402                            |
|                      21-脚本：活动脚本                       |                       Active scripting                       |                           1400                            |
|                    22-脚本：启用XSS筛选器                    |                      Enable XSS filter                       |                           1409                            |
|              23-脚本：允许对剪贴板进行编程访问               |             Allow Programmatic clipboard access              |                           1407                            |
|               24-脚本：允许通过脚本更新状态栏                |             Allow status bar updates via script              |                           2103                            |
|          25-脚本：允许网站使用脚本窗口提示获取信息           | Allow websites to prompt for information using scripted windows |                           2105                            |
|                   26-其他：呈现旧版筛选器                    |                    Render legacy filters                     |                           270B                            |
|                  27-其他：持续使用用户数据                   |                     Userdata persistence                     |                           1606                            |
|      28-其他：低权限Web内容区域中的网站可以导航到此区域      | Websites in less privileged with content zone can navigate into this zone |                           2101                            |
|              29-其他：加载应用程序和不安全文件               |           Launching applications and unsafe files            |                           1806                            |
|          30-其他：将文件上载到服务器时包含本地目录           | Inclue local directory path when uploading files to a server |                           160A                            |
|                 31-其他：跨域浏览窗口和框架                  |     Navigate windows and frames across different domains     |                           1607                            |
|                    32-其他：启用MIME探查                     |                   **Enable MIME Sniffing**                   |                           2100                            |
|                33-其他：使用SmartScreen筛选器                |                    Use SmartScreen Filter                    |                           2301                            |
|                34-其他：使用弹出窗口阻止程序                 |                      Use Pop-up Blocker                      |                           1809                            |
|                 35-其他：提交非加密表单数据                  |                Submit non-encrypted form data                |                           1601                            |
|                  36-其他：通过域访问数据源                   |              Access data sources across domains              |                           1406                            |
|               37-其他：拖放或者复制和粘贴文件                |            Drag and drop or copy and paste files             |                           1802                            |
|                    38-其他：显示混合内容                     |                    Display mixed content                     |                           1609                            |
|                  39-其他：允许META REFRESH                   |                      Allow META REFRESH                      |                           1608                            |
|          40-其他：允许Microsoft Web浏览器控件的脚本          |       Allow scripting of Microsoft web bowser control        |                           1206                            |
|       41-其他：允许脚本启动的窗口不受大小或者位置限制        | Allow script-initiated windows without size or position constraints |                           2102                            |
|         42-其他：允许网页上的活动内容使用限制的协议          | Allow webpages to use restricted protocols for active content |                           2300                            |
|        43-其他：允许网站打开没有地址或者状态栏的窗口         | Allow websites to open windows without address or status bars |                           2104                            |
|          44-其他：允许在不同窗口中的域之间拖动内容           | Allow dragging of content between domains into separate windows |                           2709                            |
|           45-其他：允许在同一窗口的域之间拖动内容            | Allow dragging of content between domains into the same window |                           2708                            |
|              46-其他：在IFRAME中加载程序和文件               |          Launching programs and files in an IFRAME           |                           1804                            |
|      47-其他：只存在一个证书时不提示进行客户端证书选择       | Don't prompt for client certificate selection when only one certificate exists |                           1A04                            |
|                48-启用.NET Framework安装程序                 |                 Enable .NET Framework setup                  |                           2600                            |
|                      49-下载：文件下载                       |                        File download                         |                           1803                            |
|                      50-下载：字体下载                       |                        Font download                         |                           1604                            |
|                    51-用户身份验证：登录                     |                            Logon                             |                           1A00                            |



[Zones-微软公司网站关于可信站点自定义项目的说明文档](https://learn.microsoft.com/en-us/troubleshoot/developer/browsers/security-privacy/ie-security-zones-registry-entries#zones)

这些基本都可以找到对应的项目，只是`120A`、和`120B`的英文文档不知道该如何翻译，直译的话似乎找不到对应的项目，而看编码的话`120B`应该对应的上面表中的第11项：仅允许经过批准的域在未经提示的情况下使用ActiveX|Only allow approved domain to use ActiveX without prompt。至于准确的编码数值，可以使用beyond  compare这个比对工具软件，里面有专门的注册表比对功能，先在左侧面板打开HKEY_CURRENT_USER，然后修改可信站点中的`仅允许经过批准的域在未经提示的情况下使用ActiveX`选项并确定，然后在beyond compare面板的右侧打开HKEY_CURRENT_USER,会自动以粉色表示前后修改过的注册表项机数值。也许是不同的浏览器版本中项目名称不同吧，知道`仅允许经过批准的域在未经提示的情况下使用ActiveX`对应的数值就好，先放下这个问题。通常，设置为 0 将设置允许的特定操作，设置为 1 会导致出现提示，设置为 3 将禁止特定操作。只有个别项目是反过来的。微软公司提供的这个表格是按照Zones\2下的值排序，而IE11界面里可信站点自定义项目并不是同步的顺序。上面自己整理的表格中第11、19、32、33项的英文项目名称并没有在下面的列表中对应，但是可以通过编号对应起来。

​                               Windows中文版IE11安全选项可信站点自定义项目描述与微软公司文档不一致的对照表（编号一致）

| 11-仅允许经过批准的域未经提示使用ActiveX   Override Per-Site (domain-based) ActiveX restrictions          120B |      |      |
| ------------------------------------------------------------ | ---- | ---- |
| 19-在没有使用外部媒体播放机的网页上显示视频和动画 Override Per-Site (domain-based) ActiveX restrictions   120A |      |      |
| 32-其他：启用MIME探查(IE9以上)                 Open files based on content, not file extension（IE6、IE8）        2100 |      |      |
| 33-其他：使用SmartScreen筛选器   Miscellaneous: Use Phishing Filter                                                               2301 |      |      |
| 应该是不同版本的浏览器中的项目名称不同。                     |      |      |

参照[高级用户的internet  explorer安全区域注册表项](https://learn.microsoft.com/zh-cn/troubleshoot/developer/browsers/security-privacy/ie-security-zones-registry-entries#zones)



~~~bash
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

下面这段文本框内容来自网络的一篇文章，[[win10 ie ActiveX 对应注册表编号](https://www.cnblogs.com/josn1984/p/10696061.html)]

~~~bash
ActiveX控件自动提示:(3＝禁用、0＝启用)"2201"=dword:00000000 ;
对标记为可安全执行脚本的ActiveX控件执行脚本:(3＝禁用、0＝启用、1＝提示)"1405"=dword:00000000 ;
对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本:(3＝禁用、0＝启用、1＝提示)"1201"=dword:00000000 ;
二进制和脚本行为:(3＝禁用、0＝启用、10000＝管理员认可)"2000"=dword:00000000 ;
仅允许经过批准的域在未经提示的情况下使用ActiveX:(0＝禁用、3＝启用); XP+IE6不存在此项"120B"=dword:00000003 ;
下载未签名的ActiveX控件:(3＝禁用、0＝启用、1＝提示)"1004"=dword:00000000 ;
下载已签名的ActiveX控件:(3＝禁用、0＝启用、1＝提示)"1001"=dword:00000000 ;
允许ActiveX筛选:(3＝禁用、0＝启用); XP+IE6不存在此项,Win7+IE8不存在此项"2702"=dword:00000000 ;
允许Scriptlet:(3＝禁用、0＝启用、1＝提示); XP+IE6不存在此项"1209"=dword:00000000 ;
允许运行以前未使用的ActiveX控件而不提示:(3＝禁用、0＝启用); XP+IE6不存在此项"1208"=dword:00000000 ;
运行ActiveX控件和插件:(3＝禁用、0＝启用、1＝提示、10000=管理员认可)"1200"=dword:00000000 ;
在没有使用外部媒体播放机的网页上显示视频和动画:(3＝禁用、0＝启用); XP+IE6不存在此项"120A"=dword:00000000;

XAML 浏览器应用程序:(3＝禁用、0＝启用、1＝提示)"2400"=dword:00000000 ;
XPS 文档:(3＝禁用、0＝启用、1＝提示)"2401"=dword:00000000;
松散 XAML:(3＝禁用、0＝启用、1＝提示)"2402"=dword:00000000;
带有清单的权限的组件:(3＝禁用、10000＝高安全级)"2007"=dword:00010000 ;
运行未用 Authenticode 签名的组件:(3＝禁用、0＝启用、1＝提示)"2004"=dword:00000000 ;
运行已用 Authenticode 签名的组件:(3＝禁用、0＝启用、1＝提示)"2001"=dword:00000000;

ActiveX 控件和插件
ActiveX控件自动提示:(3＝禁用、0＝启用)"2201"=dword:00000000 ;
对标记为可安全执行脚本的ActiveX控件执行脚本:(3＝禁用、0＝启用、1＝提示)"1405"=dword:00000000 ;
对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本:(3＝禁用、0＝启用、1＝提示)"1201"=dword:00000000 ;
二进制和脚本行为:(3＝禁用、0＝启用、10000＝管理员认可)"2000"=dword:00000000 ;
仅允许经过批准的域在未经提示的情况下使用ActiveX:(0＝禁用、3＝启用); XP+IE6不存在此项"120B"=dword:00000003 ;
下载未签名的ActiveX控件:(3＝禁用、0＝启用、1＝提示)"1004"=dword:00000000 ;
下载已签名的ActiveX控件:(3＝禁用、0＝启用、1＝提示)"1001"=dword:00000000 ;
允许ActiveX筛选:(3＝禁用、0＝启用); XP+IE6不存在此项,Win7+IE8不存在此项"2702"=dword:00000000 ;
允许Scriptlet:(3＝禁用、0＝启用、1＝提示); XP+IE6不存在此项"1209"=dword:00000000 ;
允许运行以前未使用的ActiveX控件而不提示:(3＝禁用、0＝启用); XP+IE6不存在此项"1208"=dword:00000000 ;
运行ActiveX控件和插件:(3＝禁用、0＝启用、1＝提示、10000=管理员认可)"1200"=dword:00000000 ;
在没有使用外部媒体播放机的网页上显示视频和动画:(3＝禁用、0＝启用); XP+IE6不存在此项"120A"=dword:00000000;

Java 权限:(00,00,03,00＝安全级 – 低、00,00,01,00＝安全级 – 高、00,00,02,00＝安全级 – 中、00,00,00,00＝禁用、00,00,80,00＝自定义:自定义时会修改一个CLSID); Win7+IE8不存在此项, Win7+IE9不存在此项,XP+IE6存在此项"1C00"=hex:00,00,03,00;
Java 小程序脚本:(3＝禁用、0＝启用、1＝提示)"1402"=dword:00010000 ;
活动脚本:(3＝禁用、0＝启用、1＝提示)"1400"=dword:00000000 ;
启用 XSS 筛选器:(3＝禁用、0＝启用); XP+IE6不存在此项"1409"=dword:00000003 ;
允许对剪贴板进行编程访问:(3＝禁用、0＝启用、1＝提示); IE6:允许通过脚本进行粘贴操作"1407"=dword:00000000 ;
允许网站使用脚本窗口提示获得信息:(3＝禁用、0＝启用); XP+IE6不存在此项"2105"=dword:00000000 ;
允许状态栏通过脚本更新:(3＝禁用、0＝启用); XP+IE6不存在此项"2103"=dword:00000000; 其他
持续使用用户数据:(3＝禁用、0＝启用)"1606"=dword:00000000 ;
加载应用程序和不安全文件:(3＝禁用、0＝启用、1＝提示); XP+IE6不存在此项"1806"=dword:00000001 ;
将文件上载到服务器时包含本地目录路径:(3＝禁用、0＝启用); XP+IE6不存在此项"160A"=dword:00000000 ;
跨域浏览窗口和框架:(3＝禁用、0＝启用、1＝提示); IE6:跨域浏览子框架"1607"=dword:00000000 ;
启用 MIME 探查:(3＝禁用、0＝启用); IE6 IE8:基于内容打开文件，而不是基于文件扩展名; IE9:启用 MIME 探查"2100"=dword:00000000 ;
使用 SmartScreen 筛选器:(3＝禁用、0＝启用); XP+IE6不存在此项"2301"=dword:00000003 ;
使用弹出窗口阻止程序:(3＝禁用、0＝启用)"1809"=dword:00000003 ;
特权较少的 Web 内容区域中的网站可以定位到该区域:(3＝禁用、0＝启用、1＝提示); IE6: 在低特权 Web 内容区域中的网站可以导航到此区域"2101"=dword:00000001 ;
提交非加密表单数据:(3＝禁用、0＝启用、1＝提示)"1601"=dword:00000000 ;
通过域访问数据源:(3＝禁用、0＝启用、1＝提示)"1406"=dword:00000000 ;
拖放或复制和粘贴文件:(3＝禁用、0＝启用、1＝提示)"1802"=dword:00000000 ;
显示混合内容:(3＝禁用、0＝启用、1＝提示)"1609"=dword:00000000 ;
允许 META REFRESH:(3＝禁用、0＝启用)"1608"=dword:00000000 ;
允许 Microsoft 网页浏览器控件的脚本:(3＝禁用、0＝启用); IE6:允许 Internet Exlorer Webbrowser 控件的脚本"1206"=dword:00000000 ;
允许脚本初始化的窗口，不受大小或位置限制:(3＝禁用、0＝启用); XP+IE6不存在此项"2102"=dword:00000000 ;
允许网页使用活动内容受限协议:(3＝禁用、0＝启用、1＝提示); IE6:允许网页为活动内容使用受限制的协议"2300"=dword:00000001 ;
允许网站打开没有地址或状态栏的窗口:(3＝禁用、0＝启用); XP+IE6不存在此项"2104"=dword:00000000 ;
在 IFRAME 中加载程序和文件:(3＝禁用、0＝启用、1＝提示)"1804"=dword:00000000 ;
只存在一个证书时不提示进行客户端证书选择:(3＝禁用、0＝启用); IE6 IE8:没有证书或只有一个证书时不提示进行客户证书选择; IE9:只存在一个证书时不提示进行客户端证书选择"1A04"=dword:00000000 ;
软件频道权限:(30000＝安全度 - 低、10000＝安全度 - 高、20000＝安全度－中); XP+IE6存在此项,Win7+IE8不存在此项,Win7+IE9不存在此项"1E05"=dword:00030000 ;
桌面组件的安装:(3＝禁用、0＝启用、1＝提示); XP+IE6存在此项,Win7+IE8存在此项,Win7+IE9不存在此项"1800"=dword:00000000;
启用 .NET Framework 安装程序
启用 .NET Framework 安装程序:(3＝禁用、0＝启用)"2600"=dword:00000000; 下载
文件下载:(3＝禁用、0＝启用)"1803"=dword:00000000 ;
文件下载自动提示:(3＝禁用、0＝启用); XP+IE6存在此项,Win7+IE8存在此项,Win7+IE9不存在此项"2200"=dword:00000000 ;
字体下载:(3＝禁用、0＝启用、1＝提示)"1604"=dword:00000000; 用户验证
登录:(30000＝匿名登录、10000＝用户名和密码提示、20000=只在 Intranet 区域自动登录、0=自动使用当前用户名和密码登录)"1A00"=dword:00000000; 安全级别
安全级别:(12000=高、11500=中-高、11000＝中、10500＝中低、10000＝低、0=自定义)"CurrentLevel"=dword:00000000; 对于不清楚的注册表键值 可以使用注册表快照工具RegShot 通过两次扫描找出对应的键值。
~~~



把上面的表格整理成文本文件复制在这里（0-启用0x00000000;1-提示0x00000001;3-禁用0x00000003）

~~~
         自定义项目(中文)                          自定义项目(英文)	          编码        取值
1-.NET Framework：XAML 浏览器应用程序         XAML browser applications	      2400	 0-启用；1-提示；3-禁用
2-.NET Framework：XPS文档	                         XPS documents	         2401	0-启用；1-提示；3-禁用
3-.NET Framework：松散XAML                  	      Loose XAML	         2402	0-启用；1-提示；3-禁用
4-.NET Framework相关组件：带有清单的权限的组件	Permissions for components with manifests 2007	3-禁用；10000-高级安全
5-.NET Framework相关组件：运行未用Authenticode签名的组件    Run components not signed with Authenticode	2004	0-启用；1-提示；3-禁用
6-.NET Framework相关组件：运行已用Authenticode签名的组件 Run components signed with Authenticode	2001	0-启用；1-提示；3-禁用
7-ActiveX控件和插件：ActiveX控件自动提示	        Automatic prompting for ActiveX controls	2201	0-启用；1-提示；3-禁用
8-ActiveX控件和插件：:对标记为可安全执行脚本的ActiveX控件执行脚本	                Script ActiveX controls marked safe for scripting	1405	0-启用；1-提示；3-禁用
9-ActiveX控件和插件：对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本   Initialize and script ActiveX controls not marked as safe for scripting  1201	0-启用；1-提示；3-禁用
10-ActiveX控件和插件：二进制文件和脚本行为	                  Binary and script behaviors	2000	0-启用；1-提示；3-禁用
11-ActiveX控件和插件：仅允许经过批准的域在未经提示的情况下使用ActiveX                Only allow approved domain to use ActiveX without prompt	120B	0-禁用；1-提示；3-启用
12-ActiveX控件和插件：下载未签名的ActiveX控件                  Download unsigned ActiveX controls	1004	0-启用；1-提示；3-禁用
13-ActiveX控件和插件：下载已签名的ActiveX控件	Download signed ActiveX controls	1001 0-启用；1-提示；3-禁用
14-ActiveX控件和插件：允许ActiveX筛选	        Allow ActiveX Filtering	2702	0-启用；1-提示；3-禁用
15-ActiveX控件和插件：允许Scriptlet            Allow Scriptlets	1209	    0-启用；1-提示；3-禁用
16-ActiveX控件和插件：允许运行以前未使用的ActiveX控件而不提示                  Allow previously unused ActiveX controls to run without prompt   1208	0-启用；1-提示；3-禁用
17-ActiveX控件和插件：运行ActiveX控件和插件	                Run ActiveX controls and plug-ins	1200	0-启用；1-提示；3-禁用
18-ActiveX控件和插件：在ActiveX空间上运行反恶意软件                    Run antimalware software on ActiveX controls	270C	0-启用；1-提示；3-禁用
19-ActiveX控件和插件：在没有使用外部媒体播放机的网页上显示视频和动画	  Display video and animation on a webpage that does not use external media player   120A 0-启用；1-提示；3-禁用
20-脚本：java小程序脚本	                                      Scripting of java applets	1402	0-启用；1-提示；3-禁用
21-脚本：活动脚本	                                                             Active scripting	1400	0-启用；1-提示；3-禁用
22-脚本：启用XSS筛选器	                                                                      Enable XSS filter	1409	0-启用；1-提示；3-禁用
23-脚本：允许对剪贴板进行编程访问	                Allow Programmatic clipboard access	1407	0-启用；1-提示；3-禁用
24-脚本：允许通过脚本更新状态栏                           	Allow status bar updates via script	2103	0-启用；1-提示；3-禁用
25-脚本：允许网站使用脚本窗口提示获取信息                                	Allow websites to prompt for information using scripted windows	2105	0-启用；1-提示；3-禁用
26-其他：呈现旧版筛选器	                                                                     Render legacy filters	270B	0-启用；1-提示；3-禁用
27-其他：持续使用用户数据	                                                                     Userdata persistence	1606	0-启用；1-提示；3-禁用
28-其他：低权限Web内容区域中的网站可以导航到此区域              	Websites in less privileged with content zone can navigate into this zone    2101	0-启用；1-提示；3-禁用
29-其他：加载应用程序和不安全文件	                                                    Launching applications and unsafe files	1806	0-启用；1-提示；3-禁用
30-其他：将文件上载到服务器时包含本地目录                                Inclue local directory path when uploading files to a server	160A	0-启用；1-提示；3-禁用
31-其他：跨域浏览窗口和框架	          Navigate windows and frames across different domains	1607	0-启用；1-提示；3-禁用
32-其他：启用MIME探查	                                                             Enable MIME Sniffing	2100	0-启用；1-提示；3-禁用
33-其他：使用SmartScreen筛选器                                                    	Use SmartScreen Filter	2301	0-启用；1-提示；3-禁用
34-其他：使用弹出窗口阻止程序                    Use Pop-up Blocker	1809	0-启用；1-提示；3-禁用
35-其他：提交非加密表单数据              	Submit non-encrypted form data	1601	0-启用；1-提示；3-禁用
36-其他：通过域访问数据源	             Access data sources across domains	1406	0-启用；1-提示；3-禁用
37-其他：拖放或者复制和粘贴文件	     Drag and drop or copy and paste files	1802	0-启用；1-提示；3-禁用
38-其他：显示混合内容	              Display mixed content	1609	0-启用；1-提示；3-禁用
39-其他：允许META REFRESH	        Allow META REFRESH	1608	0-启用；1-提示；3-禁用
40-其他：允许Microsoft Web浏览器控件的脚本	  Allow scripting of Microsoft web bowser control	1206	0-启用；1-提示；3-禁用
41-其他：允许脚本启动的窗口不受大小或者位置限制     Allow script-initiated windows without size or position constraints	2102	0-启用；1-提示；3-禁用
42-其他：允许网页上的活动内容使用限制的协议	      Allow webpages to use restricted protocols for active content	2300	0-启用；1-提示；3-禁用
43-其他：允许网站打开没有地址或者状态栏的窗口   Allow websites to open windows without address or status bars	2104	0-启用；1-提示；3-禁用
44-其他：允许在不同窗口中的域之间拖动内容	   Allow dragging of content between domains into separate windows	2709	0-启用；1-提示；3-禁用
45-其他：允许在同一窗口的域之间拖动内容	 Allow dragging of content between domains into the same window	2708	0-启用；1-提示；3-禁用
46-其他：在IFRAME中加载程序和文件    Launching programs and files in an IFRAME	1804	0-启用；1-提示；3-禁用
47-其他：只存在一个证书时不提示进行客户端证书选择	Don't prompt for client certificate selection when only one certificate exists   1A04	0-启用；1-提示；3-禁用
48-启用.NET Framework安装程序	  Enable .NET Framework setup	2600	0-启用；1-提示；3-禁用
49-下载：文件下载	                 File download	1803	0-启用；1-提示；3-禁用
50-下载：字体下载                   Font download	1604	0-启用；1-提示；3-禁用
51-用户身份验证：登录	           Logon	1A00	（30000＝匿名登录、10000＝用户名和密码提示、20000=只在 Intranet 区域自动登录、0=自动使用当前用户名和密码登录）

~~~

#### 使用批处理设置IE安全区域注册表项

根据目前基于IE11的业务需求，只有第11、34两项设置为禁用，其他设置为启用，第四项的".NET Framework-reliant  components---Permissions for components with manifests	"只有禁用（3）和高级安全（0x00010000）两个选项，设置为0x00010000（高级安全）。

* 4..NET Framework-reliant  components---Permissions for components with manifests("2007")

* 11.ActiveX controls and plug-ins---Only allow approved domain to use ActiveX without prompt("120B")

* 34.Miscellaneous---Use Pop-up Blocker("1809")

  ~~~\
   @echo off
   
   @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 10.120.*.* /f
   @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "http" /t REG_DWORD /d 2 /f
   
   @echo  "1..NET Framework---XAML browser applications"
   @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2400" /t REG_DWORD /d 0 /f
   。。。
   。。。
   
   @echo  "add registry options for security domain of IE  successfully"
   
   pause
   
   rem 仿照上面的语法把需要的项目补全，也可以把全部的51项都写出来，保存为bat文件，以管理员权限运行批处理。
  ~~~
  
   > @echo off
   >
   > @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 10.120.*.* /f
   > @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "http" /t REG_DWORD /d 2 /f
   >
   > @echo  "1..NET Framework---XAML browser applications"
   > @ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2400" /t REG_DWORD /d 0 /f
   > 。。。
   > 。。。
   >
   > @echo  "add registry options for security domain of IE  successfully"
   >
   > pause
   >
   > rem 仿照上面的语法把需要的项目补全，也可以把全部的51项都写出来，保存为bat文件，以管理员权限运行批处理。
   >
   > 文件下载：[本单位IE设置批处理](files/SetIeSecurityOpts20232.bat)
   >
   > NotePad3: [NotePad3](files/)
   >
   > 下载该批处理文件并用记事本编辑打开，如果出现批处理文件命令行不能正常换行显示，就全选所有文本并复制，然后打开NotePad3，把文本内容粘贴在NotePad3里，然后再另存为CustomeFileName.bat就可以正常显示了。
