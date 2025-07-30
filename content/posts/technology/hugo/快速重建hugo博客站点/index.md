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
thumbnail: "images/QuickStart.png"
description: "Create a Hugo site in minutes.
In this tutorial you will:
    Create a site
    Add content
    Configure the site
    Publish the site
Prerequisites
Before you begin this tutorial :
    Install Hugo (extended or extended/deploy edition, v0.128.0 or later)
    Install Git"   
---

####  快速重建HuGo博客站点

一直用hyper-v的win10虚拟机管理博客站点，没有按照流程关机，第二天启动虚拟机时提示内存不足，用各种办法业务没有修复，只好重装win10虚拟机，里面的git管理github多账号设置没有了，只好重新配置。可是习惯了git add-commit-push这简单的三条语句搞定博客文档上传，现在从头来还真是忘记了当时如何设置的。经过一天的摸索，终于还原了原来的状态，记录如下以备忘。在重建之前，先复习一下下面几个概念，理解了原理，实现起来就很容易。

* hugo静态博客的创建、编译和发布
  * 在本地按照Hugo提供的[QuickStart](https://gohugo.io/getting-started/quick-start/)示例做一遍就理解了。我的这个hugo博客使用的是PaperMod主题。
* 自己的hugo 静态博客在github上实现自动发布和部署的方式
  * 使用git-add-commit-push组合推送到github后，采用github本身提供的Deploy Hugo site to pages workflow,它会自己创建gh-pages对象，并把静态的网站文件发布者gh-pages上。
* 与github的通讯方式 
  * app与github一般采用 token（访问令牌）方式通讯，设置好访问权限。
  * git 与github通讯，使用https或者ssh协议等。以ssh协议为例，需要使用ssh-keygen生成一对密钥，公钥放在github的账户ssh设置参数里，私钥在本地通过ssh-agent添加。而git+https协议访问github则每次要输入账号和密码。


* github上的几个重要的基本概念
  * 账户级别的权限，如token 和ssh
  * 仓库级别的权限   deploy keys   和Secretes and variables

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

    ![img](images/hugo-path.png)

  * hugo  version    `正常就会显示hugo的版本信息`(如果提示不识别hugo命令，就重启Windows让系统环境变量生效)

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

##### hugo 静态博客在github上的部署方式

在github上实现自动化部署静态博客有多种方法，我这个hugo静态博客采用的是github提供的最简单的一种方式，直接使用github的acttions提供的Deploy Hugo site to pages workflow，最终的静态网页是发布在由github的action自动建立的gh-pages上，不需要手动建立gh-pages分支再部署。具体的设置如下图(github中仓库的Settings，不是github账户本身的Settings)：

![img](images/github-pages-hugo.png)

##### 用Git管理github博客站点

###### 理解与github的通讯方式

在本地直接使用git来链接、管理github账号，一般使用ssh协议，具有安全、高效的特点，当然也可以使用https协议，只是经常需要输入账号及密码。而使用ssh-agent可以把私钥缓存在本地，直接撰写文档提交到远程，不必再做ssh相关的设置，非常方便。把公钥添加在github账户Settings的ssh里即可。如果使用第三方应用程序接口访问github，则是设置github账号本身的Settings-Develop Settings下的Personal Access Token(传统的tokens) ；如果是基于仓库级的部署，涉及到Deploy Keys和Secrets and variables，则要设置在仓库的Settings下设置。

* git使用ssh 协议访问github
* git使用https协议访问github
* 第三方应用程序API使用token方式访问github账号
* 基于github具体仓库的Deploy key  or Secretes and variables

###### 生成并添加密钥对

* ssh-keygen  -t rsa  -b 4096  -C  "MyMailbox"

  或者`ssh-keygen -t  ed25519 -f ~/.ssh/id_ed25519_hugo  -C  "MyMailBox"`

* 添加私钥到ssh代理（ssh-agent可以缓存ssh，不用每次链接都输入ssh）

  * $eval  "$(ssh-agent  -s)"      `启动ssh agent`
  * ssh-add  ~/.ssh/id_rsa_namexxxx    `添加私钥到ssh  agent`

* 将公钥添加到github.com的账号ssh,步骤如下：

  点击github账户右上角的图片，选择弹出的快捷菜单中的Settings选项，如下图
  
  ![img](images/settings.jpg)
  
  
  
  ![img](images/user_ssh_add_1.png)
  ***
  
  ![img](images/user_ssh_delete.png)
  ***
  
  ![img](images/user_ssh_add_2.png)
  

设置好git和github账号通讯的各种参数之后，使用`git clone git@github.com:yourusername/yourusername.github.io.git`把保存在github的整个站点获取到本地，然后就可以正常的编辑和提交了。把文档笔记部署到github上有个好处，我这本地系统数据丢失了，重做系统再取回就好了。
###### 向远程提交文档

~~~nginx
git   add .
#这里可能会提示要注册邮件和用户信息 
#git   config  --global  user.email  "yourmailbox"
# git  config   --global  user.name  
git  commit -m   "your  commit "    
git   push origin  main 
~~~
到目前为止，已顺利恢复hugo博客站点的正常编辑和自动发布了。只是有一点，在`git  push origin main `时提示没有权限。发现再执行一边添加私钥到ssh-agent的两条语句就可以正常推送了。记得以前是配置过git管理多个github账号的config文件，现在有点懒，暂时就只用hugo这一个静态站点，如果以后需要配置，可以看一下自己的另外一篇文档（在一台计算机上用git管理多个github账号）。

~~~nginx
eval "$(ssh-agent  -s)"
ssh-add ~/.ssh/id_rsa_hugo
~~~

自动添加私钥解决办法：

找到`program files\git\etc\barch.barchrc`,用记事本打开，在文档的末尾添加下面两条命令。如果提示不能保存，就把bash.bashrc文件复制到别处，添加好下面的命令之后再覆盖git安装路径下的bash.bashrc文件。

~~~nginx
#ssh-agent  
eval  "$(ssh-agent -s )"
ssh-add ~/.ssh/id_rsa_hugo
~~~

以后每次打开git bash 终端窗口就会自动添加私钥，如下图所示:

![img](images/ssh-agent.png)
以后就和往常一样直接git-add-commit-push就可以了。

***

##### 简单总结

上面写了这么多，其实是备忘用的，时间久了还真是无法很快重建，几乎涉及到每个步骤的细节。总结一下大致就下面几个步骤：


> **1.[下载git](https://git-scm.com/download/win)并安装**
>
> 正常安装好就可以在bash终端窗口和Windows命令窗口运行各种命令，如果不能运行部分命令的话（比如`ls  -al `,如果提示`command not  found`的提示），可以使直接使用git安装路径下各种命令的绝对路径形式。比如：`/bin/ls  -al`，这个`/bin`应该就是git安装目录下的`C:\Program Files\Git\usr\bin`的映射。git安装目录`C:\Program Files\Git`下的子目录结构，看着有点类似unix的目录结构。

> **2.生成秘钥对**（可以在windows的当前登录用户目录下新建`.ssh`目录，比如:`c:\Users\win10`,在bash终端窗口中，可以使用`cd  ~`直接切换到该目录，如果在bash下不显示当前目录路径，使用`cd  ~`，然后`pwd`就可以显示出当前用的路径）

```bash
ssh-keygen -t rsa -b 4096 -C “mailbox”
```



```bash
--目前推荐使用这种类型
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_hugo -C "mailbox"
```

> **3.复制公钥并添加到hugo的github账户**

*  复制公钥到系统的剪贴板

  ```bash
  clip  <  ~/.ssh/id_rsa_hugo.pub
  ```
* 添加公钥到hugo的github账户。登录hugo博客所在的github账户，点击github账户右上角的图片，选择弹出的快捷菜单中的Settings选项，在窗口左侧选择`SSH and GPG keys`，然后在右侧窗口选择`New SSh key`,把刚才复制的公钥粘贴保存。至于那个公钥的Title名称，选择一个带个语义的名称自己明白就可以。
  

> **4.在本地添加私钥**

```
# 如果不想设置etc目录的管理员权限，可以直接把barch.barchrc文件复制到Windows桌面上，按照下面的步骤添加内容，最后再把该文件复制到`program #files\git\etc`目录下，以管理员的权限替换原文件。
#找到`program files\git\etc\barch.barchrc`,用记事本打开，在文档的末尾添加下面两条命令。如果提示不能保存，就把bash.bashrc文件复制到别处，添加好下面的命令之后再覆盖git安装路径下的bash.bashrc文件。
#ssh-agent  
eval  "$(ssh-agent -s )"
ssh-add ~/.ssh/id_rsa_hugo
```
 在barch.barchrc中添加以上内容之后，一定要关闭bash终端再打开，应用修改内容，否则在使用git clone 命令下载
 github中的仓库到本地时，会提示你没有权限。关闭bash终端，再打开就启用了上面的内容。
 以后每次打开git bash 终端窗口就会自动添加私钥.如下图：

![img](images/gitCloneErr.jpg)
>  **5.下载保存在github的完整站点仓库**

```
git clone  git@github.com:username/username.github.io.git 
```
设置好一对秘钥之后，第一次使用`git  clone`下载github上的hugo博客项目是，会提示如下图所示的提示，直接输入`yes`就好。
![img](images/git-clone-first-time.png)

> **6.正常编辑博客文档，使用git-add-commit-push命令组合推送到github**
>
> * 使用模板新建博客markdown文档。如果不想从头安装配置hugo这个静态站点生成器，可以在下载到本地的博客文档中复制一个作为模板，然后修改`front-matter`的标题等项目，最后把内容替换为新的内容，使用git-add-commit-push即可发布。
>
> * hugo新建markdown博客文档。hugo不需要安装，只需从官网下载一个可执行文件，然后配置好目录结构，设置好环境变量就可以了。最后使用hugo加命令行参数就可以生成博客文档(markdown)。
>   *    [下载hugo-extended_0.121.1_windows-amd64.zip](https://github.com/gohugoio/hugo/releases/tag/v0.121.1)
>   * **新建hugo博客项目目录**  比如建立这样的目录结构：`g:\hugo\bin`、`g:\hugo\sites`。把下载的hugo.exe保存在`bin`目录下，设置好环境变量指向`g:\hugo\bin`目录
>   * hugo  命令行生成markdown文档。鼠标右键当前博客项目根目录，在弹出的快捷菜单中选择`open Git Bash here`打开git bash。`hugo  new posts/technology/css/cssNote/index.md`在指定的目录`posts/technology/css/cssNote`下新建index.md文档。在index.md统计目录下新建`images`目录保存图片文件，可以在index.md中引用图片文件,引用格式为`[img](images/xxxx.png)`。

```
git  add .
git  commit  -m "rebuilding "
# 如果提示需要添加user.email和user.name，执行下面两条命令
# git config  --global user.email "yourmailbox"
# git config  --global user.name "your_github_username"
git push origin  main
#如果在另外一台电脑对远程的仓库做了更新，到当前这台电脑下载远程仓库的更新时，使用下面的语句：
# git  pull origin 
# push到github的hugo仓库后，有自动的hugo编译器脚本自动把markdown文档转换为html文件，利用github pages组织成博客站点。
```

