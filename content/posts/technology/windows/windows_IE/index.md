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

  <table width="972" border="0" cellpadding="0" cellspacing="0" style='width:729.00pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="43" style='width:54.00pt;'/>
   <col width="43" style='mso-width-source:userset;mso-width-alt:1376;'/>
   <col width="135" class="xl65" style='mso-width-source:userset;mso-width-alt:4320;'/>
   <col width="192" class="xl65" style='mso-width-source:userset;mso-width-alt:9344;'/>
   <col width="186" class="xl65" style='mso-width-source:userset;mso-width-alt:9152;'/>
   <col width="72" span="2" style='width:54.00pt;'/>
   <tr height="18" style='height:13.50pt;'>
    <td height="18" width="72" style='height:13.50pt;width:54.00pt;'></td>
    <td width="43" style='width:32.25pt;'></td>
    <td class="xl65" width="135" style='width:101.25pt;'></td>
    <td class="xl65" width="292" style='width:219.00pt;'></td>
    <td class="xl65" width="286" style='width:214.50pt;'></td>
    <td width="72" style='width:54.00pt;'></td>
    <td width="72" style='width:54.00pt;'></td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td height="18" colspan="2" style='height:13.50pt;mso-ignore:colspan;'></td>
    <td class="xl65" colspan="3" style='mso-ignore:colspan;'></td>
    <td colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td height="19" style='height:14.25pt;'></td>
    <td class="xl66"></td>
    <td class="xl67" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="22" style='height:16.50pt;'>
    <td height="22" style='height:16.50pt;'></td>
    <td class="xl68" x:str><font class="font1">序号</font></td>
    <td class="xl69" x:str><font class="font1">分类</font></td>
    <td class="xl69" x:str><font class="font1">自定义项目(中文)</font></td>
    <td class="xl70" x:str><font class="font1">自定义项目(英文)</font></td>
    <td class="xl68" x:str><font class="font1">编码</font></td>
    <td class="xl68" x:str><font class="font1">值</font></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>1</td>
    <td class="xl72" x:str><font class="font2">.NET Framework</font></td>
    <td class="xl72" x:str><font class="font2">XAML 浏览器应用程序</font></td>
    <td class="xl73" x:str><font class="font2">XAML browser applications</font></td>
    <td class="xl71" x:num>2400</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>2</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">XPS文档</font></td>
    <td class="xl77" x:str><font class="font2">XPS documents</font></td>
    <td class="xl75" x:num>2401</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>3</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">松散XAML</font></td>
    <td class="xl73" x:str><font class="font2">Loose XAML</font></td>
    <td class="xl71" x:num>2402</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>4</td>
    <td class="xl76" x:str><font class="font2">.NET Framework相关组件</font></td>
    <td class="xl76" x:str><font class="font2">带有清单的权限的组件</font></td>
    <td class="xl77" x:str><font class="font2">Permissions for components with manifests</font></td>
    <td class="xl75" x:num>2007</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>5</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">运行未用Authenticode签名的组件</font></td>
    <td class="xl73" x:str><font class="font2">Run components not signed with Authenticode</font></td>
    <td class="xl71" x:num>2004</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>6</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">运行已用Authenticode签名的组件</font></td>
    <td class="xl77" x:str><font class="font2">Run components signed with Authenticode</font></td>
    <td class="xl75" x:num>2001</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>7</td>
    <td class="xl72" x:str><font class="font2">ActiveX控件和插件</font></td>
    <td class="xl72" x:str><font class="font2">ActiveX控件自动提示</font></td>
    <td class="xl73" x:str><font class="font2">Automatic prompting for ActiveX controls</font></td>
    <td class="xl71" x:num>2201</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>8</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">对标记为可安全执行脚本的ActiveX控件执行脚本</font></td>
    <td class="xl77" x:str><font class="font2">Script ActiveX controls marked safe for scripting</font></td>
    <td class="xl75" x:num>1405</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>9</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">对未标记为可安全执行脚本的ActiveX控件初始化并执行脚本</font></td>
    <td class="xl73" x:str><font class="font2">Initialize and script ActiveX controls not marked as safe for scripting</font></td>
    <td class="xl71" x:num>1201</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>10</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">二进制文件和脚本行为</font></td>
    <td class="xl77" x:str><font class="font2">Binary and script behaviors</font></td>
    <td class="xl75" x:num>2000</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>11</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">仅允许经过批准的域在未经提示的情况下使用ActiveX</font></td>
    <td class="xl73" x:str><font class="font2">Only allow approved domain to use ActiveX without prompt</font></td>
    <td class="xl71"></td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>12</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">下载未签名的ActiveX控件</font></td>
    <td class="xl77" x:str><font class="font2">Download unsigned ActiveX controls</font></td>
    <td class="xl75" x:num>1004</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>13</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">下载已签名的ActiveX控件</font></td>
    <td class="xl73" x:str><font class="font2">Download signed ActiveX controls</font></td>
    <td class="xl71" x:num>1001</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>14</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许ActiveX筛选</font></td>
    <td class="xl77" x:str><font class="font2">Allow ActiveX Filtering</font></td>
    <td class="xl75" x:num>2702</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>15</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许Scriptlet</font></td>
    <td class="xl73" x:str><font class="font2">Allow Scriptlets</font></td>
    <td class="xl71" x:num>1209</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>16</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许运行以前未使用的ActiveX控件而不提示</font></td>
    <td class="xl77" x:str><font class="font2">Allow previously unused ActiveX controls to run without prompt</font></td>
    <td class="xl75" x:num>1208</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>17</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">运行ActiveX控件和插件</font></td>
    <td class="xl73" x:str><font class="font2">Run ActiveX controls and plug-ins</font></td>
    <td class="xl71" x:num>1200</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>18</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">在ActiveX空间上运行反恶意软件</font></td>
    <td class="xl77" x:str><font class="font2">Run antimalware software on ActiveX controls</font></td>
    <td class="xl75"></td>
    <td class="xl78"></td>
   </tr>
   <tr height="61" style='height:45.75pt;'>
    <td height="61" style='height:45.75pt;'></td>
    <td class="xl71" x:num>19</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">在没有使用外部媒体播放机的网页上显示视频和动画</font></td>
    <td class="xl73" x:str><font class="font2">Display video and animation on a webpage that does not use external media player</font></td>
    <td class="xl71"></td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>20</td>
    <td class="xl76" x:str><font class="font2">脚本</font></td>
    <td class="xl76" x:str><font class="font2">java小程序脚本</font></td>
    <td class="xl77" x:str><font class="font2">Scripting of java applets</font></td>
    <td class="xl75" x:num>1402</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>21</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">活动脚本</font></td>
    <td class="xl73" x:str><font class="font2">Active scripting</font></td>
    <td class="xl71" x:num>1400</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>22</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">启用XSS筛选器</font></td>
    <td class="xl77" x:str><font class="font2">Enable XSS filter</font></td>
    <td class="xl75" x:num>1409</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>23</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许对剪贴板进行编程访问</font></td>
    <td class="xl73" x:str><font class="font2">Allow Programmatic clipboard access</font></td>
    <td class="xl71" x:num>1407</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>24</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许通过脚本更新状态栏</font></td>
    <td class="xl77" x:str><font class="font2">Allow status bar updates via script</font></td>
    <td class="xl75" x:num>2103</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>25</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许网站使用脚本窗口提示获取信息</font></td>
    <td class="xl73" x:str><font class="font2">Allow websites to prompt for information using scripted windows</font></td>
    <td class="xl71" x:num>2105</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>26</td>
    <td class="xl76" x:str><font class="font2">其他</font></td>
    <td class="xl76" x:str><font class="font2">呈现旧版筛选器</font></td>
    <td class="xl77" x:str><font class="font2">Render legacy filters</font></td>
    <td class="xl75"></td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>27</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">持续使用用户数据</font></td>
    <td class="xl73" x:str><font class="font2">User data persistence</font></td>
    <td class="xl71" x:num>1606</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>28</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">低权限Web内容区域中的网站可以导航到此区域</font></td>
    <td class="xl77" x:str><font class="font2">Websites in less privileged with content zone can navigate into this zone</font></td>
    <td class="xl75" x:num>2101</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>29</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">加载应用程序和不安全文件</font></td>
    <td class="xl73" x:str><font class="font2">Launching applications and unsafe files</font></td>
    <td class="xl71" x:num>1806</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>30</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">将文件上载到服务器时包含本地目录</font></td>
    <td class="xl77" x:str><font class="font2">Inclue local directory path when uploading files to a server</font></td>
    <td class="xl75" x:str><font class="font2">160A</font></td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>31</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">跨域浏览窗口和框架</font></td>
    <td class="xl73" x:str><font class="font2">Navigate windows and frames across different domains</font></td>
    <td class="xl71"></td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>32</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">启用MIME探查</font></td>
    <td class="xl77" x:str><font class="font2">Enable MIME Sniffing</font></td>
    <td class="xl75"></td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>33</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">使用SmartScreen筛选器</font></td>
    <td class="xl73" x:str><font class="font2">Use SmartScreen Filter</font></td>
    <td class="xl71"></td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>34</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">使用弹出窗口阻止程序</font></td>
    <td class="xl77" x:str><font class="font2">Use Pop-up Blocker</font></td>
    <td class="xl75" x:num>1809</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>35</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">提交非加密表单数据</font></td>
    <td class="xl73" x:str><font class="font2">Submit non-encrypted form data</font></td>
    <td class="xl71" x:num>1601</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>36</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">通过域访问数据源</font></td>
    <td class="xl77" x:str><font class="font2">Access data sources across domains</font></td>
    <td class="xl75" x:num>1406</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>37</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">拖放或者复制和粘贴文件</font></td>
    <td class="xl73" x:str><font class="font2">Drag and drop or copy and paste files</font></td>
    <td class="xl71" x:num>1802</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>38</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">显示混合内容</font></td>
    <td class="xl77" x:str><font class="font2">Display mixed content</font></td>
    <td class="xl75" x:num>1609</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>39</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许META REFRESH</font></td>
    <td class="xl73" x:str><font class="font2">Allow META REFRESH</font></td>
    <td class="xl71" x:num>1608</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>40</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许Microsoft Web浏览器控件的脚本</font></td>
    <td class="xl77" x:str><font class="font2">Allow scripting of Microsoft web bowser control</font></td>
    <td class="xl75" x:num>1206</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>41</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许脚本启动的窗口不受大小或者位置限制</font></td>
    <td class="xl73" x:str><font class="font2">Allow script-initiated windows without size or position constraints</font></td>
    <td class="xl71" x:num>2102</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>42</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许网页上的活动内容使用限制的协议</font></td>
    <td class="xl77" x:str><font class="font2">Allow webpages to use restricted protocols for active content</font></td>
    <td class="xl75"></td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>43</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许网站打开没有地址或者状态栏的窗口</font></td>
    <td class="xl73" x:str><font class="font2">Allow websites to open windows without address or status bars</font></td>
    <td class="xl71" x:num>2104</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>44</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">允许在不同窗口中的域之间拖动内容</font></td>
    <td class="xl77" x:str><font class="font2">Allow dragging of content between domains into separate windows</font></td>
    <td class="xl75" x:num>2709</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>45</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">允许在同一窗口的域之间拖动内容</font></td>
    <td class="xl73" x:str><font class="font2">Allow dragging of content between domains into the same window</font></td>
    <td class="xl71" x:num>2708</td>
    <td class="xl74"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl75" x:num>46</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">在IFRAME中加载程序和文件</font></td>
    <td class="xl77" x:str><font class="font2">Launching programs and files in an IFRAME</font></td>
    <td class="xl75" x:num>1804</td>
    <td class="xl78"></td>
   </tr>
   <tr height="41" style='height:30.75pt;'>
    <td height="41" style='height:30.75pt;'></td>
    <td class="xl71" x:num>47</td>
    <td class="xl72"></td>
    <td class="xl72" x:str><font class="font2">只存在一个证书时不提示进行客户端证书选择</font></td>
    <td class="xl73" x:str><font class="font2">Don't prompt for client certificate selection when only one certificate exists</font></td>
    <td class="xl71" x:str><font class="font2">1A04</font></td>
    <td class="xl74"></td>
   </tr>
   <tr height="60" style='height:45.00pt;'>
    <td height="60" style='height:45.00pt;'></td>
    <td class="xl75" x:num>48</td>
    <td class="xl76" x:str><font class="font2">启用.NET Framework安装程序</font></td>
    <td class="xl76" x:str><font class="font2">启用.NET Framework安装程序</font></td>
    <td class="xl77" x:str><font class="font2">Enable .NET Framework setup</font></td>
    <td class="xl75" x:num>2600</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>49</td>
    <td class="xl72" x:str><font class="font2">下载</font></td>
    <td class="xl72" x:str><font class="font2">文件下载</font></td>
    <td class="xl73" x:str><font class="font2">File download</font></td>
    <td class="xl71" x:num>1803</td>
    <td class="xl74"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl75" x:num>50</td>
    <td class="xl76"></td>
    <td class="xl76" x:str><font class="font2">字体下载</font></td>
    <td class="xl77" x:str><font class="font2">Font download</font></td>
    <td class="xl75" x:num>1604</td>
    <td class="xl78"></td>
   </tr>
   <tr height="21" style='height:15.75pt;'>
    <td height="21" style='height:15.75pt;'></td>
    <td class="xl71" x:num>51</td>
    <td class="xl72" x:str><font class="font2">用户身份验证</font></td>
    <td class="xl72" x:str><font class="font2">登录</font></td>
    <td class="xl73" x:str><font class="font2">Logon</font></td>
    <td class="xl71" x:str><font class="font2">1A00</font></td>
    <td class="xl74"></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="43" style='width:32;'></td>
     <td width="135" style='width:101;'></td>
     <td width="292" style='width:219;'></td>
     <td width="286" style='width:215;'></td>
    </tr>
   <![endif]>
  </table>