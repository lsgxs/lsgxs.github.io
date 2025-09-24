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



### URL Mapping

#### 项目结构示例

text

```
myproject/
    📁 bookstore/
        📄 views.py       # 视图函数
        📄 urls.py        # URL配置
        📁 templates/     # 模板文件
```



#### 1. 定义阶段：建立URL映射

##### 📄 bookstore/views.py

python

```
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse

def home(request):
    """首页视图"""
    return HttpResponse("欢迎来到书店首页！")

def book_list(request):
    """图书列表视图"""
    return HttpResponse("这里是所有图书列表")

def book_detail(request, book_id):
    """图书详情视图"""
    return HttpResponse(f"这是图书 {book_id} 的详情页面")

def search_books(request, category, keyword):
    """搜索图书视图"""
    return HttpResponse(f"在 {category} 分类中搜索: {keyword}")
```



##### 📄 bookstore/urls.py

python

```
from django.urls import path
from . import views  # 导入当前目录的views模块

urlpatterns = [
    # 基本URL映射
    path('', views.home, name='home'),
    
    # 列表页面
    path('books/', views.book_list, name='book-list'),
    
    # 带参数的详情页面
    path('book/<int:book_id>/', views.book_detail, name='book-detail'),
    
    # 多个参数的复杂URL
    path('search/<str:category>/<slug:keyword>/', views.search_books, name='book-search'),
]
```



#### 2. Django内部建立的映射表

python

```
# 概念上的内部数据结构
URL_MAPPINGS = {
    'home': {
        'pattern': '',
        'view': views.home,
        'parameters': []
    },
    'book-list': {
        'pattern': 'books/',
        'view': views.book_list, 
        'parameters': []
    },
    'book-detail': {
        'pattern': 'book/<int:book_id>/',
        'view': views.book_detail,
        'parameters': ['book_id']
    },
    'book-search': {
        'pattern': 'search/<str:category>/<slug:keyword>/',
        'view': views.search_books,
        'parameters': ['category', 'keyword']
    }
}
```



#### 3. 用户访问流程（正向解析）

##### 场景1：用户访问首页

text

```
用户输入URL: http://example.com/

Django处理流程:
1. 收到请求路径: ""
2. 匹配URL模式: path('', ...) ✓ 匹配成功
3. 调用对应视图: views.home(request)
4. 返回响应: "欢迎来到书店首页！"
```



##### 场景2：用户访问图书详情

text

```
用户输入URL: http://example.com/book/42/

Django处理流程:
1. 收到请求路径: "book/42/"
2. 匹配URL模式: path('book/<int:book_id>/', ...) ✓ 匹配成功
3. 提取参数: book_id = 42 (自动转换为整数)
4. 调用视图: views.book_detail(request, book_id=42)
5. 返回响应: "这是图书 42 的详情页面"
```



#### 4. 模板中使用（反向解析）

##### 📄 templates/[base.html](https://base.html)

html

```
<!DOCTYPE html>
<html>
<head>
    <title>书店</title>
</head>
<body>
    <nav>
        <!-- 使用名称生成URL -->
        <a href="{% url 'home' %}">首页</a>
        <a href="{% url 'book-list' %}">所有图书</a>
        
        <!-- 带参数的URL -->
        <a href="{% url 'book-detail' book_id=42 %}">查看图书42</a>
        
        <!-- 多个参数的URL -->
        <a href="{% url 'book-search' category='fiction' keyword='django' %}">
            搜索小说类Django相关书籍
        </a>
    </nav>
    
    {% block content %}{% endblock %}
</body>
</html>
```



##### 渲染后的HTML结果：

html

```
<a href="/">首页</a>
<a href="/books/">所有图书</a>
<a href="/book/42/">查看图书42</a>
<a href="/search/fiction/django/">搜索小说类Django相关书籍</a>
```



#### 5. Python代码中使用反向解析

##### 📄 bookstore/views.py

python

```
from django.urls import reverse
from django.shortcuts import redirect

def some_view(request):
    # 在Python代码中生成URL
    home_url = reverse('home')  # 返回: "/"
    book_list_url = reverse('book-list')  # 返回: "/books/"
    
    # 带参数的反向解析
    book_detail_url = reverse('book-detail', kwargs={'book_id': 42})  # 返回: "/book/42/"
    
    # 重定向到其他页面
    return redirect('book-list')  # 直接使用名称重定向
```



#### 6. 修改URL时的优势

##### 修改前：

python

```
# 旧URL配置
path('all-books/', views.book_list, name='book-list')
```



##### 修改后：

python

```
# 新URL配置（业务需求变更）
path('books-collection/', views.book_list, name='book-list')
```



**自动更新效果：**

- 所有`{% url 'book-list' %}`自动生成`/books-collection/`
- 所有`reverse('book-list')`自动返回`/books-collection/`
- **无需修改任何模板或Python代码！**

#### 总结：URL Mapping的核心要点

| 步骤            | 作用                       | 示例                                                |
| --------------- | -------------------------- | --------------------------------------------------- |
| **1. 定义映射** | 建立URL模式与视图的关联    | `path('books/', views.book_list, name='book-list')` |
| **2. 正向解析** | 用户访问URL → 调用对应视图 | `/books/` → `views.book_list()`                     |
| **3. 反向解析** | 通过名称生成URL            | `{% url 'book-list' %}` → `/books/`                 |
| **4. 参数处理** | 提取和验证URL参数          | `/book/42/` → `book_id=42`                          |
| **5. 维护优势** | 修改URL不影响代码逻辑      | 改路径只需更新`urls.py`                             |

这个机制确保了URL管理的**灵活性**和**可维护性**，是Django框架设计的精华所在

