---
title: "Hugo建立博客系统"
slug: "hugo%E5%BB%BA%E7%AB%8B%E5%8D%9A%E5%AE%A2%E7%B3%BB%E7%BB%9F%E6%8C%87%E5%8D%97"
date: 2025-07-30T17:50:29+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
thumbnail: "images/create-site.png"
description: "这篇文档主要记录使用Hugo建立博客系统的详细步骤，主要内容包含下面6个主题。
1、使用Hugo轻松建立个人博客站点
2、博客站点目录详细介绍
3、博客站点的内容组织
4、Hugo博客系统是如何工作的
5、博客系统的部署
6、使用PaperMod主题 "
---

这篇文档主要记录使用Hugo建立博客系统的详细步骤，主要内容包含下面6个主题
```
1、使用Hugo轻松建立个人博客站点
2、博客站点目录详细介绍
3、博客站点的内容组织
4、Hugo博客系统是如何工作的
5、博客系统的部署
6、使用PaperMod主题
```

### 使用Hugo轻松建立个人博客站点

```
1、 建立站点
2、 添加文档 
3、 配置站点 
4、 发布站点 
```

在开始使用Hugo建立站点之前，需要做好两个准备工作：

* 安装Hugo 

  * **下载`hugo`**。在`github.com`上下载[`hugo`](https://github.com/gohugoio/hugo/releases/latest) 的对应操作系统版本，选择the extended  editions 就可以了。至于`extended/deploy`   editions多了发布到知名网站的功能：`Deploy your site directly to a Google Cloud Storage bucket, an AWS S3 bucket, or an Azure Storage container. `我这里最后发布到`github`,所以就不需要下载扩展/发布的版本了。
  * **安装`hugo`**。我这里使用的Windows平台，下载的`hugo`是一个单独的可执行文件，不需安装，只需把这个文件放置在自己指定的目录，然后把可执行文件所在目录的路径添加在`path`环境变量里，添加在用户环境变量或者系统环境变量都是可以的。

  * **测试`hugo`**。在git 还没有安装时，无法使用`git  bash`命令行终端，可以在`Windwos`自带的`CMD`命令行窗口使用`hugo  version`，能正常显示`hugo`版本号就说明安装好了。  

* 安装Git 

    到[git官网](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)下载对应操作系统版本的git安装就好。

####  建立站点

```bash
hugo  new  site  site-name  --format   yaml
cd  site-name   
git   init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
#如果没有带--format  yaml参数，默认生成的是hugo.toml参数，变量和数值之间使用等号`=`，而不是冒号`:`
echo "theme: 'ananke'" >> hugo.yaml
hugo  server
```

#### 新建文档

```bash
hugo  new content  content/posts/learnhugo.md

#等采用了branch  bundle和leaf bundle的方式组织站点目录之后，就可以使用下面的写法新建文档
hugo  new   posts/technology/learnhugo/index.md
```

这里使用最简单的默认文档模版。新建文档的模版保存在博客站点根目录下的`archetypes`目录下，新建站点的archetype目录下只有一个default.md文档，这个文档作为新建文档的front matter模版，保持最简单的title、date、draft三个文档元数据，对hugo越来越熟悉之后，就可以在archetypes目录下新建posts.md文件,添加一些类似category、tag、thumbnail、description等更加丰富的front matter元数据。

默认的文档front  matter如下所示：

```
+++
title = 'My First Post'
date = 2025-05-23T07:07:07+01:00
draft = true
+++
```

这里title是文档的标题，date是建立文档的日期，draft表示文档是否是草稿，在正式发布之前，把draft设置为true。

在这新建的Markdown文档的正文区加入一下测试内容并保存，然后运行hugo的服务器

```
# 这里的-D表示包含草稿，也就是draft=true的文档 
hugo  server -D 

```

此时就可以根据服务器的提示信息，在浏览器使用URL来浏览博客站点的第一个文档，浏览地址为默认的1313端口：`http://localhost:1313

#### 配置站点

博客站点根目录下的hugo.yaml，旧版本一般是config.yaml，不过两者都可以使用，推荐使用新版本的写法：hugo.yaml。配置文件在新建站点时默认为toml后缀，我这里使用`--format  yaml`参数指定新建站点时使用yaml格式的配置文件：hugo.yaml。下面是hugo.yaml文件的内容

```
baseURL：  'https://example.org/'
languageCode： 'en-us'
title： 'My New Hugo Site'
#新建站点时，只有前边三行数据，下面的主题设置需要手动添加
theme： 'ananke'
```

这里主要是最后一行的theme值，要把它设置为需要的主题，这里是参照hugo官方文档的初学教程，使用ananke主题。新建站点时，配置文件里只有前边三行数据，主题设置需要手动添加：`theme: ananke`，注意冒号后边一定要有一个空格，否则hugo编译时会提示错误信息。如果使用默认的toml格式配置文件，要使用`=`号而不是冒号`:`。

#### 发布站点

可以在git bash 终端使用`hugo `命令来发布博客站点，没错，就是一个什么参数都不带的hugo 命令，就也可以发布站点，hugo 会在根目录下创建public目录，然后把生成静态html文件，还有其他的图片、css文件等资源全部复制到public目录下。在浏览器输入`http://localhost:1313/`时，实际上打开的是public目录下的index.html文件。可以观察一下public目录下的所有子目录和文件。当然，这里的发布实际上是在站点根目录下新建一个public目录，在public目录下保存静态站点的所有资源。将来发布到github，原理是一样的，在github上的username.github.io仓库的gh-pages分支发布静态站点。

### 博客站点目录详细介绍

```
hugotest
├── └── .git          显示站点已使用git init初始化 
├── ├── .github
├── │   └── workflows   workflows目录用来保存自动发布的脚本文件，比如：deploy.yaml
├── ├── archetypes     archetypes目录用来保存新建文档的front  matter的模版，比如default.md 和posts.md，二者的优先级是自定义的posts.md优先，
├── ├── assets        assets目录用来保存css、javascript文件
├── │   └── css
├── ├── content       博客系统的内容都在content目录下保存
├── │   └── posts     markdown类型的文档都可以分类保存在posts目录下
├── ├── data          content/posts目录保存markdown类型的文档，data目录可以保存toml、yaml、json格式的文件，这些文件都是模板的数据源
├── ├── i18n
├── ├── layouts       layouts目录保存hugo站点的模板，下面的子目录保存hugo各种类型的模板，比如list.html、single.html等
├── │   ├── category
├── │   ├── section
├── │   └── _default
├── ├── public      public是hugo发布站点的目录，所有生成的图片、静态网页、css、javascript文件都在这里保存。
├── │   ├── about
├── │   ├── archives
├── │   ├── assets
├── │   ├── categories
├── │   ├── images
├── │   ├── links
├── │   ├── posts
├── │   ├── search
├── │   └── tags
├── ├── static     
├── │   └── images  static目录下的images用来保存站点共享的图片资源
├── └── themes  站点使用的主题 根据hugo对模板搜索优先级的规定，优先使用站点根目录下的layouts/下的各类模板，如果没有就使用主题的模板，最后是默认模板
├──     └── PaperMod
    └── hugo.yaml    站点的配置文件
```

下面这段代码是在windows下输出上边树形目录的代码，需要复制后粘贴在powershell里运行
```powershell
function Get-SimpleTree {
    <#
    .SYNOPSIS
        以树状结构显示目录内容（支持自定义深度和文件显示）。
    .PARAMETER Path
        要遍历的目录路径。
    .PARAMETER Depth
        递归深度（默认：2）。
    .PARAMETER ShowFiles
        是否显示文件（默认仅显示目录）。
    #>
    param (
        [string]$Path,          # 路径由外部输入，避免递归时重复弹窗
        [int]$Depth = 2,        # 默认递归深度
        [string]$Prefix = "",   # 缩进前缀（递归时使用）
        [switch]$ShowFiles      # 是否显示文件
    )

    # 检查路径是否存在
    if (-not (Test-Path $Path)) {
        Write-Host "错误：路径 '$Path' 不存在！" -ForegroundColor Red
        return
    }

    # 如果是根目录（递归起点），显示目录名并设置初始缩进
    if ($Prefix -eq "") {
        $root = Split-Path $Path -Leaf
        Write-Host $root -ForegroundColor Cyan
        $Prefix = "├── "  # 初始缩进符号
    }

    # 获取子项（根据 ShowFiles 参数决定是否包含文件）
    $items = if ($ShowFiles) { 
        Get-ChildItem $Path 
    } else { 
        Get-ChildItem $Path -Directory 
    }

    $count = $items.Count
    $i = 0

    # 遍历当前目录下的每一项
    $items | ForEach-Object {
        $i++
        $isLast = ($i -eq $count)  # 判断是否是最后一项（用于调整符号）
        $symbol = if ($isLast) { "└── " } else { "├── " }
        $line = $Prefix + $symbol + $_.Name
        Write-Host $line -ForegroundColor (Get-ItemColor $_)

        # 递归处理子目录（如果是目录且未达到深度限制）
        if ($_.PSIsContainer -and $Depth -gt 1) {
            $nextPrefix = if ($isLast) { "    " } else { "│   " }
            Get-SimpleTree -Path $_.FullName -Depth ($Depth - 1) -Prefix ($Prefix + $nextPrefix) -ShowFiles:$ShowFiles
        }
    }
}

# 辅助函数：根据文件类型返回颜色
function Get-ItemColor {
    param ($item)
    if ($item -is [System.IO.DirectoryInfo]) { "Green" }        # 目录显示绿色
    elseif ($item.Extension -match "\.(exe|bat|ps1)$") { "Yellow" } # 可执行文件显示黄色
    else { "Gray" }                                             # 其他文件显示灰色
}

# === 调用示例 ===
Write-Host "`n=== 目录树状图 ===" -ForegroundColor Magenta
$inputPath = Read-Host "请输入要遍历的目录路径（例如：C:\Windows 或 .\hugotest）"
Get-SimpleTree -Path $inputPath -Depth 2 -ShowFiles:$false
```

### hugo博客站点的内容组织

#### Page  Bundle 

A page bundle is a directory that encapsulates both content and associated resources。Page bundles are either *leaf bundles* or *branch bundles*

* **Leaf bundle** 

  A *leaf bundle* is a directory that contains an `index.md` file and zero or more resources. Analogous to a physical leaf, a leaf bundle is at the end of a branch. It has no descendants

  最后一层子目录就叫做leaf bundle;

* **Branch bundle **

  A *branch bundle* is a directory that contains an `_index.md` file and zero or more resources. Analogous to a physical branch, a branch bundle may have descendants including leaf bundles and other branch bundles. Top-level directories with or without `_index.md` files are also branch bundles. This includes the home page
  
  顶层目录和中间层的子目录叫作branch bundle。有`_index.md`文件`branch bundle`有`list page`,没有`_index.md`的`branch bundle`没有`list page`,只是在作为`url segment`出现，也就是路径中的一段显示。

这是官方文档的一部分，好好体会一下这几句话，就可以理解Hugo博客文档的目录组织结构了。以Posts\目录为例子

```
posts\

    +-----technology

       |--------+hugo                                      # branch  bundle

       |-------------+ learnhugo                                 #  leaf  bundle 

       |--------------------+images

       |--------------------------img1.jpg

       |--------------------------img2.jpg

       |--------------------index.md                   

       |--------+PaperMod                                 # branch  bundle                       

       | --------_index.md

    +-----------+economic                                 # branch  bundle 

        |------------+stock

        |------------+finace

        |------------_index.md 

    +-----------+read                                     # branch  bundle 

    ------------_index.md 


```

上面的目录结构是我的博客站点posts目录的一部分，是按照hugo的page  bundle逻辑结构组织的，posts/目录包含子目录technology、economic、read等，还包含一个`_index.md`文件，这个层级就是`branch  bundle`。`technology`目录下的`hugo`子目录也是一个包含`_index.md`文件和子目录的`branch bundle`。`hugo`目录下的子目录`learnhugo` 是一个包含`inde.md`和其他图片资源文件的`leaf bundle`。其他的economic、read等目录也是如此的组织结构，这样就形成了一个树状的`Page   Bundle`。在content目录下的文档就是hugo  模板系统的数据来源之一。目录结构和最后的站点渲染是对应的。

 ### Hugo博客系统是如何工作的

在了解hugo生成的站点的结构和目录之后，来探索一下hugo站点的不同部分是如何互相协作运转起来的。

作为输入端的content、data，content保存markdown文档，data目录保存toml|yaml|json|csv格式的文件，用来作为数据源，layouts下面的模版文件里的hugo  模版语言从这些数据源中读取数据，还有Assets、static这些保存css、images的静态资源文件，最后由hugo引擎分析编译这些模板文件，生成静态的网页文件保存在public目录下，同时把站点需要的各类资源都复制在public目录下，public目录就成为站点的根目录。最后可以在本地浏览这个public站点，也可以发布到远程的网络服务器，比如发布到github的Pages。这个过程里有两个重要的元素，一个是markdown的元数据，一个是Hugo模版语音的对象化封装，可以使用对象的方法和属性在模版文件里加工，最终输出到拥有界面的HTML文件里，由浏览器渲染后呈现。大致是这个流程，虽然有的地方不严谨，但是感觉理解了hugo的工作原理。

这是我自己的理解，我又整理一份文心一言给的文档，保存如下：

Hugo 站点工作原理与面向对象特性详解
一、Hugo 站点工作原理

1. 构建阶段：数据准备

    分析文件：

    ```
     content/ → Markdown/HTML → Page 对象
        config.toml → .Site 配置
        static/ → 静态资源（直接复制到 public/）
        layouts/ → 模板文件
        data/ → JSON/YAML/TOML → 自定义数据对象
    关键数据结构：
        .Site：全局站点（配置、页面列表、菜单等）
        .Page：单页面（内容、元数据、资源）
        .Resources：静态资源（图片处理、CSS/JS 压缩）
    ```


2. 渲染阶段：模板执行

    ```
    1. 模板解析 → 生成 AST（抽象语法树）
    2. 数据绑定 → 将 .Site、.Page 等对象绑定到模板上下文
    3. 执行渲染：
          变量替换（{{ .Title }}）
          方法调用（{{ .Date.Format "2006-01-02" }}）
          逻辑控制（{{ if .IsPage }}...{{ end }}）
    4. 输出静态文件 → 写入 public/ 目录 
    ```
   3.示例：渲染流程

   访问 /posts/first-post/：
    ```
    1.解析 content/posts/first-post.md → Page 对象
    2.选择 layouts/posts/single.html 模板
    3.渲染 .Title、.Content 等属性
    4.生成 public/posts/first-post/index.html
    ```
   
   

二、Hugo 的面向对象特性
1. 封装（Encapsulation）

        实现方式：
        对象属性：.Page.Title
        对象方法：.Permalink、.Summary
        隐藏细节：例如 .Permalink 内部处理 URL 生成逻辑

2. 组合（Composition）

    实现方式：
        部分模板（Partials）：

        <!-- layouts/partials/header.html -->
        <header>{{ .Site.Title }}</header>
        
        <!-- layouts/_default/baseof.html -->
        {{ partial "header.html" . }}

    ​    模板继承：

        <!-- layouts/_default/baseof.html -->
        <html>{{ block "main" . }}{{ end }}</html>
        
        <!-- layouts/_default/single.html -->
        {{ define "main" }}
        <article>{{ .Content }}</article>
        {{ end }}

3. 多态（Polymorphism）

    实现方式：
        管道操作符 |：

        <!-- 字符串处理 -->
        {{ "hello" | title }}  <!-- 输出 "Hello" -->
        
        <!-- 日期处理 -->
        {{ .Date | time.Format "2006-01-02" }}

       资源处理：

    
          {{ $css := resources.Get "style.css" | minify }}
          {{ $img := resources.Get "photo.jpg" | resize "300x" }}
    
4. 上下文传递（Context Passing）

    实现方式：
         循环中自动切换上下文：

        {{ range .Pages }}
          <a href="{{ .Permalink }}">{{ .Title }}</a>  <!-- . 是当前 Page -->
        {{ end }}

    ​    with 语句临时修改上下文：

    ```
    {{ with .Page.Params.author }}
    
     <p>Author: {{ . }}</p>  <!-- . 是 author 字符串 -->
    
     {{ end }}
    ```
    5.类型系统（Type Safety）
          实现方式：
              类型断言：
    
        {{ if eq (kind .Params) "map" }}
        <!-- 处理参数为 map 的情况 -->
        
        {{ end }}


方法签名匹配：例如 .Resize 仅适用于 Resource 对象

三、Hugo 与传统 OOP 对比

## **Hugo 与传统 OOP 对比**



| 特性         | 传统 OOP（如 Java） | Hugo 实现方式           |
| ------------ | ------------------- | ----------------------- |
| **封装**     | 类 + 私有/公共字段  | `.` 访问属性 + 方法调用 |
| **组合**     | 结构体嵌入          | 部分模板 + 模板继承     |
| **多态**     | 接口 + 实现类       | 管道操作符 + 内置函数   |
| **继承**     | 类继承              | `baseof.html` 模板继承  |
| **类型安全** | 编译时检查          | 构建时静态类型检查      |


四、Hugo 设计哲学

简洁优先：极简语法（无类、接口声明）
约定优于配置：固定目录结构隐式定义行为
性能导向：构建时完成所有计算，生成纯静态文件

使用建议

利用 部分模板 减少重复代码
通过 管道操作符 实现灵活数据处理
结合 上下文传递 编写动态逻辑

