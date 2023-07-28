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

| 序号 | 自定义项目中文(中文) | 自定义项目(英文) | 编码 | 值   |
| ---- | -------------------- | ---------------- | ---- | ---- |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |
|      |                      |                  |      |      |

