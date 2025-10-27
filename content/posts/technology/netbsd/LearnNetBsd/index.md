---
title: "LearnNetBsd"
date: 2024-05-15T17:13:30+08:00
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
thumbnail: "images/figure-23-3.png"
description: "学习了NetBSD官方文档，记录一部分自己学习的内容，从基础的web知识开始"    
---

#### NetBSD的安装

#### TCP/IP地址格式(以IPv4为例)

#####  tcp/ip网络的分类

使用4个字节（32位）的十进制数书写方法来表示ip地址。比如：`132.199.15.99`

* A类网络：以`0`开头的第一个字节表示网络地址、后三个字节作为主机地址空间

* B类网络：以`10`开头的前两个字节表示网络地址，后两个字节作为主机地址空间

* C类网络：`110`开头的前三个字节表示网络地址，最后一个字节地址作为主机地址空间

##### 网络地址空间的计算方法

> ```
> 在TCP/IP网络中，A、B、C三类网络分别具有不同的网络和主机地址空间。以下是关于这三类网络的详细解释：
> 
> A类网络：
>  网络地址空间：A类网络地址的第1个字节为网络地址，最高位固定为0，因此其网络地址的范围是1.0.0.0到126.0.0.0。这里要注意的是，数字0和127并不作为主机的IP地址，而是有特殊用途（0表示本地宿主机，127保留给内部回送函数）。所以，A类地址实际上只有126个可用的网络。
>  主机地址空间：A类地址的其他3个字节为主机地址，因此每个A类网络理论上可以连接16777214台主机（减去2是因为全0的主机号表示网络地址，全1的主机号表示广播地址）。
> 
> B类网络：
>  网络地址空间：B类网络地址的前两个字节为网络地址，网络地址的最高位必须是“10”，因此其网络地址的范围是128.1.0.0到191.255.0.0。
>  主机地址空间：B类地址的后两个字节为主机地址，因此每个B类网络可以容纳最多65534台主机（同样减去2是因为全0和全1的主机号有特殊用途）。B类网络地址适用于中等规模的网络。
> 
> C类网络：
>  网络地址空间：C类网络地址的前三个字节为网络地址，网络地址的最高位必须是“110”，因此其网络地址的范围是192.0.0.0到223.255.255.0。
>  主机地址空间：C类地址的最后一个字节为主机地址，因此每个C类网络可以容纳最多254台主机（减去2是因为全0和全1的主机号有特殊用途）。C类网络地址数量较多，适用于小规模的局域网络。
> 
> 以上是关于TCP/IP网络中A、B、C三类网络的网络和主机地址空间的详细解释。需要注意的是，这些地址空间的划分是基于IPv4协议的，而IPv6协议则使用了不同的地址表示方式和空间划分规则。
> ```
>
> ```
> 在IPv4地址中，B类网络的地址范围是128.0.0.0到191.255.0.0。这个范围是基于IP地址的类别划分和子网掩码的概念。如何计算出B类网络的这个范围：
> 
>  IP地址的类别划分：
>  IPv4地址是一个32位的二进制数，通常表示为四个十进制数，每个数在0到255之间，用点号（.）分隔。为了简化路由和地址分配，IPv4地址被划分为几个类别（A、B、C、D、E），其中每个类别的前几位具有特定的模式。
> 
>  B类地址的模式：
>  B类地址的前两位二进制数为10，这对应于十进制的128（二进制10000000）。接下来的14位是网络号，最后的16位是主机号。
> 
>  计算B类地址的范围：
>      网络号的最小值：由于前两位是10，所以网络号的最小值是10000000 00000000 00000000 00000000，即128.0.0.0。
>      网络号的最大值：为了得到B类地址的最大值，我们需要将网络号的后14位全部设置为1，即10111111 11111111 00000000 00000000。这对应于十进制的191.255.0.0。
> 
> 所以，B类网络地址的范围是128.0.0.0到191.255.0.0。但是，这里需要注意的是，虽然技术上128.0.0.0和191.255.0.0都是有效的B类网络地址，但在实际应用中，你可能不会直接为一个网络分配这样的地址，因为它们通常是用于标识整个B类地址空间的边界，而不是具体的网络。
> 
> 另外，当你为一个B类网络分配地址时，你还需要选择一个子网掩码来确定哪些位是网络号，哪些位是主机号。对于标准的B类网络，子网掩码通常是255.255.0.0。
> ```
>
> ```
> C类网络的地址空间是基于IPv4地址的类别划分和子网掩码的概念来确定的。以下是关于C类网络地址空间的计算方法：
> 
>  IP地址的类别划分：
>  IPv4地址是一个32位的二进制数，分为四个字节，每个字节用十进制表示并在0到255之间。C类地址是IPv4地址中的一种，其特点在于前三段号码为网络号码，剩下的一段号码为本地计算机的号码。
> 
>  C类地址的模式：
>  C类地址的前三位二进制数为110，这对应于十进制的192（二进制11000000）。接下来的21位是网络号，最后的8位是主机号。
> 
>  计算C类地址的范围：
>      网络号的最小值：由于前三位是110，所以网络号的最小值是11000000 00000000 00000000 00000000，即192.0.0.0。
>      网络号的最大值：为了得到C类地址的最大值，我们需要将网络号的后21位全部设置为1，同时保持前三位为110，即11011111 11111111 11111111 00000000。这对应于十进制的223.255.255.0。
> 
> 因此，C类网络地址的范围是192.0.0.0到223.255.255.0。但请注意，实际的主机地址范围是从192.0.0.1到223.255.255.254，因为全0的主机号表示网络地址，全1的主机号表示广播地址，这两个地址在实际的网络通信中都有特殊用途，不能分配给主机使用。
> 
> 此外，C类地址的子网掩码通常是255.255.255.0，用于区分网络号和主机号。在C类网络中，每个网络最多可以有254台主机（减去网络地址和广播地址）。C类地址适用于小型网络，如校园网和办公网络等。
> ```
>
> 



#### 子网掩码

> ```
> 使用AND操作来确定IP地址的网络部分和主机部分是基于子网掩码的设计原理。子网掩码中的1表示网络位，而0表示主机位。AND操作（位与操作）在二进制层面上工作，对于每一位，只有当两个相应的位都为1时，结果才为1，否则结果为0。
> 
> 当我们对IP地址和子网掩码执行AND操作时，结果中的每一位都将是以下两种情况之一：
>     如果子网掩码中对应位是1（即网络位），那么结果中的这一位将取决于IP地址中对应位的值，因为任何数与1做AND操作都保持原值不变。
>     如果子网掩码中对应位是0（即主机位），那么无论IP地址中对应位的值是什么，结果中的这一位都将是0，因为任何数与0做AND操作的结果都是0。
> 因此，通过执行AND操作，我们实际上是在“屏蔽”IP地址中的主机位，只保留网络位。这样，结果就是一个只包含网络部分的地址，即网络地址。
> 举个例子，假设我们有以下IP地址和子网掩码（为简化，仅使用8位表示）：
> IP地址： 11000001（即193）
> 子网掩码： 11110000（即240，表示前4位是网络位，后4位是主机位）
> 执行AND操作：
> 11000001（IP地址）
> AND 11110000（子网掩码）
> = 11000000（结果，即网络地址192）
> 可以看到，结果中只保留了IP地址中与子网掩码中1相对应的部分（即网络位），而主机位被“屏蔽”为0。这样，我们就能够轻松地确定IP地址的网络部分。
> ```
>
> 

下面是复制NetBSD官网下载的`**The NetBSD Guide**`关于`TCP/IP`的一段文字：

 **TCP/IP Address Format**

TCP/IP uses 4-byte (32-bit) addresses in the current implementations (IPv4), also called IP-numbers

(Internet-Protocol numbers), to address hosts.

TCP/IP allows any two machines to communicate directly. To permit this all hosts on a given network

must have a unique IP address. To assure this, IP addresses are administrated by one central organisation,

the InterNIC. They give certain ranges of addresses (network-addresses) directly to sites which want to

participate in the internet or to internet-providers, which give the addresses to their customers.

If your university or company is connected to the Internet, it has (at least) one such network-address for

its own use, usually not assigned by the InterNIC directly, but rather through an Internet Service Provider

(ISP).

If you just want to run your private network at home, see below on how to “build” your own IP

addresses. However, if you want to connect your machine to the (real :-) Internet, you should get an IP

addresses from your local network-administrator or -provider.

IP addresses are usually written in “dotted quad”-notation - the four bytes are written down in decimal

(most significant byte first), separated by dots. For example, 132.199.15.99 would be a valid address.

Another way to write down IP-addresses would be as one 32-bit hex-word, e.g. 0x84c70f63. This is not

as convenient as the dotted-quad, but quite useful at times, too. (See below)

Being assigned a network means nothing else but setting some of the above-mentioned 32 address-bits to

certain values. These bits that are used for identifying the network are called network-bits. The

remaining bits can be used to address hosts on that network, therefore they are called host-bits. Figure

23-1 illustrates the separation.

**Figure 23-1. IPv4-addresses are divided into more significant network- and less significant hostbits**

| n netbits | 32−n hostbits |
| --------- | ------------- |



In the above example, the network-address is 132.199.0.0 (host-bits are set to 0 in network-addresses)

and the host’s address is 15.99 on that network.

How do you know that the host’s address is 16 bit wide? Well, this is assigned by the provider from

which you get your network-addresses. In the classless inter-domain routing (CIDR) used today, host

fields are usually between as little as 2 to 16 bits wide, and the number of network-bits is written after the

network address, separated by a “/”, e.g. 132.199.0.0/16 tells that the network in question has 16

network-bits. When talking about the “size” of a network, it’s usual to only talk about it as “/16”, “/24”,

etc.

Before CIDR was used, there used to be four classes of networks. Each one starts with a certain

bit-pattern identifying it. Here are the four classes:

• Class A starts with “0” as most significant bit. The next seven bits of a class A address identify the

network, the remaining 24 bit can be used to address hosts. So, within one class A network there can

be 224 hosts. It’s not very likely that you (or your university, or company, or whatever) will get a whole

class A address.

The CIDR notation for a class A network with its eight network bits is an “/8”.

• Class B starts with “10” as most significant bits. The next 14 bits are used for the networks address

and the remaining 16 bits can be used to address more than 65000 hosts. Class B addresses are very

rarely given out today, they used to be common for companies and universities before IPv4 address

space went scarce.

The CIDR notation for a class B network with its 16 network bits is an “/16”.

Returning to our above example, you can see that 132.199.15.99 (or 0x84c70f63, which is more

appropriate here!) is on a class B network, as 0x84... = **10**00... (base 2).

Therefore, the address 132.199.15.99 can be split into an network-address of 132.199.0.0 and a

host-address of 15.99.

• Class C is identified by the MSBs being “110”, allowing only 256 (actually: only 254, see below) hosts

on each of the 221 possible class C networks. Class C addresses are usually found at (small) companies.

The CIDR notation for a class C network with its 24 network bits is an “/24”.

• There are also other addresses, starting with “111”. Those are used for special purposes (e. g.

multicast-addresses) and are not of interest here.

Please note that the bits which are used for identifying the network-class are part of the network-address.

When separating host-addresses from network-addresses, the “netmask” comes in handy. In this mask,

all the network-bits are set to “1”, the host-bits are “0”. Thus, putting together IP-address and netmask

with a logical AND-function, the network-address remains.

To continue our example, 255.255.0.0 is a possible netmask for 132.199.15.99. When applying this

mask, the network-address 132.199.0.0 remains.

For addresses in CIDR notation, the number of network-bits given also says how many of the most

significant bits of the address must be set to “1” to get the netmask for the corresponding network. For

classful addressing, every network-class has a fixed default netmask assigned:

• Class A (/8): default-netmask: 255.0.0.0, first byte of address: 1-127

• Class B (/16): default-netmask: 255.255.0.0, first byte of address: 128-191

• Class C (/24): default-netmask: 255.255.255.0, first byte of address: 192-223

Another thing to mention here is the “broadcast-address”. When sending to this address, *all* hosts on the

corresponding network will receive the message sent. The broadcast address is characterized by having

all host-bits set to “1”.

Taking 132.199.15.99 with its netmask 255.255.0.0 again, the broadcast-address would result in

132.199.255.255.

You’ll ask now: But what if I want a host’s address to be all bits “0” or “1”? Well, this doesn’t work, as

network- and broadcast-address must be present! Because of this, a class B (/16) network can contain at

most 216-2 hosts, a class C (/24) network can hold no more than 28 -2 = 254 hosts.

Besides all those categories of addresses, there’s the special IP-address 127.0.0.1 which always refers to

the “local” host, i.e. if you talk to 127.0.0.1 you’ll talk to yourself without starting any network-activity.

This is sometimes useful to use services installed on your own machine or to play around if you don’t

have other hosts to put on your network.

Let’s put together the things we’ve introduced in this section:

IP-address

32 bit-address, with network- and host-bits.

Network-address

IP-address with all host bits set to “0”.

Netmask

32-bit mask with “1” for network- and “0” for host-bits.

Broadcast

IP-address with all host bits set “1”.

localhost’s address

The local host’s IP address is always 127.0.0.1.

**23.5 Subnetting and Routing**

After talking so much about netmasks, network-, host- and other addresses, I have to admit that this is

not the whole truth.

Imagine the situation at your university, which usually has a class B (/16) address, allowing it to have up

to 216 ~= 65534 hosts on that net. Maybe it would be a nice thing to have all those hosts on one single

network, but it’s simply not possible due to limitations in the transport media commonly used today.

For example, when using thinwire ethernet, the maximum length of the cable is 185 meters. Even with

repeaters in between, which refresh the signals, this is not enough to cover all the locations where

machines are located. Besides that, there is a maximum number of 1024 hosts on one ethernet wire, and

you’ll lose quite a bit of performance if you go to this limit.

So, are you hosed now? Having an address which allows more than 60000 hosts, but being bound to

media which allows far less than that limit?

Well, of course not! :-)

The idea is to divide the “big” class B net into several smaller networks, commonly called sub-networks

or simply subnets. Those subnets are only allowed to have, say, 254 hosts on them (i.e. you divide one

big class B network into several class C networks!).

To do this, you adjust your netmask to have more network- and less host-bits on it. This is usually done

on a byte-boundary, but you’re not forced to do it there. So, commonly your netmask will not be

255.255.0.0 as supposed by a class B network, but it will be set to 255.255.255.0.

In CIDR notation, you now write a “/24” instead of the “/16” to show that 24 bits of the address are used

for identifying the network and subnet, instead of the 16 that were used before.

This gives you one additional network-byte to assign to each (physical!) network. All the 254 hosts on

that subnet can now talk directly to each other, and you can build 256 such class C nets. This should fit

your needs.

To explain this better, let’s continue our above example. Say our host 132.199.15.99 (I’ll call him dusk

from now; we’ll talk about assigning hostnames later) has a netmask of 255.255.255.0 and thus is on the

subnet 132.199.15.0/24. Let’s furthermore introduce some more hosts so we have something to play

around with, see Figure 23-2.

**Figure 23-2. Our demo-network**

![img](C:/Users/win10/Desktop/新建文件夹 (2)/images/figure-23-2.png)

In the above network, dusk can talk directly to dawn, as they are both on the same subnet. (There are

other hosts attached to the 132.199.15.0/24-subnet but they are not of importance for us now)

But what if dusk wants to talk to a host on another subnet?

Well, the traffic will then go through one or more gateways (routers), which are attached to two subnets.

Because of this, a router always has two different addresses, one for each of the subnets it is on. The

router is functionally transparent, i.e. you don’t have to address it to reach hosts on the “other” side.

Instead, you address that host directly and the packets will be routed to it correctly.

Example. Let’s say dusk wants to get some files from the local ftp-server. As dusk can’t reach ftp directly

(because it’s on a different subnet), all its packets will be forwarded to its "defaultrouter" rzi

(132.199.15.1), which knows where to forward the packets.

Dusk knows the address of its defaultrouter in its network (rzi, 132.199.15.1), and it will forward any

packets to it which are not on the same subnet, i.e. it will forward all IP-packets in which the third



address-byte isn’t 15.

The (default)router then gives the packets to the appropriate host, as it’s also on the FTP-server’s

network.

In this example, *all* packets are forwarded to the 132.199.1.0/24-network, simply because it’s the

network’s backbone, the most important part of the network, which carries all the traffic that passes

between several subnets. Almost all other networks besides 132.199.15.0/24 are attached to the

backbone in a similar manner.

But what if we had hooked up another subnet to 132.199.15.0/24 instead of 132.199.1.0/24? Maybe

something the situation displayed in Figure 23-3.

**Figure 23-3. Attaching one subnet to another one**

![img](C:/Users/win10/Desktop/新建文件夹 (2)/images/figure-23-3.png)

When we now want to reach a host which is located in the 132.199.16.0/24-subnet from dusk, it won’t

work routing it to rzi, but you’ll have to send it directly to route2 (132.199.15.2). Dusk will have to know

to forward those packets to route2 and send all the others to rzi.

When configuring dusk, you tell it to forward all packets for the 132.199.16.0/24-subnet to route2, and

all others to rzi. Instead of specifying this default as 132.199.1.0/24, 132.199.2.0/24, etc., 0.0.0.0 can be

used to set the default-route.

Returning to Figure 23-2, there’s a similar problem when dawn wants to send to noon, which is

connected to dusk via a serial line running. When looking at the IP-addresses, noon seems to be attached

to the 132.199.15.0-network, but it isn’t really. Instead, dusk is used as gateway, and dawn will have to

send its packets to dusk, which will forward them to noon then. The way dusk is forced into accepting

packets that aren’t destined at it but for a different host (noon) instead is called “proxy arp”.

The same goes when hosts from other subnets want to send to noon. They have to send their packets to

dusk (possibly routed via rzi),
