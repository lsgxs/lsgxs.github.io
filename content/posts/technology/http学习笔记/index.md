---
title: "Http学习笔记"
date: 2024-03-01T20:40:15+08:00
draft: false
# weight: 2
tags: [http]
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: true
draft: false
hidemeta: false
comments: false
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
thumbnail: "images/communication-application-level.png" 
description: "现有的网络技术是在TCP/IP协议的基础上运行的，HTTP协议是其中的一个子集。按照 TCP/IP协议四层模型的划分方法，HTTP协议在应用层，其他三层分别是传输层、网络层、链路层"
   
---

#### HTTP协议的基本特征

现有的网络技术是在TCP/IP协议的基础上运行的，HTTP协议是其中的一个子集。按照 TCP/IP协议四层模型的划分方法，HTTP协议在应用层，其他三层分别是传输层、网络层、链路层。这里顺便了解一下OSI的七层模型和TCP/IP的四层模型

```apl
----OSI七层模型
应用层
表示层
会话层
传输层
网络层
数据链路层
物理层
```

```ASN.1
----TCP/IP四层模型
应用层
传输层
网络层
链路层
----传输路线和方向
在请求端：从应用层开始，自上而下为应用层、传输层、网络层、链路层
在服务接收端：链路层、网络层、传输层、应用层。
```

* http协议web客户端和服务端通信的基础，是一系列规则。

  ```apl
  1、用报文的格式来保存和描述请求的信息
  2、报文的第一行是verb 
  3、报文的第二行头部信息
  4、接下来是一个回车和换行产生一个空行
  5、下面是报文的主体
  ```

  ```ASN.1
  ----响应报文
  1、报文的第一行是HTTP版本号的响应代码
  2、第二行开始是各类报文头部字段和对应的值，用来表述响应报文信息
  3、接下来就是一个空行(CR+LF)
  4、接下来是响应主体，包含这个返回客户端的html文件等
  ```

  这些关于请求和响应的一系列规则就是所谓的协议，确保客户端和服务端完成通信。

* http协议是无状态的，在两次相邻的请求和回应之间没有任何状态的记录
  * 为记录多次请求和相应之间的状态，引入了cookie技术。浏览器第一次发出请求，在没有cooke信息的情况下，服务器生成cooke信息，记录请求端信息，并在响应报文中增加cookie返回。有了cooke信息的请求再次发送到服务器后，服务器检查保存的cookie信息，就可以获取上次的请求信息，从而实现了浏览状态的保存。

#### HTTP请求报文

浏览器通过URL栏输入的字符串信息生成http报文，报文结构包括`请求行`、`报文头部`、`报文主体`。结构示意图如下：

```ASN.1
GET  /index.html HTTP/1.1     --第一行是请求行  GET是请求的动作、/index.html是请求的资源  http/1.1是http版本号
Host: www.firefox.com         --下面是报文头部   Host字段是请求的主机

【空行CR+LF,也就是回车换行】

【这里是报文主体，不过一般请求报文的主体为空】

```

#### HTTP响应报文

服务器接受到浏览器的请求信息后，按照请求报文中的信息进行相应，并把响应报文回传客户端的浏览器。响应报文结构如下

```ASN.1
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

#### HTTP各类头部信息数据

```ASN.1
--请求端头部字段
Date
Connection
Host
Transfer-Encoding
Accept-Charset
Accept-Encoding
Accept-Language

--响应头部字段
...
具体的字段可以查询文档
```



#### HTTPS

​    由于http协议采用明文传输，不适合应用在重要信息的传输场景，因此就产生了在http基础上附加了加密和认证机制，目前多数使用了SSL和TL协议来提高HTTP协议通信的安全性。可以认为HTTPS就是http+加密+认证+数据完整性。

​    在TCP/IP四层模型中，HTTP是直接和TCP进行通信的，而添加了SSL协议之后，就是HTTP先和SSL通信，然后由SSL和TCP通信，然后完成常规的网络通信。具体的步骤和方法相当复杂，在理解层面认识到这些基础概念就可以，如果有需要或者多网络安全感兴趣，需要更深入的学习。

#### HTTP协议的实现

一般是在浏览器的核心里实现的，各个浏览器厂商都已自己的实现和优化，想看到源代码，只有去试试Mozilla Firefox的开源项目看看。或者去[CURL](https://curl.se/download.html)的开源项目看看（client url），那里有http相关工具库的开源项目。而到了TCP协议层，就是在Windows系统的网络库里实现了吧（这里以Windows为例，毕竟自己目前没有把Linx用起来的环境）。忽然感觉，想真正学到Why层面的知识，只有去看看源代码，可是那成千上万行的源代码，有耐心和功力看的懂吗。如果有兴趣，可以借助Sourcetrail类的源代码阅读工具，高效阅读。人的精力是有限的，在搭建了整体的学习框架后，需要专注在自己喜欢的领域不断去学习吧，想在各个领域都学的很通透，那是天才做的事情。

#### HTTP请求和响应数据结构的例子

```
HTTP operates on the concept of requests and responses. The client requests a web page, the server
responds by sending it back.

A simple HTTP request from a client looks like this:
GET / HTTP/1.1
Host: example.com
Connection: close

That shows the request header which consists of the request method, path, and protocol on the first line,
followed by any number of header fields. There is a blank line at the end of the header.
This request is saying “Get the root web page from the server example.com and I’m going to close the
connection as soon as I get your response.”
Ends-of-line are delimited by a Carriage Return/Linefeed combination. In Python or C, you write a CRLF
like this:
"\r\n"

If you were requesting a specific file, it would be on that first line, for example:
GET /path/to/file.html HTTP/1.1
(And if there were a payload to go with this header, it would go just after the blank line. There would also
be a Content-Length header giving the length of the payload in bytes. We don’t have to worry about
this for this project.)

A simple HTTP response from a server looks like:
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 6
Connection: close
Hello!

This response says, “Your request succeeded and here’s a response that’s 6 bytes of plain text. Also, I’m
going to close the connection right after I send this to you. And the response payload is ‘Hello!’.”
Notice that the Content-Length is set to the size of the payload: 6 bytes for Hello!.
Another common Content-Type is text/html when the payload has HTML data in it.
```

