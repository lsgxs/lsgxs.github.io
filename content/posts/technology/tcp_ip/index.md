---
title: "Tcp_ip"
date: 2024-03-07T20:20:04+08:00
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
    image: "images/冰山.jpg" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

####  TCP/IP的四层模型

##### 分层类型

```
应用层(http、dns、smtp等应用) 
传输层(tcp)
网络层(ip)
链路层（mac)
```

##### 每个层次的数据包形式

```
应用层: http   应用层负责数据的结构化，
传输层：tcp  packet
网络层：ip  datagram  IP层负责数据包的路由
链路层： mac frame 连接层负责把字节流转换为电流信号 
```

##### TCP四个层次的通讯方式

* 在客户端，自顶向下的数据包传递方向，每个层级在当前数据包的基础上加上下一层级可以识别的头部信息。也就是header+data,这样逐级打包、传递。以浏览器发出的一个浏览网页请求为例子，说明数据打包和传递的过程：

  ```
  1、浏览器根据URL的内容生成http的请求数据（包括头部和主体），调用dns服务获取web服务端请求网页所在主机的ip地址。
  2、调用操作系统的tcp模块，在http的请求数据加上tcp的header，把数据包传递给tcp层。
  3、tcp层把数据包加上ip层需要的head，把数据包传递给ip层。
  4、ip层调用ARP服务，把数据包加上mac。这样数据最终包的最终结构为mac+ip+tcp+http。在最底部的mac层，
  调用网卡的驱动程序，把数据包转换为字节流通过电缆传输
  ```
* 在服务器的接收端
  
  ```
  1、接收端的mac收到字节流后，把他转换为mac可以识别frame，然后解开数据包，取下mac头部信息，把ip+tcp+http数据包发送到上一层的IP层。
  2、在IP层收到数据包后，同样的方式，从数据包中取下IP的头部信息，把tcp+http的数据包发动到tcp层。
  3、TCP层收到数据包后，从数据包取下tcp头部信息，把http数据发送到应用层
  4、应用层的http server收到完整的http请求数据，完成一个数据发送到接收、打包到解包的过程。
  ```
  
  这里的发送和接收、打包和解包的描述只是从概念上理解，有很多术语和细节不够准确，只是为了自己初学期间更好理解整个过程，用自己初步理解的概念来记录，后续学习中不断完善和更新，用更准确的术语和流程认识TCP/IP。

#### TCP连接

* 调用客户端的tcp模块，和服务器端的tcp模块建立连接
  * 具体的三次握手过程待学习
* 完成数据传递
* 断开连接
  * 具体的四次挥手过程待学习

这里的笔记时省略了大量的细节,甚至有的地方并不一定准确，对TCP/IP的轮廓初步认识。如果有兴趣需要进一步学习。到最后，真正要理解的话，要在学习的基础上做项目。



> 下面这段引用来自《Beej’s Guide to Network Programming Using Internet Sockets》

***

Since I just mentioned layering of protocols, it’s time to talk about how networks really work, and to show

some examples of how SOCK_DGRAM packets are built. Practically, you can probably skip this section. It’s

good background, however.

![img](images/dataEncapsulation.png)

​                                                                                                     --Data Encapsulation--

Hey, kids, it’s time to learn about *Data Encapsulation*! This is very very important. It’s so important that

you might just learn about it if you take the networks course here at Chico State ;-). Basically, it says this:

a packet is born, the packet is wrapped (“encapsulated”) in a header (and rarely a footer) by the first protocol

(say, the TFTP protocol), then the whole thing (TFTP header included) is encapsulated again by the next

protocol (say, UDP), then again by the next (IP), then again by the final protocol on the hardware (physical)

layer (say, Ethernet).

When another computer receives the packet, the hardware strips the Ethernet header, the kernel strips the IP

and UDP headers, the TFTP program strips the TFTP header, and it finally has the data.

Now I can finally talk about the infamous *Layered Network Model* (aka “ISO/OSI”). This Network Model

describes a system of network functionality that has many advantages over other models. For instance, you

can write sockets programs that are exactly the same without caring how the data is physically transmitted

(serial, thin Ethernet, AUI, whatever) because programs on lower levels deal with it for you. The actual

network hardware and topology is transparent to the socket programmer.

Without any further ado, I’ll present the layers of the full-blown model. Remember this for network class

exams:

• Application

• Presentation

• Session

• Transport

• Network

• Data Link

• Physical

The Physical Layer is the hardware (serial, Ethernet, etc.). The Application Layer is just about as far from

the physical layer as you can imagine—it’s the place where users interact with the network.

Now, this model is so general you could probably use it as an automobile repair guide if you really wanted

to. A layered model more consistent with Unix might be:

• Application Layer (*telnet, ftp, etc.*)

• Host-to-Host Transport Layer (*TCP, UDP*)

• Internet Layer (*IP and routing*)

• Network Access Layer (*Ethernet, wi-fi, or whatever*)

At this point in time, you can probably see how these layers correspond to the encapsulation of the original

data.

See how much work there is in building a simple packet? Jeez! And you have to type in the packet headers

yourself using “cat”! Just kidding. All you have to do for stream sockets is send() the data out. All you

have to do for datagram sockets is encapsulate the packet in the method of your choosing and sendto() it

out. The kernel builds the Transport Layer and Internet Layer on for you and the hardware does the Network

Access Layer. Ah, modern technology

So ends our brief foray into network theory. Oh yes, I forgot to tell you everything I wanted to say about

routing: nothing! That’s right, I’m not going to talk about it at all. The router strips the packet to the IP

header, consults its routing table.
