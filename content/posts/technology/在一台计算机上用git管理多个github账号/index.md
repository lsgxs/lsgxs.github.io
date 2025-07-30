---
title: "在一台计算机上用git管理多个github账号"
date: 2022-11-01T22:03:27+08:00
draft: false
tags: ["git","github账号","github"]
thumbnail: "images/冰山.jpg"
description: "如果你在本地电脑上有两个不同的博客系统，在github上创建了两个账户，就可以采用这个方法同时管理多个github账号"
---

* 首先取消用户名和邮箱的全局设置

  git config `--list`查看一下全局配置参数列表，如果列表显示里包含自己设置的github登录用户名和邮箱，就使用下面两条命令取消全局配置参数：

  git config `--global` `--unset` user.name “your-name-for-github”

  git config `--global ` `--unset` user.email  "your-mailbox-for-github"
  
* 使用ssh-keygen分别生成多个github账户对应的密钥对

  `ssh-keygen -t ed25519 -f id_ed25519_hexo -C "mailbox-for-github"`

  `ssh-keygen -t ed25519 -f id_ed25519_hugo -C "mailbox-for-github"`

  `ssh-keygen -t ed25519 -f id_ed25519_tiddlywiki -C "mailbox-for-github"`

  ~~~bash
  1、 把对应账号的公钥添加在github的settings->ssh
  2、启动ssh-agent添加私钥
     eval "$(ssh-agent -s)"
     ssh-add  ~/.ssh/id_xxxxxx         --后面的参数是对应的私钥文件名
     参照：https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
  ~~~

* 在`~/.ssh`目录下新建config文件（没有扩展名的文本文件），内容如下：
  ~~~nginx
  #first
  Host hexo
  HostName github.com
  User username_for_github
  IdentityFile ~/.ssh/id_xxxxxx
  #second
  Host hugo
  HostName github.com
  User username_for_github
  IdentityFile ~/.ssh/id_ed25xxxxxx
  #Third
  Host tiddlywiki
  HostName github.com
  User username_for_github
  IdentityFile ~/.ssh/id_edxxxxx
  
  --Host是主机的别名
  --HostName都是github.com
  --User对应三个github账户的用户名
  --IdentityFile 是~/.ssh/目录下对应的私钥文件名称
  ~~~

* 配置好密钥对文件和config文件之后，测试ssh通过git协议能否联通github

  ~~~bash
    ssh -T git@hexo
    ssh -T git@hugo
    ssh -T git@tiddlywiki  
  ~~~

  如果测试成功，就会返回类似的信息：Hi your-user-name! You've successfully authenticated, but GitHub does not provide shell access
 ![](images/ssh-test.png)

* 有了配置文件之后，以后添加远程连接时就要使用主机别名的方法，比如：

  * git remote add origin git@hugo:username/username.github.io.git 
  * git push -u  origin main

*  在其他电脑使用同样配置

  如果在别的电脑也可以实现一台机器管理多个github账号，可以把Windows当前用户`/.ssh`目录下的config、所有账号对应的密钥对文件都复制到目标电脑，就可以实现在不同机器上实现同样的功能。
