---
title: "正向代理和反向代理"
date: 2022-12-01T13:01:08+08:00
draft: false
# weight: 2
tags: ["NetWork","网络"]
# author: ["Me", "You"] # multiple authors
showToc: true
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
ShowCodeCopyButtons: false
cover:
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

#### 正向代理服和反向代理的基本概念

##### 网络模型的发展

* 两层网络模型：网络客户端，服务器。实际是就是最初的client/server模型。随着客户端请求规模的增加，受限于服务器端计算能力和网路带宽，服务器端的响应不再及时，于是就出现了三层模型或者分布式网路模型。
* 简单构建一个三层网络模型：网络客户端、代理服务器、应用服务器（如数据库服务器、邮件服务器等，分布在多台主机或者表现为一台主机的多个不同系统服务）。
* 分布式多层模型。这个比较复杂，暂不深究。这里只是记录自己对反向代理概念的初步认识。

##### 正向代理

正向代理相对容易理解一点，就是在对客户端的请求由代理服务器处理，客户并不关心究竟是谁提供了这个应用服务。实际上可以理解为代理服务器是对客户的请求进行调度。

##### 反向代理

自己对反向代理的概念和实践有限，接触caddy才经常看到这个reverse proxy词汇。看到知乎上关于反向代理有各种理解和解释。自己的理解，对多个系统服务进行调度的服务器，就是反向代理服务器。所谓的正向代理和反向代理有点绕，按照现有的模型和体系理解，正向代理服务器就是负责调度客户端请求的服务器，而反向代理服务器就是强调专门调度提供系统服务的服务器。按照自己的初步理解，负责客户端层面的就是正向代理服务器，而面向系统服务的就是反向代理服务器。

一句话总结：收集汇总网络客户请求的行为叫做正向代理，负责分发、调度web请求给系统服务的的行为叫做反向代理。有空以caddy的反向代理设置为例，学习一下这方面的知识，在实践中理解。

