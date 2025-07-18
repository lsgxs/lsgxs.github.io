---
title: "ExampleSite"
date: 2022-11-18T23:06:19+08:00
draft: false
showToc: true # 显示目录
TocOpen: true # 自动展开目录
hidemeta: false # 是否隐藏文章的元信息，如发布日期、作者等
disableShare: true # 底部不显示分享栏
showbreadcrumbs: true #顶部显示路径
cover:
    image:  "images/冰山.jpg"   
    caption: "冰山一角" #图片底部描述
    alt: "^-^"
    relative: false
---

#### 关于Themes中自带ExampleSite的使用方法

* 学习一个新的hugo博客站点主题，可以使用主题中自带的ExampleSite站点

```
$ mkdir your-site
$ cd your-site
$ mkdir themes
$ cd themes
$ git clone https://github.com/repository-url.git
$ cp -r themes-name/exampleSite/** ../    --把ExampleSite站点目录下的所有内容复制到你的站点根目录
$ cd ..
$ hugo serve   
```

* 如果你的站点已经是一个git 仓库项目了，可以使用git submoudle 的方法添加这个主题。

```
 git submodule add https://github.com/repository-name   themes/theme-name
 hugo serve -t  hugo-theme-name
 http://localhost:1313                 
```

![](images/云山雾绕.jpg)

