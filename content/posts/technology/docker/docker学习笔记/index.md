---
title: "Docker学习笔记"
slug: "docker%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-10-04T17:41:41+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: " docker is an platform for  developer  to pack  the application and the environment  together ,and finally delivery  the docker  container  to customer to use. "
thumbnail: "images/冰山.jpg"
---



### what is  docker 

docker is a virtual platform for  developer  to pack  the application and the environment  together as  container ,and finally delivery  the docker  container  to customer to use . 

### how  to install  docker on windows system

- prerequisite（docker  is originally from  `linux` ,so you must  install  windows  subsystem  for  `linux`）
  - enable the two  options of `wsl`  and  virtual machine platform within  program function in  control  panel of windows.
  - reboot  windows
- install    `ubuntu` of the  newest ·`lts` version   from microsoft  store .please  refer  to  how to  install   [wsl](https://learn.microsoft.com/en-us/windows/wsl/install)
- install docker. get Docker Desktop  installation package from [docker]([https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64&_gl=1*1hkhqbw*_gcl_au*MTM2NzYzMzM0MC4xNzU5NTMwMDg3*_ga*MzU1OTI0ODI2LjE3NTk1MzAwOTk.*_ga_XJWPQMJYHQ*czE3NTk1Njg0NjQkbzgkZzEkdDE3NTk1Njg0NzEkajUzJGwwJGgw](https://desktop.docker.com/win/main/amd64/Docker Desktop Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64&_gl=1*1hkhqbw*_gcl_au*MTM2NzYzMzM0MC4xNzU5NTMwMDg3*_ga*MzU1OTI0ODI2LjE3NTk1MzAwOTk.*_ga_XJWPQMJYHQ*czE3NTk1Njg0NjQkbzgkZzEkdDE3NTk1Njg0NzEkajUzJGwwJGgw))。after download the installation execution file ,double the file to run setup ，remember to select the option of Use `WSL 2` instead of Hyper-V (recommended) and don't select the option of" Allow Windows Containers to be used with this installation",because we need to run docker under `wsl`.
- start   `wsl `  
  - you  should  use windows `powershell` to  run  `wsl`  command ,and then  run  into the shell of  `wsl` . remember  not  to  run  ubuntu  directly   which is installed  from   `microsoft`  store.    you should  use  `wsl2`  rather  than wsl1.if  you open the  ubuntu from windows  start  menu,the default  version  is `wsl1`,so you'd  better  run wsl  within  windows  powershell.

### the core  concepts of  docker 

*  image

   like a configuration   template of the application and its  environment .

* container

  be a  instance  of  the configuration  template of the application and  environment .
  
  ```
  1. 镜像 (Image) = 产品设计图
  
      包含应用程序和运行环境
  
      标准化、不可变的模板
  
  2. 容器 (Container) = 产品实例
  
      根据设计图创建的运行实例
  
      每个实例都是独立的
  
  3. Docker Compose = 装配说明书
  
      定义多个产品如何组装成完整系统
  
      管理实例间的协作关系
  ```
  
  

### 使用docker构建基于`mysql`，`nginx`、`wordpress`的个人站点

