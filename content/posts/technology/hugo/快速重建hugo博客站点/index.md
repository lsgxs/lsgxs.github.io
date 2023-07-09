---
title: "快速重建hugo博客站点"
date: 2023-07-09T22:11:22+08:00
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
    hidden: true # only hide on current single page
---



####  QuickRebuildHugoSite

##### 快速理解hugo 站点的运行模式

* 安装 git 

* 下载  hugo （没有安装包，只有一个可执行文件和两个说明文件）

* 设置hugo运行的工作目录

  * 在自定义的工作目录新建hugo子目录，把下载的hugo可执行文件放在hugo\bin子目录。建立如下所示的目录结构：

    ~~~
    e:\hugo\bin\hugo.exe   --hugo可执行文件所在的目录
    e:\hugo\sites          --自己的站点项目目录
    ~~~

  * 在系统环境变量path中新增项目，指向e:\hugo\bin

    ![img](images\hugo-path.png)

  * hugo  version    `正常就会显示hugo的版本信息`

* 建立一个简单的hugo 站点QuickStart(下面的过程是在git  bash终端下输入命令)

  * hugo  new  site  QuickStart

  * cd QuickStart

  * git  init    `使用git  init初始化QuickStart目录，纳入git管理`

  * git  submodule  add ` https://github.com/theNewDynamic/gohugo-theme-ananke.git ` themes/ananke     `从github上加载theme。从github.com仅下载内容不需要密钥，如果要使用git登录github并发布内容，就要创建密钥对，后面的步骤需要专门配置`

  * echo   "theme = 'ananke'">> hugo.toml

    ~~~
    这个是使用echo命令向配置文件hugo.toml添加主题，也可以使用Windows自带的notepad打开hugo.toml，在文档末尾手动添加：theme = 'ananke'，两种方法结果相同。
    ~~~

 * hugo new  posts/first-post.md     `会在站点项目的contents目录下新建posts目录保存first-post.md。注意这里目录和文件路径的分隔符是/，不是windows下的\`

  * hugo  server  -D

    *  hugo  server  是打开hugo的站点服务

    *  `-D, --buildDrafts     include content marked as draft。这里的-D是大写的字母D,表示显示包括草稿在内的文档内容，在该markdown文档的front-end区域，也就是文件头部信息区域，如果draft：true的话，可以显示该草稿文档。如果不加这个-D参数，就不会显示该草稿文档，比如 hugo  server ,就不显示draft为true的文档，也就是不显示还没有完稿的文档。通过这个-D参数和draft:true或者draft:false，可以灵活掌握是否需要显示草稿`

  * http://localhost:1313/     `在本地使用浏览器以网页形式，以指定的theme预览站点的所有markdown文档`

* hugo       `不带任何参数的hugo ,表示正式发布这些markdown文档，在站点项目根目录下自动新建public目录，把markdown转换为html文件存放在public目录`，还有主题的static目录和本项目的static目录下的资源都生成在public目录下

  * hugo   --cleanDestinationDir   `也可以使用该命令重新生成所有文档`
  * hugo  /?     `在git bash终端下使用该命令查询所有详细用法`
  * 接下就可以把生成的html文档自动化发布到github上。

##### 生成并添加密钥对

* ssh-keygen  -t rsa  -b 4096  -C  "MyMailbox"

* 在本地添加私钥

  * $eval  "$(ssh-agent  -s)"      `启动ssh agent`
  * ssh-add  ~/.ssh/id_rsa_namexxxx    `添加私钥到ssh  agent`

* 将公钥添加到github.com的账号ssh,如下图：

  ![img](images/user_ssh_add_1.png)
  ***
  
  ![img](images/user_ssh_delete.png)
  ***
  
  ![img](images/user_ssh_add_2.png)
  