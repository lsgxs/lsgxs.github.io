---
title: "Getting Started With Web"
date: 2023-08-13T12:14:15+08:00
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
thumbnail: "images/LeanrWeb.png"
description: "当前Web应用的架构模式,主要是前端的html+css+javascript构建前端界面，通过WEB服务器（Apache等）和MySQL等系列的数据库打交道，形成基于Web的数据库应用。可以把自己的web项目部署到web服务器的目录下，当用户通过浏览器发送请求时，后端的Web服务器在自己的webapps目下加载web应用的网页。访问和操作数据库的逻辑都是封装在web服务器端。"   
---

#### HTML

HyperText  Markup  Language ,用标签表示的的Element来结构化网页。常见的标签表示元素有

~~~html
<html>   </html>
<head>   </head>
<body>   </body>
<h1>    </h1>
<p>     </p>    --paragraph
<table>  </table>
  <tr>   </tr>
  <th>   </th>
  <td>   </td>
<form>  </form>
  <lable>
  <input  type="text">
  <input   type="checkbox">
  <input  type="button">
 ... 

~~~

#### CSS

##### Casecade  Style  Sheet的主要两个功能：

* Style  Html  Element 

* UI  Layout 

  HTML页面上的每一个Element都是一个盒子，基于盒模型进行页面布局。
  
##### HTML  Element  Selector的几种写法

* 直接书写HTML元素的名称

  ~~~
  p {
    color: green;
  }
  h1{
    color: blue;
    font-size: 5em;
  
  }
  ~~~

* 类名

  * tagname.classname    
  * .classname

* ID 

* 包含标签的选择符，用空格隔开标签。比如在`<p>    </p>`  中包含了`<a>  </a>`标签，就可以用

  ~~~
  p a  {
     color:blue;
     font-sieze: 6em;
  }
  ~~~
  
* 共享一个装饰风格的多个不同标签

  ~~~
  h1,p,a{
   font-size: 10em;
   color:  green;
  }
  ~~~
* 其他的多种写法（查询相关文档）
#### JAVASCRIPT

通过向HTML文件中添加`<script>  </script>`javascript代码，可以创建动态网页。比如从后台数据库获取数据，和少量的HTML静态网页模板一起就可以维护大量数据的动态网页。

#### Apply  CSS and JavaScript  to   web  page

​    two   paragraphs below  about  css and javascript  loaded in HTML file are  from  [MDN](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/The_head_metadata_in_HTML#applying_css_and_javascript_to_html)

​    Use CSS to make webpage look cool, and JavaScript to power interactive functionality, such as video players, maps, games, and more。 These are most commonly applied to a web page using the `<link>` element and the `<script>` element, respectively.

The `<link>` element should always go inside the head of your document. This takes two attributes,	`rel="stylesheet"` , which indicates that it is the document's stylesheet, and `href`, which contains the path to the stylesheet file:    

```html
<link rel="stylesheet" href="my-css-file.css" />
```

The `<script>` element should also go into the head, and should include a `src` attribute containing the path to the JavaScript you want to load, and `defer`, which basically instructs the browser to load the JavaScript after the  page has finished parsing the HTML. This is useful as it makes sure that the HTML is all loaded before the JavaScript runs, so that you don't  get errors resulting from JavaScript trying to access an HTML element  that doesn't exist on the page yet. There are actually a number of ways  to handle loading JavaScript on your page, but this is the most reliable one to use for modern browsers 。

~~~html
<script src="my-js-file.js" defer></script>
~~~

#### 当前Web应用的架构模式

前端的html+css+javascript，后端的WEB服务器（Apache等），还有MySQL等系列的数据库。可以把自己的web项目部署到web服务器的目录下，当用户通过浏览器发送请求时，后端的Web服务器在自己的webapps目录（这里只是举例，可以是其他名称的目录）下加载web应用的网页。

在html文件中包含有javascript文件时，后台的web服务器直接回传到前端，浏览器会解释这些javascript文件，不需要后台web服务器处理，因为大多数浏览器自带javascript解释引擎，浏览器可以直接解释处理javascript脚本。如果html文件中包含有jsp、php等脚本文件时，则需要有后台的web服务器调用相关的脚本文件解释器处理。后端的web应用大多数遵循MVC架构，这些jsp、php脚本经常是需要和后台的数据库打交道，把计算完毕的数据返回到客户端。
