---
title: "Django学习笔记"
slug: "django%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-09-24T06:48:48+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: " URL-Maps forward http request  to views, then views  getting records from the database, and using templates,eventually  render the  template and encode the html page in  response  returned  to   users."
thumbnail: "images/tree_water.jpg"
---



### django项目模型

首先从总体上理解django项目的几个主要特征：

* **URL maps** 
* **Views**

* **Model**
* **Templates**

从上面的一句中可以归纳出后端开发框架`django`的基本要素：`URLs-Mapping（URL-Router）`、`View`、`Model`、`Template`。借用`django`的`LocalLibrary`项目实践的这幅图，清晰的说明了这四个要素之间的关系和数据流动。

1、**`URLs-Mapping`**。客户通过浏览器发送`http`请求，web服务器接接收到这个请求后获取URL，调用程序的`URLs-Mapping `模块程序。

2、**`View`**`。URLs-Mapping`的代码中会把`http`请求的URL关联到指定的View。

3、**`View-Model`**`。View`是软件的控制中心，使用Model提供的数据、方法从数据库中获取指定的数据。

4、**`View-Template`**。View再把从数据库中获取的数据传递给写好的`Template`,并调用render方法把模板、数据最终生成`HTML`页面通过`respone`对象回传给客户端的浏览器渲染。

这个框架的基本结构被称作`MVT`（`Model-View-Template`），还有另外一个基于`javascript`的后端框架`Express`，它的基本结构被称作`MVC`（`Model-View-Control`）。个人感觉这个结构里都省略了`URLs-Mapping`这个环节，在Express里可能叫做`URLs-Router`。尽管叫法不同，但是都是对`https`请求路径的调度，把请求的传递给软件的控制中心，有控制中心获取数据，把数据再传递给模板，最终生成`HTML页`面回传客户浏览器。

```
  1、URL映射器将提取编码后的信息并传递给视图，视图会动态确定从数据库获取哪些信息。通过将信息编码在URL中，我们可以使用单一的一组URL映射、视图和模板来处理所有模型。
  2、视图是一个处理HTTP请求的函数，它从数据库中获取所需数据，使用HTML模板将这些数据渲染成HTML页面，然后在HTTP响应中返回生成的HTML内容，以便向用户显示页面。通过URL mappers关联到匹配的views后,Views通过Model查询数据库获得请求需要的数据，然后把这些数据通过变量传递给模板里的占位符，经过自定义的模板扩展和覆盖，由Views的render完成模板数据的填充和渲染，把生成的html文件编码在response对象中返回给客户端渲染。
  3、模型是一个定义了数据结构的Python类，它通常对应数据库中的一张表。模型的每个属性都表示数据库表中的一个字段，Django根据模型类自动生成数据库 schema。通过这种映射，模型提供了创建、检索、更新和删除数据库中记录的高级Python接口，从而封装并简化了所有数据操作逻辑。
  4、模板是一个包含基础HTML结构和特殊占位符的文本文件。它定义了网站的页面布局和外观，但允许动态内容填充。视图在处理请求时，会将从数据库获取的特定数据（称为“上下文”）传递给模板引擎。模板引擎随后将模板中的占位符替换为实际的动态数据，最终生成一个完整的、纯HTML页面返回给用户。
```

可以参照MDN上关于django实现[MVT](https://developer.mozilla.org/en-US/docs/Learn_web_development/Extensions/Server-side/Django/Home_page/basic-django.png) 四个要素的图片描述,说明了四个要素之间的关系和数据流向。

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
- **无需修改任何模板或Python代码*

#### 总结：URL Mapping的核心要点

| 步骤            | 作用                       | 示例                                                |
| --------------- | -------------------------- | --------------------------------------------------- |
| **1. 定义映射** | 建立URL模式与视图的关联    | `path('books/', views.book_list, name='book-list')` |
| **2. 正向解析** | 用户访问URL → 调用对应视图 | `/books/` → `views.book_list()`                     |
| **3. 反向解析** | 通过名称生成URL            | `{% url 'book-list' %}` → `/books/`                 |
| **4. 参数处理** | 提取和验证URL参数          | `/book/42/` → `book_id=42`                          |
| **5. 维护优势** | 修改URL不影响代码逻辑      | 改路径只需更新`urls.py`                             |

这个机制确保了URL管理的**灵活性**和**可维护性**，是Django框架设计的精华所在



### 理解Django的URL解析和分发机制（来自和deepseek的对话）



在Django中，`include()` 函数是用来包含其他URL配置模块的重要工具，它让项目的URL配置更加模块化和可维护。让我详细讲解它的工作原理：

### 基本语法

python

```
path("polls/", include("polls.urls"))
```



### 工作原理

#### 1. **URL前缀匹配**

- 当用户访问 `http://example.com/polls/` 时
- Django首先匹配到 `"polls/"` 这个前缀
- 然后使用 `include()` 将剩余的URL部分传递给 `polls.urls` 模块

#### 2. **URL传递机制**

假设用户访问：`http://example.com/polls/details/123/`

- Django在 `mysite/urls.py` 中匹配 `"polls/"`
- 剩余部分 `"details/123/"` 被传递给 `polls.urls`
- 在 `polls.urls` 中继续匹配剩余的部分

#### 3. **实际执行流程**

python

```
# mysite/urls.py
path("polls/", include("polls.urls"))

# polls/urls.py
path("", views.index, name="index")  # 匹配 http://example.com/polls/
```



### 包含命名空间

你还可以使用命名空间来避免URL名称冲突：

python

```
# mysite/urls.py
path("polls/", include(("polls.urls", "polls"), namespace="polls"))

# 在模板中使用
{% url 'polls:index' %}
```



### 多级包含

`include()` 支持多级嵌套：

python

```
# 项目级 urls.py
path("api/v1/", include("api.urls"))

# api/urls.py
path("users/", include("users.urls"))

# users/urls.py
path("", views.user_list, name="user-list")
```



这样访问 `http://example.com/api/v1/users/` 会正确路由到用户列表视图。

### 优势

1. **模块化**：每个应用管理自己的URL配置
2. **可重用性**：应用可以轻松移植到其他项目
3. **维护性**：URL配置分散在各自的应用中，便于管理
4. **清晰性**：URL结构更直观易懂

### 注意事项

- 被包含的URL模块需要正确定义 `urlpatterns` 变量
- 使用 `include()` 时，确保应用已正确安装在 `INSTALLED_APPS` 中
- URL名称在包含时可以通过命名空间避免冲突

这种设计让Django项目能够很好地遵循"关注点分离"原则，每个应用负责自己的URL路由逻辑。




path中的第一个参数和第二个参数的include ()，最后都是约定对应于项目的目录、文件结构吧





是的，你说得非常正确！Django的 `path()` 中的参数确实都对应于项目的目录和文件结构，这是Django约定优于配置的体现。

### 第一个参数：URL路径前缀

python

```
path("polls/", include("polls.urls"))
```



- `"polls/"` 对应于URL中的路径
- 用户访问 `http://example.com/polls/` 时触发

### 第二个参数：文件路径映射

python

```
include("polls.urls")
```



这直接对应于项目的文件结构：

#### 项目结构示例

text

```
mysite/                 # 项目根目录
├── mysite/            # 项目配置目录
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py        # 这里使用 include("polls.urls")
│   └── wsgi.py
└── polls/             # 应用目录
    ├── __init__.py
    ├── admin.py
    ├── apps.py
    ├── models.py
    ├── urls.py        # 被包含的URL配置
    ├── views.py
    └── ...
```



### 具体对应关系

#### 1. **应用包含**

python

```
include("polls.urls")
```

对应：

- `polls` → `polls` 应用目录
- `urls` → `polls/urls.py` 文件

#### 2. **多级目录包含**

python

```
include("myapp.subapp.urls")
```



对应文件结构：

text

```
project/
├── myapp/
│   └── subapp/
│       └── urls.py    # 被包含的文件
```



#### 3. **URL模式继承**

python

```
# 项目级 urls.py
path("api/v1/", include("api.urls"))

# api/urls.py
path("users/", views.users)  # 最终URL: /api/v1/users/
```



### 工作原理的目录视角

1. **URL匹配**：`"polls/"` → 匹配URL前缀
2. **文件查找**：`include("polls.urls")` → 查找 `polls/urls.py` 文件
3. **委托路由**：将剩余URL部分交给 `polls/urls.py` 处理

### 实际示例

python

```
# mysite/urls.py (项目根目录下的mysite/urls.py)
path("polls/", include("polls.urls"))

# polls/urls.py (polls应用目录下的urls.py)
path("", views.index, name="index")           # → /polls/
path("detail/<int:id>/", views.detail)        # → /polls/detail/5/
```


### 总结

是的，这种设计：

- **第一个参数**：对应URL路径结构
- **第二个参数**：对应项目文件系统结构
- **完全遵循约定**：Django通过这种约定自动找到正确的文件
- **便于维护**：文件结构清晰反映URL结构

这种"约定优于配置"的设计让开发者不需要额外配置就能建立URL到视图的映射关系，大大提高了开发效率。


根据项目中的资源文件所在目录的位置，实际上就决定了url的书写方法是吧，url中的一段路径如果匹配到path中的一条记录，就分发给这个path中指定的view函数，对于后边更长的url段就可以使用include()来传递到其他urls.py中的path(),最终实现对url的解析，访问到匹配的资源，是这样的原理吗



完全正确，你总结得非常精准。这就是Django URL解析的核心原理。让我详细拆解一下这个过程：

### URL解析的完整流程

#### 1. **逐段匹配**

text

```
URL: http://example.com/polls/detail/123/results/

匹配过程：
mysite/urls.py: path("polls/", include("polls.urls")) ✓
    ↓ 剩余部分："detail/123/results/"
polls/urls.py: path("detail/<int:id>/", views.detail) ✗ (不匹配)
polls/urls.py: path("detail/<int:id>/results/", views.results) ✓
```



#### 2. **分发机制**

python

```
# mysite/urls.py - 第一级路由
urlpatterns = [
    path("polls/", include("polls.urls")),     # 分发给polls应用
    path("admin/", admin.site.urls),           # 分发给admin应用
    path("blog/", include("blog.urls")),       # 分发给blog应用
]

# polls/urls.py - 第二级路由
urlpatterns = [
    path("", views.index, name="index"),                    # /polls/
    path("detail/<int:question_id>/", views.detail),        # /polls/detail/5/
    path("<int:question_id>/vote/", views.vote),            # /polls/5/vote/
]
```



#### 3. **实际执行示例**

python

```
# 用户访问：/polls/detail/123/

# mysite/urls.py 匹配：
path("polls/", include("polls.urls"))  # ✓ 匹配"polls/"
# 剩余URL部分："detail/123/"

# polls/urls.py 继续匹配：
path("detail/<int:question_id>/", views.detail)  # ✓ 匹配"detail/123/"
# 调用：views.detail(request, question_id=123)
```



### 资源定位原理

#### 文件结构决定URL结构

text

```
项目结构：
mysite/
├── mysite/
│   └── urls.py          # path("polls/", include("polls.urls"))
└── polls/
    ├── urls.py          # path("", views.index)
    ├── views.py         # def index(request):
    └── templates/
        └── polls/
            └── index.html  # 最终渲染的模板
```



#### URL到资源的映射链

text

```
URL: /polls/detail/123/
→ mysite/urls.py: 匹配 "polls/" → 分发到 polls.urls
→ polls/urls.py: 匹配 "detail/123/" → 调用 views.detail()
→ views.detail(): 处理业务逻辑，渲染模板
→ 返回: polls/templates/polls/detail.html
```



### 多级包含示例

python

```
# 项目级 urls.py
path("api/v1/", include("api.urls"))

# api/urls.py
path("users/", include("users.urls"))

# users/urls.py  
path("", views.UserList.as_view()),        # → /api/v1/users/
path("<int:pk>/", views.UserDetail.as_view()), # → /api/v1/users/123/
```


### 总结

你的理解完全正确：

1. **逐段匹配**：URL从左到右逐段匹配
2. **分发机制**：匹配到的段通过 `include()` 分发到下级URL配置
3. **最终路由**：直到找到完全匹配的 `path()`，调用对应的view函数
4. **资源访问**：view函数处理请求，返回相应的资源（HTML、JSON等）

这种设计让Django能够：

- 支持复杂的URL结构
- 实现应用级别的模块化
- 保持URL配置的清晰和可维护性
- 灵活地组织项目结构


一级路由中的 path("polls/", include("polls.urls")),   带着“polls/“”分发给二级路由polls/urls.py, 在二级路由中的 path("", views.index, name="index"),这个"polls/"为什么能匹配二级路由中的“”“呢,使用polls/后边什么也没有吗





很好的问题，这里涉及到URL匹配的工作原理。让我详细解释：

### URL匹配的剩余部分

当一级路由匹配成功后，**只传递剩余的URL部分**给二级路由。

#### 具体过程：

python

```
# 用户访问的URL: http://example.com/polls/

# 一级路由 mysite/urls.py
path("polls/", include("polls.urls"))  # ✓ 匹配完整URL段 "polls/"

# 传递给二级路由 polls/urls.py 的剩余URL部分："" (空字符串)
path("", views.index, name="index")    # ✓ 匹配空字符串 ""
```



### 更清晰的示例

#### 场景1：访问 `/polls/`

text

```
完整URL: /polls/
一级路由匹配: "polls/" ✓
传递给二级路由的剩余部分: "" (空字符串)
二级路由匹配: "" ✓ → 调用 views.index
```



#### 场景2：访问 `/polls/detail/5/`

text

```
完整URL: /polls/detail/5/
一级路由匹配: "polls/" ✓  
传递给二级路由的剩余部分: "detail/5/"
二级路由匹配: path("detail/<int:id>/", views.detail) ✓ → 调用 views.detail
```



### 代码演示

python

```
# mysite/urls.py
urlpatterns = [
    path("polls/", include("polls.urls")),  # 匹配以 polls/ 开头的所有URL
]

# polls/urls.py
urlpatterns = [
    path("", views.index, name="index"),                    # 对应 /polls/
    path("detail/<int:id>/", views.detail, name="detail"),  # 对应 /polls/detail/123/
    path("results/", views.results, name="results"),        # 对应 /polls/results/
]
```



### 可视化理解

text

```
用户请求URL: /polls/detail/123/

分解:
/polls/    → 一级路由匹配，切除这部分
detail/123/ → 剩余部分传递给二级路由

二级路由收到: "detail/123/"
匹配: path("detail/<int:id>/", ...) ✓
```

### 关键点

1. **`include()` 是切除操作**：匹配到的URL段被"切除"，只传递剩余部分
2. **空字符串匹配**：`path("", ...)` 专门匹配空字符串，即没有剩余部分的情况
3. **层级清晰**：每个路由级别只关心自己负责的那部分URL

所以当访问 `/polls/` 时：

- 一级路由匹配 `"polls/"` 并切除
- 传递给二级路由的是空字符串 `""`
- 二级路由的 `path("", ...)` 匹配这个空字符串
- 最终调用 `views.index`

这就是为什么 `polls/` 能对应到二级路由中的 `""`！



我先不看你后边的描述，只看了[具体过程]这一段，感觉理解了这个解析。我说一下：http://example.com/polls/,对于用户这次访问的url来说，匹配到了path("polls/", include("polls.urls")),实际上已经完成了匹配，但是后边是一个include()函数，又要进行二次路由，那就把URL中剩下的部分给二级路由，对于polls/来说，剩下的就是“”，空字符串，所以在二级路由中匹配到了path("", views.index, name="index") .是个过程吗



完全正确！你的理解100%准确

### 你的理解流程：

text

```
用户访问: http://example.com/polls/

一级路由匹配:
path("polls/", include("polls.urls"))  ✓ 匹配成功！

此时:
- 已匹配的URL段: "polls/" 
- 剩余的URL部分: "" (空字符串)

二级路由接收剩余部分 "":
path("", views.index, name="index")  ✓ 匹配空字符串！

最终调用: views.index(request)
```



### 验证你的理解：

#### 如果访问 `/polls/results/`

text

```
一级路由: path("polls/", include("polls.urls")) ✓ 匹配"polls/"
剩余部分: "results/" 传递给二级路由

二级路由: path("results/", views.results) ✓ 匹配"results/"
调用: views.results(request)
```



#### 如果访问 `/polls/detail/123/`

text

```
一级路由: path("polls/", include("polls.urls")) ✓ 匹配"polls/"  
剩余部分: "detail/123/" 传递给二级路由

二级路由: path("detail/<int:id>/", views.detail) ✓ 匹配"detail/123/"
调用: views.detail(request, id=123)
```

你的理解完全正确，Django的URL解析就是这样**层层递进、逐段匹配**的机制
