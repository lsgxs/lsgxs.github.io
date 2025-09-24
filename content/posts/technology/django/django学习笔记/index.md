---
title: "Django学习笔记"
slug: "django%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-09-24T06:48:48+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: " we'll gain practical experience in writing basic URL maps and views, getting records from the database, and using templates. "
thumbnail: "images/django.png"
---



### django项目的基本结构





![img](images/django.png)

 we'll gain practical experience in writing **basic URL maps and views, getting records from the database, and using templates**.

从上面的一句中可以归纳出后端开发框架`django`的基本要素：`URLs-Mapping（URL-Router）`、`View`、`Model`、`Template`。借用`django`的`LocalLibrary`项目实践的这幅图，清晰的说明了这四个要素之间的关系和数据流动。

1、**`URLs-Mapping`**。客户通过浏览器发送`http`请求，web服务器接接收到这个请求后获取URL，调用程序的`URLs-Mapping `模块程序。

2、**`View`**`。URLs-Mapping`的代码中会把`http`请求的URL关联到指定的View。

3、**`View-Model`**`。View`是软件的控制中心，使用Model提供的数据、方法从数据库中获取指定的数据。

4、**`View-Template`**。View再把从数据库中获取的数据传递给写好的`Template`,并调用render方法把模板、数据最终生成`HTML`页面通过`respone`对象回传给客户端的浏览器渲染。

这个框架的基本结构被称作`MVT`（`Model-View-Template`），还有另外一个基于`javascript`的后端框架`Express`，它的基本结构被称作`MVC`（`Model-View-Control`）。个人感觉这个结构里都省略了`URLs-Mapping`这个环节，在Express里可能叫做`URLs-Router`。尽管叫法不同，但是都是对`https`请求路径的调度，把请求的传递给软件的控制中心，有控制中心获取数据，把数据再传递给模板，最终生成`HTML页`面回传客户浏览器。

```
The URL mapper will extract the encoded information and pass it to the view, and the view will dynamically determine what information to get from the database. By encoding the information in the URL we will use a single set of a URL mapping, a view, and a template to handle all books (or authors).
```

```
A view is a function that processes an HTTP request, fetches the required data from the database, renders the data in an HTML page using an HTML template, and then returns the generated HTML in an HTTP response to display the page to the user.
```

```
Along the way we learned fundamental information about URL mappers, views, querying the database with models, passing information to a template from a view, and creating and extending templates.
```

### `MVT`结构中的难点

传统上基于数据操作的应用程序都是直接使用`SQL`语言实现对数据库的建增删查改（crud），但是现在的后端框架是在数据库之上又加了一层应用，程序不是直接使用`SQL`语言提交给数据库完成数据的操作，而是用框架自己的编程语言建立了库，实现两个层面的工作，一个底层的数据库驱动库，一个是面向编程开发的API，开发者可以通过调用API，让开发者不必去关心特定的数据库特性，用python的面向对象技术实现对数据库的操作，这些封装模型在django中称为`Model`。从django和数据库交互的方式来看，这个模型叫做`ORM`,`object relation  model`。具体的细节可以进一步扩展学习。

从概念上习惯了`SQL`语言的操作方法，增删改查的四个类型简单明了，你的极限只在于你对复杂`SQL`语言的掌控和灵活运用，但是这个`ORM`又多了一层概念，只有通过项目实践才能理解并熟练运用。

