---
title: "理解hugo的模板"
slug: "%E7%90%86%E8%A7%A3hugo%E7%9A%84%E6%A8%A1%E6%9D%BF"
date: 2025-10-05T09:52:54+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: "Hugo 是一个通过目录结构和模板查找规则来驱动内容渲染的静态站点生成器。理解这些概念的关键在于理解Hugo的“约定优于配置” 原则。 "
thumbnail: "images/grass_sky.jpg"
---



### hugo的里的模板

在`hugo`博客系统中，有两种类型的模板，一种是markdown文件的front matter的模板，这种模板用来新建文档时使用；第二类模板是对不同类型的文档进行渲染生成`html`文件的模板。

#### 内容模板

这类模板在项目根目录下的archetypes目录保存。初建`hugo`项目时archetypes目录下只有一个default.md文件，作为新建文档的模板。如果经常要新建博客文档，可以在archetypes目录下新建一个名称posts.md的文档，这样在使用`hugo`  new   content 或者`hugo`  new  posts/....命令时，新建的文档就会以archetypes/`posts.md`的内容作为模板，文档的front matter内容自动复制模板的front matter内容。这样就可以根据自己的偏好来设置archetypes/posts.md的front matter包含哪些必要的项目。

#### 渲染模板

这种类型的模板指的是对不同类型的文档进行渲染的模板文件。最直观的文档编辑界面是markdown文档，而不是手动去新建或者编辑`html`文件，毕竟有那么多标签元素，编辑器起来太麻烦，而且没有所见即所得的视觉效果。所有就诞生了markdown之类的对人类友好的文档编辑器。而markdown文档包含两个主要的部分，一是front matte部分的元数据，也就是front  matter，另外一部分就是文档的内容。包括`hugo`在内的各种类型静态站点生成器就是把markdow的文档的这两个部分作为编程对象，内容部分最终是呈现给用户的，而front  matter部分是呈现给静态站点生成器的，在front matter保存各种类型的数据，用来灵活的操作文档的渲染过程。比如说，在front  matter区域的type、layout等数据项.Kind有single和list等多个值，如果是single，就代表这个页面是单文件页面，渲染这个文档时就用`single.html`这个文件作为模板，如果是list，就代表这个页面是显示文档列表的页面，渲染时就会寻找`list.html`文件作为模板。然后就是依据tpye来决定到哪个目录下需找这个模板文件，如果找不到，最后回退到系统自带的默认模板。

------

#### 和模板相关的几个重要概念

#### 1. Section（章节）

**实际意义：Section 是内容组织的第一级分类，是 Hugo 中最核心的组织单元。**

- **如何定义？**
  Section 由 `content` 目录下的**第一级子目录**自动定义。

- **示例：**

  text

```
content/
├── posts/          <-- Section 名为 "posts"
│   ├── post-1.md
│   └── post-2.md
├── tutorials/      <-- Section 名为 "tutorials"
│   ├── tutorial-1.md
│   └── _index.md   <-- 这是 tutorials Section 的首页
└── _index.md       <-- 这是整个网站的首页
```



- **重要特性：**
  - 每个 Section 都可以拥有一个 `_index.md` 文件，这个文件代表该 Section 的列表页（例如 `yoursite.com/tutorials/`）。
  - 网站的根 `_index.md`（位于 `content/` 下）代表网站的主页。
  - Section 的名称（目录名）会成为该章节下所有页面的默认 **`Type`**。

------

#### 2. Type（类型）

**实际意义：Type 是内容的逻辑分类，决定了 Hugo 在渲染该内容时，去寻找哪个名称的模板（Layout）。**

- **如何定义？**
  1. **默认情况：** 一个页面的 `Type` 等于它所属的 **Section**。
     - 例如，`content/posts/my-post.md` 的 `Type` 默认是 `"posts"`。
  2. **显式设置：** 你可以在内容的 Front Matter 中通过 `type: "something"` 来覆盖默认值。
     - 例如，即使一篇文章在 `posts` 目录下，你也可以设置 `type: "review"`，让它使用 `review` 类型的模板。
- **与 Section 的关系：**
  - Section 是**物理位置**上的分类，而 Type 是**逻辑功能**上的分类。
  - 大多数情况下，两者是相同的，但 Type 给了你灵活性，可以将不同 Section 的内容归类到同一种逻辑类型下，或者让同一 Section 的内容使用不同的模板。

------

#### 3. Kind（种类）

**实际意义：Kind 描述了页面的“根本属性”，它是由 Hugo 内部根据页面位置自动决定的，不可更改。它决定了模板查找的顶层规则。**

- **常见的 Kind 有：**
  - `home`: 网站主页（`content/_index.md`）。
  - `page`: 单个内容页面（也叫“单页”，如 `content/posts/my-post.md`）。
  - `section`: 章节列表页（如 `content/posts/_index.md`）。
  - `taxonomy`: 分类列表页（如 `tags` 或 `categories` 的列表页，`content/tags/_index.md`）。
  - `term`: 某个特定分类下的内容列表页（如 “hugo” 这个标签下的所有文章列表页，`content/tags/hugo.md`）。
- **如何判断？**
  - 任何**不**以 `_index.md` 命名的 Markdown 文件，其 `Kind` 都是 `page`（单页）。
  - 任何名为 `_index.md` 的文件，其 `Kind` 由其所在目录决定（`home`, `section`, `taxonomy`, `term`）。

**Kind 是模板查找的起点。** Hugo 首先看 `Kind`，然后再看 `Type`。

```
Hugo 内置的 Kind 类型
1. home - 首页
    站点根目录的首页
    对应模板：layouts/index.html 或 layouts/_default/home.html
2. page - 普通单页
    常规的内容页面（Markdown 文件）
    对应模板：single.html
3. section - 章节页面
    内容目录的索引页面（包含 _index.md 的目录）
    对应模板：list.html
4. taxonomy - 分类法列表页
    分类法的列表页面（如所有标签的列表）
    对应模板：taxonomy.html 或 list.html
5. term - 分类术语页
    特定分类术语的内容列表（如 "hugo" 标签下的所有文章）
    对应模板：term.html 或 list.html
6. RSS - RSS 订阅
    自动生成的 RSS 订阅页面
    对应模板：rss.xml
7. sitemap - 网站地图
    自动生成的 sitemap.xml
    对应模板：sitemap.xml
8. robotsTXT - robots.txt
    自动生成的 robots.txt
    对应模板：robots.txt
9. 404 - 404 错误页面
    404 错误页面
    对应模板：404.html
如何查看页面的 Kind

在模板中可以通过 .Kind 变量查看：
go-html-template
{{ .Kind }}  <!-- 输出当前页面的 Kind -->

或者在配置中开启调试：
toml

[debug]
enable = true

各 Kind 的典型内容结构
bash

content/
├── _index.md           # home (Kind)
├── blog/
│   ├── _index.md       # section (Kind)  
│   ├── post-1.md       # page (Kind)
│   └── post-2.md       # page (Kind)
└── tags/
    ├── _index.md       # taxonomy (Kind)
    └── hugo.md         # term (Kind)

这些 Kind 类型是 Hugo 内置的，决定了页面的基本性质和使用哪个基础模板
```

------

#### 4. Layout（布局/模板）

**实际意义：Layout 是实际用于渲染页面的 HTML 模板文件，存放在 `layouts` 目录下。**

Hugo 有一套非常**严谨的查找顺序**来为每个页面决定使用哪个模板。这个顺序正是 `Kind` 和 `Type` 发挥作用的地方。

**模板查找顺序（以 `content/posts/my-post.md` 为例）：**

假设这个页面的 `Kind` 是 `page`，`Type` 是 `posts`。

Hugo 会按以下顺序查找模板，使用它找到的第一个匹配项：

1. `layouts/posts/single.html` (最具体：`Type` + `Kind`)
2. `layouts/_default/single.html` (最通用：默认的 `Kind`)
3. `themes/<my-theme>/layouts/posts/single.html`
4. `themes/<my-theme>/layouts/_default/single.html`

**另一个例子：`content/posts/_index.md`（Section 列表页）**

它的 `Kind` 是 `section`，`Type` 是 `posts`。查找顺序为：

1. `layouts/posts/list.html` (`Type` + `Kind`)
2. `layouts/_default/list.html` (默认的 `Kind`)
3. ...（主题目录）

**再一个例子：设置了自定义 `type` 的文章**

文件：`content/posts/my-review.md`，其 Front Matter 包含 `type: "review"`。

- `Kind`: `page`
- `Type`: `"review"` (覆盖了默认的 `"posts"`)

查找顺序：

1. `layouts/review/single.html` (新的 `Type` + `Kind`)
2. `layouts/_default/single.html` (默认的 `Kind`)
3. ...（它**不会**去找 `layouts/posts/single.html`，因为 `Type` 已经被改变了）

------

#### 总结与关系

| 概念        | 定义方式                                     | 实际意义                                                     | 可变性                   |
| ----------- | -------------------------------------------- | ------------------------------------------------------------ | ------------------------ |
| **Section** | 由 `content/` 下的目录决定                   | **内容的物理分组**，用于组织内容，生成列表页。               | 不可变（由文件位置决定） |
| **Kind**    | 由 Hugo 根据文件位置和名称自动判断           | **页面的根本类型**（是主页、单页、还是列表页？），决定了模板查找的顶层路径。 | 不可变                   |
| **Type**    | 默认等于 `Section`，可在 Front Matter 中覆盖 | **内容的逻辑类型**，用于精细控制页面使用的模板。             | 可变                     |
| **Layout**  | 位于 `layouts/` 目录下的 `.html` 文件        | **最终渲染页面的模板**。Hugo 根据 `Kind` 和 `Type` 的规则来查找它。 | 由开发者创建             |

**它们如何协同工作？**

1. 你写了一篇文章 `content/tutorials/hugo-guide.md`。
2. Hugo 自动识别：
   - **Section**: `tutorials` (因为它在这个目录下)
   - **Kind**: `page` (因为它不是 `_index.md`)
   - **Type**: `tutorials` (默认与 Section 相同)
3. 当 Hugo 要渲染这个页面时，它问：这个页面的 `Kind` 是什么？答：`page`。它的 `Type` 是什么？答：`tutorials`。
4. Hugo 开始查找模板：
   - 先找 `layouts/tutorials/single.html` -> 找到！就用它渲染。
   - 如果没找到，继续找 `layouts/_default/single.html` -> 用它渲染。

通过理解这些概念和查找规则，你就能完全掌控 Hugo 站点的内容组织和展示方式



### 核心查找逻辑

**模板查找顺序 = `Kind` → `Type` → 模板文件**

  1. **`Kind` - 决定模板类型**

- `page` (单篇文章) → 找 `single.html` 模板
- `section` (章节列表) → 找 `list.html` 模板
- `home` (首页) → 找 `index.html` 模板
- `taxonomy`/`term` (分类列表) → 找 `list.html` 模板

  2. **`Type` - 决定模板目录**

- 默认 = `Section` (物理目录名)
- 可自定义覆盖

  3. **Section - 物理组织基础**

- 确实是**物理层面**的内容组织结构
- 决定了默认的 `Type`
- 通过目录结构自动定义

 实际查找示例

bash

```
content/
├── posts/           # Section = "posts"
│   ├── _index.md    # Kind = section, Type = posts → layouts/posts/list.html
│   └── my-post.md   # Kind = page, Type = posts → layouts/posts/single.html
└── about.md         # Kind = page, Type = "" → layouts/_default/single.html
```

- ✅ `Type` 决定"去哪里找"模板目录
- ✅ `Kind` 决定"找什么类型"的模板文件
- ✅ `Section` 是物理目录结构的基础约定

 核心流程总结

1. **Kind 决定模板类型** → 确定要找什么文件（`single.html`、`list.html`、`home.html`等）
2. **Type 决定查找位置** → 确定在哪个目录中查找这个文件

 实际工作流程

text

```
页面请求 → 识别 Kind → 确定模板文件名 → 根据 Type 查找目录 → 返回匹配的模板
```


例如：

- 一个 `posts` 类型的普通页面：
  - **Kind**: `page` → 需要 `single.html`
  - **Type**: `posts` → 在 `layouts/posts/` 目录查找
  - **结果**: 优先使用 `layouts/posts/single.html`
- 一个 `products` 类型的章节页面：
  - **Kind**: `section` → 需要 `list.html`
  - **Type**: `products` → 在 `layouts/products/` 目录查找
  - **结果**: 优先使用 `layouts/products/list.html`

这种设计让 Hugo 既保持了清晰的逻辑结构，又提供了灵活的模板定制能力



```
1、模板文件。通过kind决定找那个模板文件，比如single.html、list.html
2、所在目录。通过type（实际上逻辑的目录名称）来决定在哪个目录下寻找这个模板文件
```

### Hugo中约定大于配置的设计

 1. 页面种类（Kind）的约定

Hugo 通过文件在项目结构中的位置和名称自动确定页面的 Kind，具体如下：

- **home**: 根目录下的 `_index.md` 文件（即 `content/_index.md`）
- **section**: 每个内容目录（如 `content/blog`）下的 `_index.md` 文件
- **page**: 任何目录下的普通 Markdown 文件（不包括 `_index.md`）
- **taxonomy**: 在 `content/<taxonomy_name>/_index.md` 文件（例如 `content/tags/_index.md`）
- **term**: 在 `content/<taxonomy_name>/<term_name>/_index.md` 文件（例如 `content/tags/hugo/_index.md`）

 2. 模板查找的约定

模板文件存放在 `layouts` 目录下，Hugo 按照特定的顺序查找模板，这个顺序基于页面的 Kind 和 Type：

- 首先，Hugo 根据 Kind 确定需要查找的模板类型（如 `single.html`, `list.html` 等）
- 然后，按照以下优先级查找模板：
  1. 与 Type 同名的目录下的模板（如 `layouts/posts/single.html`）
  2. 与 Kind 同名的目录下的模板（如 `layouts/section/list.html`）
  3. 默认目录下的模板（如 `layouts/_default/single.html`）

 3. 内容组织（Bundle）的约定

Hugo 通过目录结构来区分 Leaf Bundle 和 Branch Bundle：

- **Branch Bundle**: 包含 `_index.md` 文件的目录，可以包含其他页面和资源，用于表示章节、分类等。例如：

  text

```
content/
  blog/          # Branch Bundle (section)
    _index.md    # 分支捆绑的索引文件
    post-1.md    # 属于该分支的页面
    post-2.md
```



**Leaf Bundle**: 一个目录中包含一个与目录同名的 Markdown 文件（或其他内容文件）以及相关资源。例如：

text

```
content/
  blog/
    my-post/     # Leaf Bundle
      index.md   # 叶子捆绑的内容文件
      image.jpg  # 该页面的资源
```



- 注意：也可以使用非 `index.md` 的同名文件，如 `my-post.md` 并放在 `my-post` 目录中，但这种方式不常见。

 4. 章节（Section）的约定

章节由内容目录自动生成，目录名即为章节名。例如：

- `content/blog/` -> 章节名为 "blog"
- `content/news/` -> 章节名为 "news"

章节的层级结构由目录层级决定，例如 `content/blog/2021/_index.md` 表示一个嵌套的章节。

 5. 分类法（Taxonomy）的约定

分类法通过 `config.toml`（或类似配置文件）中定义，但具体的内容页面由目录结构约定：

- 分类法列表页：`content/<taxonomy_name>/_index.md`
- 分类术语页：`content/<taxonomy_name>/<term_name>/_index.md`

例如，定义了一个分类法 "tags"，则：

- 所有标签列表页：`content/tags/_index.md`
- 特定标签 "hugo" 的页面：`content/tags/hugo/_index.md`

 6. 静态资源的约定

静态资源可以放在 `static` 目录下的任何位置，也可以放在 Leaf Bundle 或 Branch Bundle 中。放在 Bundle 中的资源可以通过 `.Resources` 访问，而放在 `static` 中的资源则直接复制到输出目录。

 7. 数据文件的约定

数据文件可以放在 `data` 目录下，支持多种格式（如 JSON、YAML、TOML），并通过站点数据机制自动加载。

 8. 主题的约定

主题可以覆盖项目的默认布局和静态资源。主题的查找顺序为：

1. 项目本身的 `layouts` 和 `static` 目录
2. 主题的 `layouts` 和 `static` 目录

 总结

Hugo 的“约定大于配置”体现在：

- 通过固定的目录结构（如 `content`、`layouts`、`static`、`data`）来组织内容、模板、静态资源和数据。
- 通过特定的文件名（如 `_index.md`）来标识分支捆绑和特殊页面（如首页、章节页、分类页等）。
- 模板的查找顺序由页面的 Kind 和 Type 自动确定，无需配置。
- 内容捆绑（Bundle）通过目录结构来区分叶子捆绑和分支捆绑，便于资源管理。

这些约定使得 Hugo 项目结构清晰，同时减少了配置的复杂性

#### 约定大于配置的具体实例

 1. **模板系统的约定**

 Kind 的自动识别

bash

```
content/
├── _index.md           # 自动识别为 home kind
├── blog/
│   ├── _index.md       # 自动识别为 section kind
│   ├── post-1.md       # 自动识别为 page kind
│   └── post-2.md
└── tags/
    ├── _index.md       # 自动识别为 taxonomy kind
    └── hugo.md         # 自动识别为 term kind
```



 模板查找约定

bash

```
layouts/
├── _default/           # 默认回退模板
├── blog/               # 基于 type 的模板
├── section/            # 基于 kind 的模板
└── partials/           # 可重用组件
```



2. **内容组织的约定**

 Bundle 类型自动确定

bash

```
content/
├── posts/
│   ├── my-article/     # Leaf Bundle (目录 + index.md)
│   │   ├── index.md
│   │   ├── image1.jpg
│   │   └── cover.png
│   └── another-post.md # 普通页面文件
└── projects/
    ├── _index.md       # Branch Bundle
    ├── project-1/
    │   └── index.md
    └── project-2/
        └── index.md
```



 Section 自动划分

bash

```
content/
├── blog/               # section = "blog"
├── projects/           # section = "projects"  
└── about.md            # section = "" (根级)
```



 3. **URL 结构的约定**

 基于目录结构的 URL

bash

```
content/
├── blog/
│   ├── post-1.md      # → /blog/post-1/
│   └── post-2.md      # → /blog/post-2/
└── about.md           # → /about/
```



 4. **数据加载的约定**

 自动数据加载

bash

```
data/
├── authors.json       # 自动加载到 .Site.Data.authors
├── settings/
│   └── config.yaml    # 自动加载到 .Site.Data.settings.config
└── events/            # 支持子目录组织
    └── 2024.yaml
```
 5. **资源管理的约定**

 资源目录结构

bash

```
assets/
├── css/
│   └── main.scss      # 支持 SCSS 处理
├── js/
│   └── app.js         # 支持 JS 打包
└── images/            # 图片资源
static/
└── favicon.ico        # 直接复制到输出
```



 6. **配置的约定**

 配置层级

bash

```
config.toml                    # 主配置
config/
├── _default/                 # 默认配置
│   ├── config.toml
│   └── menus.en.toml
├── production/               # 环境特定配置
│   └── config.toml
└── development/
    └── config.toml
```



 7. **主题系统的约定**

 主题覆盖机制

bash

```
my-site/
├── layouts/                  # 项目模板（覆盖主题）
├── content/                  # 项目内容
└── themes/
    └── my-theme/            # 主题文件
        ├── layouts/
        └── static/
```



 8. **多语言支持的约定**

 语言内容组织

bash

```
content/
├── _index.en.md             # 英语首页
├── _index.fr.md             # 法语首页
└── blog/
    ├── _index.en.md
    ├── _index.fr.md
    ├── post-1.en.md
    └── post-1.fr.md
```

 设计哲学总结

Hugo 的"约定大于配置"设计体现在：

1. **基于位置的身份**：文件在目录结构中的位置决定其角色
2. **命名约定**：特定文件名（`_index.md`）有特殊含义
3. **目录即结构**：目录层级直接映射到网站结构
4. **自动发现**：系统自动识别内容类型和关系
5. **合理回退**：从具体到通用的模板查找机制
6. **环境感知**：基于环境的配置自动切换

这种设计让开发者可以专注于内容创作，而不需要大量配置，同时保持了项目的结构清晰和可维护性

### branch bundel 和leaf  bundle  

#### Bundle概念

Hugo中的Bundle是一种组织内容和相关资源（如图片、PDF等）的方式。Bundle分为两种：Leaf Bundle和Branch Bundle。

##### Leaf Bundle（叶子包）

**定义**：Leaf Bundle是一个**内容目录**，其中包含一个`index.md`（或`index.html`等）文件以及与该内容相关的资源文件。它代表一个单独的内容页面，并且不能有下级页面（即不能包含其他内容页面）。

**典型结构**：

text

```
content/
└── blog
    └── my-post
        ├── index.md
        ├── image1.jpg
        └── image2.png
```



**特点**：

- 必须包含`index.md`（或其它支持的内容格式文件）作为内容文件。
- 可以包含任意数量的资源文件（如图片、文档等）。
- 在站点中生成一个页面，URL为`/blog/my-post/`。
- 资源可以通过`Resources`变量在模板中访问。

**使用场景**：用于单个页面，并且该页面有专属的资源（如图片、下载文件等）。

##### Branch Bundle（分支包）

**定义**：Branch Bundle是一个**章节目录**，其中包含一个`_index.md`文件（可选）以及该章节的页面（Leaf Bundle或普通页面）和资源。它代表一个章节（Section）并可以包含子页面。

**典型结构**：

text

```
content/
└── blog
    ├── _index.md
    ├── post-1
    │   ├── index.md
    │   └── photo.jpg
    └── post-2
        ├── index.md
        └── image.png
```



**特点**：

- 必须包含`_index.md`（可选，但通常用于提供该章节的元数据和内容）来代表分支包本身。
- 可以包含多个子页面（Leaf Bundle或普通页面）和资源。
- 在站点中生成一个章节页面（列表页），URL为`/blog/`，并且该章节下的每个页面也会生成对应的URL。
- 分支包本身的资源可以通过`.Resources`访问，但通常分支包更常用于组织子页面。

**使用场景**：用于组织一个章节（如博客、产品目录等），该章节包含多个页面，并且章节本身可能有自己的资源和元数据。

总结对比

| 特性       | Leaf Bundle              | Branch Bundle              |
| ---------- | ------------------------ | -------------------------- |
| 内容文件   | `index.md`               | `_index.md`（可选）        |
| 资源       | 有，属于该页面           | 有，属于该章节             |
| 子页面     | 不能有                   | 可以有                     |
| 生成的页面 | 单个页面                 | 章节页面（列表页）和子页面 |
| 典型用途   | 文章、产品详情等独立页面 | 博客、章节首页等           |

 约定

- **Leaf Bundle**：使用`index.md`命名的目录，代表一个叶子节点。
- **Branch Bundle**：使用`_index.md`的目录，代表一个分支节点，可以包含子节点。

通过这种约定，Hugo可以自动识别页面类型并正确处理资源和页面关系

