---
title: "自定义typora"
date: 2024-02-20T10:58:20+08:00
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

#### 根据自己偏好设置TypOra外观

Typora使用主题github主题的引用块的颜色默认是灰色的，可以自定义引用块的左侧边框颜色和引用块文本颜色。

    点击左上角顶上的文件，点击`偏好设置`，选择`外观-主题`，打开`主题文件夹`,选择github.css文件，使用编辑器打开。找到`blockquote`

```
blockquote {
    #这里的solid #0ab812就是修改引用块左侧的边框颜色，根据自己偏好设置为指定的颜色 
    border-left: 4px solid #0ab812;
    padding: 0 15px;
    # 这里的color是引用块的文本颜色设置
    color: #777777;
}
```

