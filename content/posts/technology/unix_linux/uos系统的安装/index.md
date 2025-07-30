---
title: "统信UOS系统的安装"
date: 2023-07-24T19:56:18+08:00
draft: false
# weight: 2
tags: ["first"]
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
thumbnail: "images/bootmgr.jpg"
description: "十年前玩过linux,感觉熟悉了基本的玩法，但是并没有做笔记的习惯，发现好多以前了解比较深入和细致的知识点，现在好多都忘记了，甚至要从新再拾起来。工作中也许有机会更换到linux平台。先记录个最基本的入门知识，安装linux的发行版统信UOS，一个国产Linux发行版，是收购了Deepin Linux之后的发行版。"   
---

十年前玩过linux,感觉熟悉了基本的玩法，但是并没有做笔记的习惯，发现好多以前了解比较深入和细致的知识点，现在好多都忘记了，甚至要从新再拾起来。工作中也许有机会更换到linux平台。先记录个最基本的入门知识，安装linux的发行版统信UOS，一个国产Linux发行版，是收购了Deepin Linux之后的发行版。毕竟是国产的发行版，使用起来顺手很多。在熟悉unix&linux基本知识之前，最基础的应该是对分区的认识。下面是几种常见的分区方案：

#### 三种分区方案

* 两个分区：linux的根分区/（至少10G以上空间）和一个swap分区

* 三个分区：linux根分区/、swap分区和boot分区

* 多个分区： 

  * linux根分区/,类型是主分区，文件系统ext4,挂载与/，须大于10G

  * swap分区，交换分区，文件类型为linux-swap，相当于windows的虚拟内存。物理内存小于4G的，swap设置为2倍内存大小；内存大于4g且小于16G,设置为内存大小的swap空间。
  * boot分区，存储引导信息，一般设置为2G
  * home分区,用于存放文件，设置为100G
  * /usr/local  存储应用软件安装信息，
  * opt分区  
  * var分区   系统日志信息。一般是服务器用的分区，普通电脑可不用新建此分区, 分区大小根据服务器功能多少决定分区空间大小。
  * recovery   在尾部的一个恢复分区，设置为10G

最好一个分区一个挂载点， 建立交换分区和恢复分区时，自动分配挂载及磁盘文件系统格式， 其他分区要手动挂载并且手动选磁盘文件系统格式，选EXT4就行。不要仅仅只有1个根分区而没有其他分区，如果根分区坏了，整个电脑数据就丢了。分配多个分区，其中一个分区坏了，不影响其他分区的数据。

#### 安装

从上面的分区方案来看，除了Windows之外，至少留两个以上的主分区。如果一台机器上只安装linux则分区要简单点，可以直接选择UOS提供的全部安装，会自动创建以上分区。新手入门最好选择手动安装，熟悉一下多分区的创建。

* 下载UOS ISO镜像

* 在Deepin linux的网站上下载deepin-boot-make制作U盘安装工具。也可以使用rufus.exe来制作UOS安装U盘

* U盘启动后，选择手动安装模式，新建根分区(/,20G)、boot分区(3G)、swap分区(8G)、home分区(30G)、/usr/local (30G),把系统装在/分区。

* 安装完毕后，系统重启，如果有Windows系统共存，会显示多启动菜单。如下图：

  ![img](images/bootmgr.jpg)

* 登录系统后，显示类似X-windwos的可视化窗口，操作起来和windows很像。如果网络通畅的话，可以在应用商店里安装应用程序

  ![img](images/appstore.png)

* 可以在控制中心找到通用，然后找到启动菜单(设置启动延迟)、开发者模式（开启root用户权限）

![img](images/ControlCenter.png)

到这里就可以使用UOS完成基本办公环境的构建，如果国产替代系统把办公设备硬件适配做的再好点，国产替代是很有市场和希望的，国产加油。

#### Unix&Linux的基础知识学习

##### UNIX发展史

1964年贝尔实验室（Bell Labs）、通用电气（General Electric）和麻省理工学院（MIT）联合启动研发第二代分时操作系统**MULTICS**（Multiplexed Information and Computing Service）(注：MULTICS正式研制始于1965年)

计划，该计划的目的是让大型机支持300位使用者同时连线使用。因进度不理想、资金不到位，贝尔实验室退出该计划。1969年，贝尔实验室研究人员Ken Thompson在退出MULTICS项目时，准备将原本在MULTICS系统上开发的“star travel”游戏转移到DEC PDP-7上运行。在转移游戏程序运行环境的过程中， Ken Thompson和Dennis Ritchie共同动手设计了一套包含文件系统、命令解释器以及一些实用程序的支持多任务的操作系统。与Multics相对应，这个新操作系统被同事Brian Kernighan戏称为UNICS（UNiplexed　Information and Computing System，非复用信息和计算机服务），之后大家取谐音便叫成了UNIX。

1970年Thompson尝试用Fortran重写UNIX失败后整合BCPL成B语言，1971年他用B语言在PDP-11/24上重写UNIX，当年的11月3日，UNIX第1版（UNIX V1）正式诞生。

1972年，UNIX发布了第2版，最大的改进是添加了后来成为UNIX标志特征之一的管道功能。在开发UNIX V2的时候，Ritchie给B语言加上了数据类型和结构的支持，推出了C语言。

1973年，Ken Thompson和Dennis Ritchie使用C语言重写了UNIX，形成第3版UNIX。在当时，为了实现最高效率，系统程序都是由汇编语言编写，所以Ken Thompson和Dennis Ritchie此举是极具大胆创新和革命意义的。用C语言编写的Unix代码简洁紧凑、易移植、易读、易修改，为此后UNIX的发展奠定了坚实基础。

1974 年 Ken Thompson和Dennis Ritchie 共同在 Communications of the ACM 发表 了一篇 UNIX 论文  "UNIX Time-Sharing System" 得到相当大的回响。 1975 年 UNIX  发表第六版（V6）﹐其提供的强大功能更胜过当时昂贵的大型计算机操作系统，其最大特点是以高级语言写成(C语言)，仅需要做少部份程序的修改便可移植到不同的计算机平台上。 UNIX V6 版本并附有完整的程序原始码，在1976年正式从贝尔实验室内部传播到各大学及研究机构，UC  Berkeley 依据这个版本开 始研究并加以发展，并在 1977 年发表 1 BSD（1st Berkeley Software  Distribution）版本的 UNIX OS，其后续的发展更为 UNIX OS 贡献良多且影响深远。

1980年，美国电话电报公司发布了UNIX的可分发二进制版（Distribution Binary）许可证，启动了将UNIX商业化的计划。

1981年，美国电话电报公司基于UNIX V7开发了UNIX System III 的第一个版本（1982年发布）。这是一个商业版本，仅供出售。

1983年，美国电话电报公司成立了UNIX系统实验室（UNIX System Laboratories，USL），并综合其他大学和公司开发的各种UNIX，开发出UNIX System V Release  1（简称SVR1）。这个新的UNIX商业发布版本不再包含源代码。美国电话电报公司开始积极地保护UNIX的源代码。从发布System  III开始，该公司的所有UNIX版本转由一个强调稳定的商业发行版本小组进行维护。

此后，其他一些公司也开始为其自己的小型机或工作站提供商业版本的UNIX系统，有些选择System V作为基础版本，有些则选择了BSD。BSD的一名主要开发者，Bill Joy，在BSD基础上开发了SunOS，并最终创办了SUN公司。

UNIX System V Release  4发布后不久，AT&T就将其所有UNIX权利出售给了Novell。Novell期望以此来对抗微软的Windows  NT，1993年Novell将SVR4的商标权利出售给了X/OPEN公司，后者成为定义UNIX标准的机构。1996年，X/OPEN和OSF/1合并，创建了国际开放标准组织，由它公布的“单一UNIX规范”定义着具有什么特征的操作系统可以冠上UNIX之名，相对地，不符合这些标准但与Unix有类似性的操作系统只能称为“类Unix”(unix-like)。

至此，Unix发展主线就是System V基础版、BSD。而 Minix（Unix操作系统的教学工具）启发了Linux的诞生，自从Linux加盟了GNU(GNU Linux)阵营后，迅速发展壮大，诞生了RedHat、CentOS、Debian、Ubuntu等发行版Linux。

有空看看《UNIX传奇》、《Unix编程艺术》这两本书，对UNIX发展会有更详细的认识。

自己总结一下：

* 贝尔实验室、通用电气、麻省理工共同开发MULTICS计划
* 贝尔实验室退出该计划，K&R两人组为了在PDP-7机器上实现原MULTICS计划中的star travel,实现了UNIX。
* K&R实现了C语言，用C语言重写了UNIX,此时的Unix为V3版。有了C语言的加持，Unix具有更好的流动性，促进UNIX走出贝尔实验室。
*  UNIX的重要分支BSD产生。UNIX V6 版本并附有完整的程序原始码，在1976年正式从贝尔实验室内部传播到各大学及研究机构。UC  Berkeley 的Bill Joy对这个项目很感兴趣，得到UNIX核心的源码后，依据这个版本研究并加以发展，在1977年发表1BSD（1st Berkeley Software  Distribution）版本的 UNIX OS。Bill Joy也是SUN公司的创办者。Unix V6是贝尔实验室发布的最后一个免费Unix，由于UNIX的高度可移植性，加上当时并没有版权纠纷，很多商业公司基于v6开始发展UNIX，比如IBM的AIX、HP的DEC等。到了BSD4.3,与AT&T的UNIX已经有很大不同了，来自AT&T的UNIX的代码已经不足10%，并且领先了AT&T的UNIX（最早实现tcip/ip协议的就是BSD）
* 1980年后，AT&T开始考虑商业版权，启动了UNIX的商业计划，根据Unix V7开发了UNIX System Release 1,这个商业版本不再提供源代码。UNIX实际上形成了两大派系：AT&T的UNIX  System V系列和UC  Berkeley 的BSD。此时AT&T开始认识到UNIX的商业价值，起诉了包括伯克利在内的很多厂商，伯克利不得已推出不包含任何AT&T源代码的BSD4.4，同时很多厂商因为版权问题，转向了AT&T的System  v系列，这也导致FreeBSD的发展缓慢，有了后来的Linux。
* Minix，是Andrew Tanenbaum 教授为UNIX教学目的而撰写的操作系统。
* 芬兰大学生Linus受Minix启发，自己重新设计类Unix的内核，并把项目开放在网络上，让Linux获得全世界爱好者的贡献，不断发展壮大。

关于UNIX发展史的链接文档：

[UNIX操作系统发展史简介](https://mp.weixin.qq.com/s/GgXAGj0Kbo1gKPT4D4WYSA)

[UNIX发展史](https://www.cnblogs.com/Dodge/articles/4264833.html)

#####  Linux发展史

芬兰赫尔辛基大学的Linus对安德鲁·塔南鲍姆（Andrew Tanenbaum）的著作《操作系统：设计与实现》——一本Minix操作指南深深着迷。由于AT&T对UNIX商业化，无法获取源代码，教授自己教的操作系统课居然没有了操作系统。不让用就自己写一个类UNIX操作系统，尽管比较简单，但是具备了UNIX的基本功能，就命名为Mnix，只能运行在指定的机器上。Andrew的学生就写了驱动来扩展Minix。可是，教授Andrew却觉得自己的操作系统要保持纯洁，不能有其他的代码来源。Linus同学拥有自己的PC，却不能将Minix运行在自己的电脑上。Linus也不得不走上了他无数前辈的道路，不让用，不给用，那就自己写一个操作系统来用。两个月后，一个磁盘驱动程序和一个小到不能再小的文件系统就诞生了，这就是第0.01版的Linux。随后Linus将操作系统上传至FTP，并公布了全部源代码。在USENET讨论区，Linus阐述其初衷：在新操作系统中，人们可以自己编写驱动程序，可以随意修改操作系统以适应不同需求，可以尝试在Minix上运行所有程序，这是Minix从未有过的美好一天“。

理查德·斯托曼（Richard  Stallman）登场，他认为所有软件都是人类智慧和思想的结晶。软件应该自由的让人们使用。1983年，Stallman发起了“GNU（GNU’s Not  Unix的递归缩写）”计划，目的是创建一套完全自由的操作系统，以“重现软件界合作互助的团结精神”。他以“著佐权”（copyleft）标准为范本拟定了一份通用公用版权协议(General Public  License，GPL)。与强调个人版权但限制自由传播的著作权（copyright）不同，GPL更强调公共版权和鼓励自由传播，它允许修改程序、复制软件和销售获利。但前提是公布修改后的全部源代码，必须保证自由思想的传递。GNU计划激发了软件界极大的热情，世界各地的软件奇才们纷纷参与其中。并且开发出包括文字编辑器Emacs、C语言编译器，gcc以及大部分UNIX系统程序库和工具在内的绝大多数软件，很多免费软件的水平甚至都已经超过了相应的付费版本。GNU编写了很多自由免费的软件，可是这些免费软件却运行在不自由的Unix上，这真是一个巨大的讽刺。Stallman承诺大家要两年内重新写一个操作系统，可是五年过去了，依然看不清成功的那一天。

Stallman苦于没有操作系统，芬兰的那边，Linus只有一个操作系统内核而没有应用软件。他们在各自的领域奋斗多年之后，命运终于安排他们走到了一起，Linus率领Linux加盟Stallman的GNU计划，堪称是软件界的天作之合。

1992年，在Linux Kernel平台上工作的开发者只有100位，平台中的核心代码只有几万行。如今，在平台上工作的开发者已经多达1000人，人员的背景也从最初的黑客扩散至更多的行业，平台中的核心代码则已经超过千万行。1998年，全球前500台超级计算机中还只有1台运行Linux。今天在全球前500台超级计算机中，有413台选用Linux。这些计算机遍布世界各地的多个行业，共同主宰着这个智慧的地球。Linux“可自由扩散”并不等同于“缺乏支持”和“业余水平”，恰恰相反，正是由于开放的政策，让无数天才黑客参与进来，这是自由的胜利。就连商业软件公司也参与进来，这些公司技术雄厚又善于市场运作，开创了新的商业模式----销售服务而不是软件(REDHAT就是通过出售Linux服务和支持获利的商业公司)。使Linux从网络黑客和爱好者自娱自乐的工具，变成了一个具有全球影响力的软件帝国。

###### Linux的主流发行版

* Debian
* Ubuntu
* RedHat/CentOS
* Linux  Mint
* Fedora
* 国产的Deepin  、统信UOS，目前是统信收购了Deepin。

* SuSe

先知道个大概，如果需要可以先学习一个版本，再触类旁通。学习一门技术的最快办法就是用起来，如果没有项目驱动，学习效率会慢不少。有空闲时间并且有兴趣的话，在虚拟机安装一下试试。

##### 一句话总结UNIX&LINUX发展史

MULTICS项目中断，没法玩游戏？自己写个Unix;B语言玩不转Unix？那就来个C语言，让UNIX好好转，一直玩到第六关(Unix  V6),引来了伯克利这个好伙伴，UNIX走出贝尔实验室，造出了BSD，BSD太牛逼，贝尔实验室又不干，收回版权不让玩。不让玩，那就自己干，造出BSD4.4看;教授教课无系统，自己做个小系统，名字叫做MINIX;Linus真能干，撇开MINIX小系统，自己造个Linux，Linux太孤单，那就加入GNU。一句话，不让玩就自己造^-^,这就是牛人创造历史的秘密。

