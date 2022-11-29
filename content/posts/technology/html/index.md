---
title: "Html简要学习笔记"
date: 2022-11-28T22:04:58+08:00
draft: false
# weight: 2
tags: ["first"]
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

#### html发展历史

#### URL

#### 熟悉html文件基本结构，在记事本手动写一个完整准确的html代码框架。
~~~html
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <title>This is the title of page"</title>
    </head>
    <body>
        <header> the header </header>
             <main> 
                 <article>
                   <p> a paragraph </p>
                 </article>
            </main>

        <footer> the footer </footer>
   </body>
</html>

~~~
  可以看出，通过对文档结构化、对象化，实现一个文档的树状描述，为dom构建数据结构。从大到小的记忆这个文档结构：

* `<!DOCTYPE html>      `一条指令告诉浏览器这个文档的类型是html

* `<html> </html>`一对`html`标签作为整个文档元素的根,是网页中其他元素的容器。

* `<head> </head>`一对`<head>`标签作为html文档的头部，标签的内容不会显示在网页上，只是为浏览器网页渲染提供元数据。

  * `<head>`标签内可以容纳`<meta>`、`<style>`、`<script>`等元素

* `<body> </body>`一对`<body>`标签作为html文档的主体

  * 在`body`区域又可以分为`<header>`、`<main>`、`<footer>`三个部分,对应与日常编辑文档的页眉、正文、页脚。
  
* 简化一下结构： 
~~~html
    <!DOCTYPE html>
    <html lang="zh-CN">
      <head>
        <meta charset="utf-8" >
        <title> hello </title>
      </head>
    
      <body>
         <p> hello world!</p>
      <body>
    
    </html>
~~~

#### 常用html元素 

   * 文本类标签     
     * `<div>`  division
     * `<p>`   paragrahp
     * `<br>`  break 适用在一个段落内换行，段落之间的换行应该使用CSS完成。
     * `<span>`
     * `<pre>`、`<code>`
     
     ~~~html
        <pre>
        <code>
          let a = 1;
          console.log(a);
        </code>
        </pre>
     ~~~


   * 链接类标签
     
       `<a>`  常用的属性有href、download
       
       ~~~
       <a href="https://Username.github.io"> title </a>   
        文字超链接
        <a href="https://Username.github.io">
            <img src="bing/mountain-1.jpg" width=70 height=70>    
        </a>
        图片超链接，这里使用了<img>标签
        <a href="bing/mountain-1.jpg" download > DownLoadFile </a>
        文件下载
        代码中出现的引用资源的path，都是对这个html文件在文件系统中的路径的位置书写的。刚开始被网页中域名加路径的写法整蒙圈了，实际做个小博客或者文件下载的练习，慢慢明白了这些路径的写法及含义。域名是对远程主机的引用，相当于站点根目录，后边的路径就是文件系统的路径。
       
   * 邮件链接标签
     ~~~  html
        <a href="mailto:user-name@qq.com"> contact </a>
     
   * 电话链接标签
     ~~~html
     <a href="tel:12334567890"> 12334567890 </a>
     
   * `<link>`标签主要加载网页引用的外部资源，一般在html文件的`<head>`区域，常见的应用是加载当前html页面需要的CSS文件
     
        ~~~html
        <link rel="stylesheet" type="text/css" href="your-themes-file.css">
        ~~~
        
   * `<script>`标签，主要用来加载javascript文件。可以加载外部的js文件，也可以直接在标签中书写javascript代码。
     
     ~~~html
          <script src="javascript-filename.js"></script>
     
  * 图像类标签

  * 多媒体类标签

  * 列表类标签  (list)

     * ol    ordered list
     * ul    unordered list
     * li     list item

  *  表格类标签 （tabular）

  * 表单类标签（Form）

     ~~~html
        <form action="https://www.username.com" method="post">
           <label for="POST-name">username：</label>
          <input id="POST-name" type="text" name="user">
          <input type="submit" value="commit">
        </form>
     ~~~

  * lable

  * input  input标签有众多的类型，根据type的不同，提供了一组功能强大的表单交互组件。
    ~~~html
    <input type="text" id="name" name="name" required
            minlength="4" maxlength="8" size="10">
     <input type="image" alt="登陆" src="login-button.png">
    
  * button

