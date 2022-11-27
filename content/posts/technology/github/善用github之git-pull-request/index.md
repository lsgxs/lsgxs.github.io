---
title: "善用github之git Pull Request"
date: 2022-11-27T16:36:14+08:00
draft: false
tags: ["pull request","github"]
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
cover:
  image: "images/神奇的树叶.jpg" 
---

#### 善用GitHub之Pull Request

在github上托管自己的静态博客，从知道github的存在到现在博客的托管，摸索着进步。毕竟只是自己的爱好，没有真实的项目打底，没有复杂的应用，只是一些简单的github操作，实在不行就把仓库delete，重新git-add-commit-push。还从来没有过pull request操作，只是大概知道这个代码协作的功能。为了实现PaperMod的一个[cover image作为缩略图放置在文档条目右侧的炫酷效果](https://www.sulvblog.cn/posts/blog/),开启了PaperMode学习，感谢sulv大佬的博客文章。

##### 文档目录放置在左侧

实现了cover image作为缩略图放置在博客文章条目右侧之后，默认的PaperMod目录是放置在文章顶部，对于篇幅长一点文档，目录和内容之间切换不方便。跟着sulv大佬的文档做，但是没有直接拉取他的仓库主题，主要是对PaperMode的结构不熟悉，对各种自定义的模板不熟悉，实现不了这个目录居左边的功能。搜索到一个博主的文章(感谢这位博主的文章，这里贴上文章的链接，提到了这个[目录侧边化](https://mclsk888.top/posts/%E5%8D%9A%E5%AE%A2%E6%90%AD%E5%BB%BA/hexo%E8%BF%81%E7%A7%BBhugo/#%E7%9B%AE%E5%BD%95%E4%BE%A7%E8%BE%B9%E5%8C%96))。找到[Toc on the side](https://github.com/adityatelange/hugo-PaperMod/pull/675)的Pull request，实现了目录放置在侧边栏的功能。摸索着发现了Files Changed的图标，点击后发现了最有价值的地方，红绿两色、加加减减，忽然意识到这里已经给你说明了那些删除的，哪些是增加的。如果你有足够的耐心，可以照着文件的变化修改你的文档。另一个更好的方法就是找到提交者的仓库，直接下载仓库，把Files Changed标注的文件复制到自己博客项目里对应的目录，覆盖原文件，就可以实现目录侧边放置的效果。

![](images/git-pull-requests-files-changed.png)

##### 用自己的项目实践Pull request

看到了通过一个完整的pull request就可以在github上查看修改明细，修改了哪几个文件，每个文件修改了什么内容，通过在编辑框左边显示+或者-号表示增加或者删除（大概是这意思，我猜测，看官方文档再下结论吧）。把sulv大佬帮我修改的博客项目（实现另外一个功能，在代码区显示纵向的滚动条）作为一个修改后的commit ，推送到我fork自己的整个博客项目，重要看到自己想要的结果了，直接显示了修改了哪几个文件，修改了什么地方，对照整个清单把原来的文件修改好，localhost:1313测试成功。

* 首先把自己的未经修改的博客项目推送到username.github.io仓库
* 用自己另外一个github账户的登录，fork第一个账户的博客项目仓库
* 把大佬帮助修改好的仓库项目修改origin 链接，指向第二个github账号fork的仓库。（其实修改的项目已经可以使用，只是我好奇到底是怎么修改的^-^）
  * git remote remove  origin 
  * git remote add origin git@hexo:username/fork-repository-name.git 
  * git add-commit-push --这里是几个步骤的简写。
  * 到这里就可以看到那个pull request的清单了。没有帮助别人修改项目的技术，只能在自己的项目上学习一下，也挺好。初学pull request，一点点成就感，所有的进步不就是这些成就感驱动的吗？继续前进，做自己喜欢的事情，坚持下去。

* 当然，自己对github、request的认识还很肤浅，有多大的需求，才有多么复杂的项目，才会有更多一点的知识，如果能从众多的知识中再抽象出一点智慧，那就又进步了一点^-^。

* 学习html+css+javascrtpt的基础知识，然后搞懂一个实际的项目才能不断进步。

