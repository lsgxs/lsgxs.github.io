---
title: "Hugo Post中的图像资源引用方法"
date: 2022-11-01T22:04:29+08:00
draft: false
featured_image: "images/冰山.jpg"
---

#### 在hugo的post中如何引用图片

* 第一个引用图片的位置是在文章的front matter区域，一般使用`featured_image: "images/xxx.png"`

  * 这个图片默认显示在文章的左边，相当于一个缩略图，装饰作用。

  * 在这个位置显示的图片，如果在static目录下建立images目录保存引用的图片的话，发布到github的username.github.io时，却因为无法找到文件而不能渲染。以文章名字新建目录，然后在这个目录下修改markdown文档的名字为index.md，在同级别的目录下新建一个image目录，用来保存在front matte区域显示的缩略图图片。目录结构如下

    ~~~
       1+----Hugo-Post中的图像资源引用方法    以文档的名字作为目录名新建目录 
         2+----image
           3+----冰山.png
         2+----index.md                   
        上面的1、2、3代表3个层级,在index.md内用image/冰山.png的格式引用图片，index.md与image目录同级，直接引用就可以了。 
     hugo new posts/文档的名字-保持目录名字不能有空格/index.md 
    ~~~
    
    

* 第二个引用图片的位置是在正文区域，一般使用`![](/images/xxx.png)`

  * 这个位置引用的图片可以在static目录下新建一个images目录，在images目录下保存要引用的图片。

