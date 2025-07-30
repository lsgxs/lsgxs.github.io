---
title: "Go学习笔记"
date: 2023-12-31T22:49:04+08:00
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
thumbnail: "images/go.png" 
description: "The Go programming language is an open source project to make programmers more productive.
Go is expressive, concise, clean, and efficient. Its concurrency mechanisms make it easy to write programs that get the most out of multicore and networked machines, while its novel type system enables flexible and modular program construction. Go compiles quickly to machine code yet has the convenience of garbage collection and the power of run-time reflection. It's a fast, statically typed, compiled language that feels like a dynamically typed, interpreted language. "
---

#### go的安装和基本环境变量的配置

##### 两个重要的环境变量

* GOROOT

  这个环境变量保存的是go的安装路径

* GOPATH 

  这个环境变量保存的是使用go开放项目是的工作目录。比如本机的GOPATH=c:\Users\ls\go,而在go目录下又建立了三个子目录，分别是bin、src、pkg

  ```
  bin  ---用来保存编译后生成的可执行程序
  src  ---用来保存go项目的源文件
  pkg  ---用来保存需要引用的第三方包
  ```

* GOPROXY  

* 在cmd中使用go  env可以列举出所有的go环境变量

  

  ```bash
  Microsoft Windows [版本 10.0.19044.3086]
  (c) Microsoft Corporation。保留所有权利。
  
  C:\Users\ls>go  env
  set GO111MODULE=
  set GOARCH=amd64
  set GOBIN=C:\users\ls\go\bin
  set GOCACHE=C:\Users\ls\AppData\Local\go-build
  set GOENV=C:\Users\ls\AppData\Roaming\go\env
  set GOEXE=.exe
  set GOEXPERIMENT=
  set GOFLAGS=
  set GOHOSTARCH=amd64
  set GOHOSTOS=windows
  set GOINSECURE=
  set GOMODCACHE=C:\Users\ls\go\pkg\mod
  set GONOPROXY=
  set GONOSUMDB=
  set GOOS=windows
  set GOPATH=C:\Users\ls\go
  set GOPRIVATE=
  set GOPROXY=http://goproxy.cn,direct
  set GOROOT=C:\Program Files\Go
  set GOSUMDB=sum.golang.org
  set GOTMPDIR=
  set GOTOOLCHAIN=auto
  set GOTOOLDIR=C:\Program Files\Go\pkg\tool\windows_amd64
  set GOVCS=
  set GOVERSION=go1.21.3
  set GCCGO=gccgo
  set GOAMD64=v1
  set AR=ar
  set CC=gcc
  set CXX=g++
  set CGO_ENABLED=0
  set GOMOD=NUL
  set GOWORK=
  set CGO_CFLAGS=-O2 -g
  set CGO_CPPFLAGS=
  set CGO_CXXFLAGS=-O2 -g
  set CGO_FFLAGS=-O2 -g
  set CGO_LDFLAGS=-O2 -g
  set PKG_CONFIG=pkg-config
  set GOGCCFLAGS=-m64 -fno-caret-diagnostics -Qunused-arguments -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=C:\Users\ls\AppData\Local\Temp\go-build540136378=/tmp/go-build -gno-record-gcc-switches
  
  C:\Users\ls>
  ```

  

1、GOPATH 和 GOROOT

go中更多的是关于包的概念。 其中有两个重要的路径，GOROOT 和 GOPATH

Go开发相关的环境变量如下：

    GOROOT：GOROOT就是Go的安装目录，（类似于java的JDK）
    GOPATH：GOPATH是我们的工作空间,保存go项目代码和第三方依赖包

GOPATH可以设置多个，其中，第一个将会是默认的包目录，使用 go get 下载的包都会在第一个path中的src目录下，使用 go install时，在哪个GOPATH中找到了这个包，就会在哪个GOPATH下的bin目录生成可执行文件
2、修改 GOPATH 和 GOROOT

    GOROOT

GOROOT是Go的安装路径。GOROOT在绝大多数情况下都不需要修改

Mac中安装Go会自动配置好GOROOT，路径为/usr/local/go。Win中默认的GOROOT是在 C:\Go中，也可自己指定

【如下图所示则我的GORROT为：D:\development\go】，以下是GOROOT目录的内容：

可以看到GOROOT下有bin，doc和src目录。bin目录下有我们熟悉的go和gofmt工具。可以认为GOOROOT和Java里的JDK目录类似。

    GOPATH

GOPATH是开发时的工作目录。用于：

    保存编译后的二进制文件。
    go get和go install命令会下载go代码到GOPATH。
    import包时的搜索路径

使用GOPATH时，GO会在以下目录中搜索包：

    GOROOT/src：该目录保存了Go标准库代码。
    GOPATH/src：该目录保存了应用自身的代码和第三方依赖的代码。

假设程序中引入了如下的包：

import "Go-Player/src/chapter17/models"

第一步：Go会先去GOROOT的scr目录中查找，很显然它不是标准库的包，没找到。
第二步：继续在GOPATH的src目录去找，准确说是GOPATH/src/Go-Player/src/chapter17/models这个目录。如果该目录不存在，会报错找不到package。在使用GOPATH管理项目时，需要按照GO寻找package的规范来合理地保存和组织Go代码。
3、HelloWord——GOPATH版

（1）设置并查看GOPATH和GOROOT环境变量

    安装go SKD目录：D:\development\go
    go项目存放目录：D:\development\jetbrains\goland\workspace，并且此目录下含有bin、src、pkg三个文件夹，src文件夹用来存放项目代码

当引入module时，首先在GOROOT的src目录下查找，然后再GPOPATH的src目录下查找

（2）GOLand环境配置

    在D:\development\jetbrains\goland\workspace\src目录下新建项目GO-Player

bin：存放编译后的exe文件

pkg：存放自定义包的目录

src：存放项目源文件的目录

    按如下指令进行配置
    
    可在Settings中选择SDK和添加GOPATH

（3）测试

```go
models：Student.go

main：hello.go

package main
 
import (
	//"./models"  //相对路径
	"Go-Player/src/ademo/models"  //根据GOPATH找
    //根据GOPATH：D:\development\jetbrains\goland\workspace，在其src目录下查找
    //即GOPATH/src/Go-Player/src/ademo/models
	"fmt"
)
 
func main() {
	stu := models.Student{
		Name: "张三",
	}
	fmt.Println(stu)
}
```

此篇文章仅介绍网上大部分GOPATH版本。Go语言Hello World都只简单地介绍了GOPATH版本。但是从Go的1.11版本之后，已不再推荐使用GOPATH来构建应用了。也就是说GOPATH被认为是废弃的，错误的做法。
4、一些踩坑经验

当你开启了GO111MODULE，仍然使用GOPATH模式的方法，在引入自定义模块时会报错。go mod具体使用将在下一篇介绍

GO111MODULE 有三个值：off, on和auto（默认值）。

```bash
GO111MODULE=off，go命令行将不会支持module功能，寻找依赖包的方式将会沿用旧版本那种通过vendor目录或者GOPATH模式来查找。
GO111MODULE=on，go命令行会使用modules，而一点也不会去GOPATH目录下查找。
GO111MODULE=auto，默认值，go命令行将会根据当前目录来决定是否启用module功能。这种情况下可以分为两种情形：
    当前目录在GOPATH/src之外且该目录包含go.mod文件
    当前文件在包含go.mod文件的目录下面。

当modules 功能启用时，依赖包的存放位置变更为$GOPATH/pkg，允许同一个package多个版本并存，且多个项目可以共享缓存的 module。
```

（1）使用了了相对路径：import "./models" 

    报错：build command-line-arguments: cannot find module for path _/D_/dev这里后面一堆本地路径

这是因为在go module下 你源码中 impot …/ 这样的引入形式不支持了， 应该改成 impot 模块名/ 。 这样就ok了

（2）使用结合了GOPATH的形式：import "Go-Player/src/ademo/models" 

于是我们把上面的import改成了结合GOPATH的如上形式

    报错：package Go-Player/src/ademo/models is not in GOROOT D:/development/go/src/GPlayer/src/ademo/models

（3）彻底解决方法：用go env -u 恢复初始设置

不再使用go mod：

```bash
go env -w GO111MODULE=off  或者  go env -w GO111MODULE=auto
go env -u GO111MODULE

  区别在于，如果GO111MODULE=on或者auto，在go get下载包时候，会下载到GOPATH/pkg/mod，引入时也是同样的从这个目录开始。如果这行了上述命令，那么在go get下载包时候，会下载到GOPATH/src 目录下

  本文仅介绍Hello world(GOPATH版），虽然此种方法不推荐使用，但是初学者在使用的时候仍会遇到很多问题。后续将介绍如何使用Go Module版
```

 







参考博客：

```bash
Go语言Hello world(GOPATH和Go Module版)：https://www.jianshu.com/p/2e19ba8ade18
csdn的   [彻底搞懂golang的GOROOT和GOPATH](https://blog.csdn.net/qq_38151401/article/details/105729884)
一次报错的 彻底明白 go的GOROOT ,GOPATH 以及go mod：https://blog.csdn.net/sinat_23156865/article/details/100655475
```





##### 待续...