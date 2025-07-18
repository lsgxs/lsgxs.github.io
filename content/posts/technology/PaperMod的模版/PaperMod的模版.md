---
title: "设置post模版"
date: 2022-11-15T11:30:03+00:00
# weight: 1
# aliases: ["/first"]
tags: ["first"]
author: "Me"
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
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: false
ShowCodeCopyButtons: true
cover:
    image: "云山雾绕.jpg"    
---

#### 如何设置post模版

* 首先在archetypes目录下新建名称为post.md的文档，文件内容如下所示。新建post.md，复制下面的内容到post.md并保存。

~~~
---
title: "My 1st post"
date: 2020-09-15T11:30:03+00:00
# weight: 1
# aliases: ["/first"]
tags: ["first"]
author: "Me"
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
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
editPost:
    URL: "https://github.com/<path_to_repo>/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---
~~~

#### 新建MarkDown文档时如何使用post模版

* hugo new --kind  post   posts/使用post模板新建文档.md

* You can use it by creating `archetypes/post.md`

  在archetypes/post.md文件里，front matter区域的参数设置作为post类的模板，以后新建post时使用下面这个格式：

  ```shell
  hugo new --kind post <name>
  ```

  比如： `hugo  new  --kind  post  posts/my-first-post.md`

  其实还有一个方法，就是把这个作为模板的post.md下的front-matter区域的参数，挑选自己常用的项目，复制在archetypes/default.md同样的位置，以后新建文档直接使用`hugo new  posts/dirname/index.md`,有空可以测试一下，可以先测试每个config.yml的参数，弄清楚参数的作用之后，可以根据自己的习惯自定义一个front matter参数模板，然后直接修改archetypes/下的default.md文档试试，要不然每次新建post都要使用`hugo new --kind post posts/xxxx.md`


![](云山雾绕.jpg)