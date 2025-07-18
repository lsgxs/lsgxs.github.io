---
title: "测试hugo渲染"
date: 2022-11-13T08:31:38+08:00
draft: false
---

#### 测试hugo静态文档发布后无法渲染的原因

* baseURL的设置

  在自定义config.toml文件时，一定要设置baseURL值为自己的仓库域名，比如：`baseURL = 'https://username.github.io/hugo'`

* hugo   -D

  刚开始在本地使用hugo server -D ，在浏览器浏览本地静态网页文件时没有问题，但是后来发现这个命令并没有在public目录或者自定义的docs目录下生成静态网页文件。`hugo server -D`只是启动自带的这个web服务器，在内存中渲染这些文件，并没有真正生成静态网页文件。在编辑好MarkDown文档之后，要使用hugo  或者hugo  -D在public目录或者自定义的的docs目录生成静态网页文件，然后再执行
  
  `git add .`
  
  `git commit -m "updates $(date)"`
  
  `git   push  origin  `
  
  也可以把下面这几条命令写在批处理文件中，写完文档后直接运行这个批处理就可以完成发布，稍等使用`https://username.github.io/hugo`浏览最新发布的博客文章。
  ~~~
  hugo
  git   add  .
  git  commit -m  "updates $(date)"
  git push origin 
  ~~~
  
  

