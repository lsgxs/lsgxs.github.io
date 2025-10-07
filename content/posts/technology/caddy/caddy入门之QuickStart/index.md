---
title: "Caddy QuickStart"
date: 2022-12-02T21:31:59+08:00
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
thumbnail:  "images/caddy.png"
description: "Caddy 是一个功能强大、可扩展的平台，用于服务网站、服务和应用程序，使用 Go 语言编写。"
---

#### 安装caddy

* 获取Caddy

   - [ releases on GitHub](https://github.com/caddyserver/caddy/releases) )

      (expand "Assets")

     - Refer to [Verifying Asset Signatures](https://caddyserver.com/docs/signature-verification) for how to verify the asset signature

   - [caddy download page](https://caddyserver.com/download)

*  安装
   * [把 Caddy作为系统服务安装.](https://caddyserver.com/docs/running#manual-installation) 推荐这种安装方式。
   * caddy是一个独立的可执行文件，不需要再安装，把下载到的caddy.exe放在工作目录下，然后把caddy.exe所在的目录加入系统环境变量path中。如果需要升级caddy,直接用新的caddy.exe覆盖。
#### 运行caddy的两种方式
#####  命令行运行caddy

首先把目录切换到站点目录下。这里所谓的站点，是至少包含有index.html文件的目录，用来测试caddy的静态文件服务。
~~~nginx
caddy file-server 
     # 把当前目录做为要托管的站点，启用caddy的静态文件支持服务，可以显示站点目录下的index.html文件
     # 如果站点目录下没有index.html文件，打开浏览器什么也不显示，误以为是哪里出错了。
在浏览器地址栏输入`http://localhost`或者`localhost`
~~~
~~~ini
caddy file-server --listen  :2015
# 用--listen指定端口
~~~

第二个命令行加了`--listen`参数指定端口号。此时在浏览器地址栏输入：`http://localhost:2015`或者`localhost:2015`。

~~~
 caddy file-server --browse
 -- 把当前目录做为要托管的站点 开启caddy的静态文件支持服务，并用--browse参数开启文件列表显示功能
~~~
第三个命令行多了一个`--browse`参数，可以在浏览器显示站点目录列表。如果有index.html则显示index.html的内容，如果没有index.html文件，就会显示当前站点的所有目录及文件。也就是说file-server会优先显示站点目录的主页，如果没有主页则会显示站点目录列表，列表中的文本文件可以直接打开，其他文件可通过浏览器下载。在根目录下有index.html的情况下想用`--browse`开启文件列表显示服务，需要把index.html修改为别的文件名，比如a_index.html,或者把index.html删除，在浏览器就可以显示站点目录列表。

~~~ini
caddy file-server --browse --root  c:\tools  
# --root参数指定c:\tools作为托管站点根目录；file-server开启静态文件支持，--browse开启显示文件列表
~~~

第四个命令指定了`--root`参数，指定站点根目录为c:\tools

> 注意：在命令行下带参数运行caddy，根据cmd信息提示，并不会自动添加https协议，在浏览器地址栏输入：`http:localhsot`,或者直接输入localhost。可以查看cmd终端窗口的提示信息

##### 使用Caddyfile运行caddy

在站点根目录建立名称为Caddyfile的文本文件，不带扩展名(也可以在编辑好内容之后把扩展名删除）。

~~~ini
localhost

file_server

#这两参数显示站点根目录下的index.html，如果没有自然是空白，以为是哪里出错了。
#以Caddyfile配置文件的方式会默认会自动转换为https协议，除非域名或者主机地址使用http协议。
~~~
`caddy  run `  或者 `caddy  start`

如果站点根目录下没有index.html文件，但是想显示文件列表的话，就在file_server后添加browse参数。关于file_server的详细用法，看最后的官方文档链接。

~~~js
localhost
file_server browse
~~~

~~~ nginx
# https请求地址为localhost时开启c:\tools的目录列表服务
# https请求地址为localhost:2080时，启用反向代理功能，调用filebrowser服务。
# 不同的两个服务分成两个语句块，用{}分开，互相独立
# 站点的https请求地址，自己调试期间可以是ip地址加端口号，实际应用一般为域名

localhost {
    # 开启站点的静态文件服务,显示站点目录的主页
    file_server 
    # 指定站点根目录
    root   c:\myrepos\caddy
}

localhost:2070 {
    # 开启站点的静态文件服务和显示文件列表服务
    file_server browse
    # 指定站点根目录
    root   c:\tools
}
# 域名
localhost:2080  {
    #服务器反向代理设置，把127.0.0.1:8080的filebrowser服务托管在该代理服务器
    #有localhost:2080端口的https请求时，转发给本机的127.0.0.1:8080服务
    # 如果有不同的服务在公司内部其他主机上，指定具体域名：比如：reverse_prox:  exam.com
    # 127.0.0.1为backend address,这个词语是复制acddy网站的，见后面的注释。
    reverse_proxy    127.0.0.1:8080
}
# 关于reverse_prox,从caddy网站上看到的这句话:
# If all you need is a simple reverse proxy over HTTPS (as a TLS terminator), 
# run this command (replacing your domain name and  #actual backend address):
# "caddy reverse-proxy --from example.com --to localhost:9000"
# --from 后面的example.com  代理服务器中维护的域名
# --to  后面的localhost:9000 为backend address，也就是后端的服务
# 

--上面三个block分别实现主页展示、显示指定目录文件列表和反向代理启动filebrowser功能。
--我想学习在一个block里使用caddy所谓的matcher token实现这个三个功能，也就是在root、reverse_proxy等directive后
--面设定请求匹配通配符，用path matcher实现,但是不知道哪里不对，暂时实现不了。
~~~
##### 使用caddy的route directive

~~~~nginx
localhost:2070 {

    # only show index.html in the root of site
	route /index/* {
		uri strip_prefix /index
		file_server {
			root c:\myrepos\caddy
		}
	}

    # open file list  in root  specified by sub-directive root
	route /tools/* {
	       uri strip_prefix /tools
      		file_server {
  			root c:\tools
			browse
		}
	}

    # open  reverse proxy to multi backend server
    reverse_proxy    127.0.0.1:8080
    #  reverse_proxy  /filebrowser/*   127.0.0.1:8080 
    # 使用/filebrowser/*可以通过反向代理打开127.0.0.1:8080的filebrowser服务，
    # 但是登录时提示用户名或者密码错误。 但是reverse_proxy  127.0.0.1:8080却可以顺利登录
    #不知道什么原因，应该是会话数据的问题，暂时不会，先放在这里。
    # 或者有空看看handle_path    
	
}
~~~~

在一个block内启用主页展示、文件列表显示、反向代理启动FileBrowser三个服务，解决了前边的疑惑。

有空看看[handle](https://caddyserver.com/docs/caddyfile/directives/handle#examples)和[handle_path](https://caddyserver.com/docs/caddyfile/directives/handle_path)

[file_server](https://caddyserver.com/docs/caddyfile/directives/file_server)参数详细用法

##### 两种运行caddy托管web站点方式的特点

* 命令行方式运行caddy适合初学caddy各种参数用法。
  
* Caddyfile配置文件方式启动caddy
  
  * 使用caddy start启动caddy时，如果不指定配置文件路径，默认为当前目录，所以最好切换到站点根目录。
  
    ~~~nginx
        caddy start  --config   c:\myrepos\caddy\Caddyfile
    ~~~
    
  * 一次设置长期运行，不用每次都去设置caddy运行环境的各种参数。
  
  * 自动启用HTTPS。在Caddyfile的首行设置里包含域名时，caddy就会提供TLS certificate，为托管的网站启用HTTPS服务。下面是caddy关于[HTTPS](https://caddyserver.com/docs/quick-starts/https#caddyfile)的有关介绍
  
    ~~~
    You will see Caddy provision a TLS certificate and serve your site over HTTPS. This was possible because your site's address in the Caddyfile contained a domain name.
    ~~~
  
    

#### 初学caddy需要注意的几个要点

* 无论是命令行方式运行caddy ，还是以`caddy run ` 或者`caddy start`使用配置文件运行caddy,一个容易忽略的要点是工作目录，最好切换到站点根目录。如果不在当前的工作目录，需要用`--config`参数指定Caddyfile路径。

     ~~~
     caddy  start --config   c:\myrepos\caddy\Caddyfile
     ~~~

*  ~~~nginx
     Client sent an HTTP request to an HTTPS server.
   ~~~

  意思是caddy托管的是HTTPS web  server,可是客户端发出的是http请求，把协议更换为 HTTPS就可以了。有时浏览器会提示风险，继续信任即可打开托管的服务。

* 由于不断变更启动caddy的参数，如果测试新的参数时没有出现预期效果，除了命令行、参数、配置文件错误外，多数情况是由于浏览器缓存的原因，清理缓存就好。

* 启动caddy时，在CMD终端窗口显示的提示信息也很有价值，了解这些信息会明白caddy的工作方式。

* 在日常caddy以系统服务启动运行时，如果修改了配置文件Caddyfile的内容，打开cmd终端窗口，使用`caddy reload`启用最新配置参数。

这些只是自己最近初学caddy的体会，记录下来备忘，可能会有理解不全的地方，有空或有应用需求的话继续深入学习。



#### caddy常用命令

##### caddy

单独一个caddy，不会真正启动caddy，而是会打开caddy 的help，所以任何时候需要查看帮助，输入caddy。也可以输入`caddy help <command>`查看子命令的详细用法。

##### caddy run 

会运行一个前台caddy进程，会阻塞终端窗口，无法继续运行其他命令，直到你使用 `ctrl+c` 或者退出命令窗口

#####  caddy start 

`start` 命令的使用 `run` 一样启动caddy，但是 `start` 启动一个后台运行进程,启动成功后返回，不会阻塞当前终端窗口使用。在Windows下任务管理器下可以看到caddy进程。但是关闭启动时的终端窗口后，caddy进程结束，在Windows测试如此，不知道在Linux下如何。如果想临时测试caddy服务，可以使用`caddy run`,也可以使用`caddy start`，两个命令的区别是`caddy run`会阻塞当前终端窗口，需要运行别的命令的话要再开新终端窗口，而`caddy start`不会阻塞终端窗口，运行成功后启动caddy进程，并返回到终端命令提示符。在正式使用caddy时，推荐把caddy安装为Windows系统服务。

![](G:/gxs/myRepos/lsgxs.github.io/content/posts/technology/caddy/caddy入门之常用命令/caddy-start-success.png)

> [caddy start](https://caddyserver.com/docs/command-line#caddy-start),Same as [`caddy run`](https://caddyserver.com/docs/command-line#caddy-run), but in the background. This command only blocks until the background  process is running successfully (or fails to run), then returns.

##### caddy stop

如果 `caddy start` 是使用默认 `localhost:2019` 启动的，直接使用 `caddy stop` 命令就可以优雅的停止caddy，如果不是默认的，那么需要使用 `-address` 来指定管理地址。

```text
caddy stop -address localhost:2080
--如果caddy的地址是localhost:2080，停止caddy时要指定地址
```

##### caddy  reload

通过 `caddy satrt` 启动的caddy一般是长期运行，不能轻易停止，否则会导致网络服务不可用。如果想使用修改后的配置文件而又不用终止正在运行的caddy，可以使用 `reload` 命令。在修改了正在使用的Caddyfile文件内容后，打开新的终端窗口，运行`caddy relod`,终端窗口会显示`admin   stopped previous server {"address": "localhost:2019"}`的信息，代表caddy服务成功应用了新的配置文件，可以测试一下修改后的Caddyfile文件。

##### caddy  file-server

启动一个文件服务，比如托管一个静态网站、把你的文件夹共享在网络上。可以搭配`browse`使用：`caddy file-server browse`

~~~
localhost:2080
root c:\tools
file_server  browse

~~~

上面这三行文本是Caddyfile的所有内容，直接在caddy所在的目录下运行caddy start，在浏览器输入：`https://localhost:2080`就会在浏览器显示磁盘上c:\tools目录下文件列表。

##### caddy reverse-proxy

这是caddy 提供共代理服务的反向代理功能。使用格式如下：

~~~
caddy reverse-proxy  --from :2080  --to  :8080
caddy reverse-proxy --from example.com --to :9000
--这是在命令终端的格式
reverse_proxy   :8080
~~~

一个反向代理启动FileBrowser的配置文件Caddyfile：

~~~
localhost:2080 {
	#root c:\tools
	#file_server browse
	reverse_proxy    :8080
}
--静态文件浏览服务和反向代理服务同时写在一起并不能达成你的预期，这里注释掉静态文件浏览功能，具体细节需要
--查阅caddy官方文档
~~~

##### caddy fmt

caddy提供的一个辅助工具，可以格式Caddyfile配置文件。

~~~
caddy fmt --overwrite c:\myrepos\caddy\Caddyfile
  --这里的overwrites参数是指用格式化的文件直接覆盖原文件
  --如果注释里有中文，在使用本命令之前备份一份，我发现fmt之后全部乱码。
~~~

##### caddy adapt 

可以把Caddyfile文件内容转换成caddy 默认的json格式。

##### 把caddy安装为Windows系统服务

* 创建服务

  ~~~
  sc.exe create caddy start= auto binPath= "YOURPATH\caddy.exe run"
  --把双引号中的YOURPATH替换为caddy.exe真实路径
  ~~~

* 启动caddy服务

  ~~~
  sc.exe start  caddy
  ~~~

* 停止caddy服务

  ~~~
  sc.exe stop  caddy
  ~~~




> [caddy command ](https://caddyserver.com/docs/getting-started#start-stop-run)

