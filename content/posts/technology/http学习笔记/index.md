---
title: "Http学习笔记"
date: 2024-03-01T20:40:15+08:00
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
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single paghhtt
---

#### HTTP协议的基本特征
* http协议web客户端和服务端通信的基础，是一系列规则
* http协议是无状态的，在两次相邻的请求和回应之间没有任何状态的记录
  * 为记录多次请求和相应之间的状态，引入了cookie技术。浏览器第一次发出请求，在没有cooke信息的情况下，服务器生成cooke信息，记录请求端信息，并在响应报文中增加cookie返回。有了cooke信息的请求再次发送到服务器后，服务器检查保存的cookie信息，就可以获取上次的请求信息，从而实现了浏览状态的保存。

#### HTTP请求报文

浏览器通过URL栏输入的字符串信息生成http报文，报文结构包括`请求行`、`报文头部`、`报文主体`。结构示意图如下：

```
GET  /index.html HTTP/1.1     --第一行是请求行  GET是请求的动作、/index.html是请求的资源  http/1.1是http版本号
Host: www.firefox.com         --下面是报文头部   Host字段是请求的主机

【空行CR+LF,也就是回车换行】

【这里是报文主体，不过一般请求报文的主体为空】

```

#### HTTP响应报文

服务器接受到浏览器的请求信息后，按照请求报文中的信息进行相应，并把响应报文回传客户端的浏览器。响应报文结构如下

```
HTTP/1.1 200 OK   --第一行是状态行
date:   xxxxxx    --下面是各种头部字段
Server:  Apache
Content-Length: 16
Content-Type: text/html

【下面接着是一个空行:CR+LF,也就是回车换行Carriage Retun 、Line  Feed】

<html     
    <head>
      xxxxx
      
    </head>

    <body>
     xxxxx
    </body>

</html>     --这里是回传给请求端的报文主体，这里是一个html文件的内容

```

#### HTTP响应状态码

```
1xx  正在处理接受的请求
2xx  Success
3xx  Redirection
4xx  Client Error
5xx  Server  Error
```

