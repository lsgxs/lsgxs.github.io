---
title: "React学习笔记"
slug: "react%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-08-29T18:48:48+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: " "
thumbnail: "images/"
---

### 构建一个简单的react项目

使用vite作为工具构建一个简单的react项目，理解react项目的基本框架和运行原理

```
#先安装好node，最好下载最新的lts版，目前是22.18
#装好node之后，在bash下使用node  -v，出现22.18的版本号就是装好了，顺便在显示一下npm  -v
npm create vite@latest moz-todo-react -- --template react
```

#### 项目的基本结构

生成的项目结构如下图：

```
# 在windows的cmd下使用dir  /B  > dirs.txt  生成项目的目录和文件列表。/B  是bare的首字母，表示输出采用无装饰的格式
# 手动输入+--;\--表示最后一个同级项目
LearnReact
  +--node_modules
  +--public
  +--src
    |--assets
    |--components
    |--App.jsx
    |--index.css
    |-- main.jsx
  +--.gitignore
  +--eslint.config.js
  +--index.html
  +--package.json
  +--package-lock.json
  +--README.md
  \--vite.config.js
```

##### index.html

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TodoMatic</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>

```

* `<script type="module" src="/src/main.jsx"></script>`。在index.html文件中加载了项目根目录下src目录下的main.jsx文件。然后main.jsx文件里又加载了App.jsx文件，App.jsx文件又可以使用子组件，比如components下的组件。加载这样就形成了一个完整的调佣链条：`index.html`，`main.jsx`、`App.jsx`、childComponentsxxx.jsx
* `<div  id=""root></div>`  这句是表示了这个`<div>  </div>`是整个虚拟dom的根元素，为后面动态添加子元素用的吧，我是这么理解。

##### main.jsx

这个文件是程序的入口点，初始状态如下：

```
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import App from "./App.jsx";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
```

`main.jsx`文件的最上边是`import`部分，用来导入需要的JavaScript 模块和资源。前边两条语句是导入react库文件，这些不带路径和扩展名称的库，在package.json文件里作为依赖列出来。后边两条带有`./`路径的是指当前项目文件。

在下面的`createRoot()`函数里，看到了在`index.html`文件里的`root`，这样就关联到了，把`id=root`的`<div></div>`创建为虚拟`DOM`的根元素，然后调用这个根元素的`render()`方法，把自定义的`<App />`组件添加在根元素下面。

`<App  />`这样的写法，是jsx里双关的表示方法：**以类HTML标签的书写形式，实现函数的调用（组件的复用）**

* 类似HTML标签的写法，不过这里App首字母大写，表示自定义，标准的HTML标签是小写
* `App`是一个自定义的component，是一个独立的文件，同时又是组件里的函数名称。

这里的`<App />`书写方法还可以带参数，类似`html`标签里的属性和值的写法一样，下面的代码会显示这一特征。

##### App.jsx

```
import { useState } from "react";
import viteLogo from "/vite.svg";
import reactLogo from "./assets/react.svg";
import "./App.css";

function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  );
}

export default App;
```

`App.jsx`文件包含三部分

* import部分   引用react库文件、运行时需要的图片、CSS文件

  * The final statement imports the CSS related to our `<App />` component. Note that there is no variable name and no `from` directive. This is called a [*side-effect import*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import#import_a_module_for_its_side_effects_only) — it doesn't import any value into the JavaScript file, but it tells  Vite to add the referenced CSS file to the final code output, so that it can be used in the browser.

* function  App()   初始化本地的数据[count,setCount]=useState，然后用return语句返回一个<> </>包裹的jsx表达式，这个jsx表达式类似HTML中的元素，可是单个按钮，可以是整个form组件和其包裹的所有子元素，甚至整个页面的DOM树。

  * App是一个react  compotent，它的名称使用upper camel case样式，名称中多个单词的首字母大写，比如HelloWorld。如果把这函数名称写成小写的`app`，浏览器就会报错。
  * return 返回的jsx表达式类似标准的HTML元素，表示了在浏览器渲染的界面。但是它不是HTML元素，是jsx表达式，最后是由Babel编译，每一个jsx元素都被转换为React.createElement()函数的调用，多个元素嵌套的话，就会转为React.createElement()函数的嵌套调用。

* export  default  App

  * 导出默认的函数可以让别的组件使用

##### React.createElement

`React.createElement()` **是 React 框架自身的核心 API**，而非标准 JavaScript 库（如 DOM API 或 ECMAScript 规范）。程序代码里并没有看到这个函数，但是这些组件函数返回的jsx表达式，最后都是由Babel转换为对React.createElement()函数的调用，最终转换为javascript代码，而React内部是通过javascript对象来保存这些描述性的渲染数据。

* 虚拟 DOM 的创建（`React.createElement`）

当调用 `React.createElement()` 时，React 会返回一个虚拟 DOM 对象（`ReactElement`），它是一个纯 JavaScript 对象，描述了要渲染的 UI 结构

```javascript
const element = React.createElement('div', { className: 'box' }, 'Hello');
```

返回的element对象的数据结构如下：

```
{
  type: 'div',          // 标签名或组件
  props: {              // 属性和子元素
    className: 'box',
    children: 'Hello'
  },
  key:,
  ref:,
  $$typeof: Symbol.for('react.element'), // React 内部标识
}
```

这个javascript对象本身并不会直接渲染到页面，它只是一个“蓝图”，告诉 React 后续应该如何构建真实的 DOM。

*  渲染为真实 DOM（`ReactDOM.render`）

  ```
  #旧版同步渲染
  ReactDOM.render(
    <App tasks={DATA} />,
    document.getElementById('root')
  );
  ```

  ```
  #新版异步渲染
  createRoot(document.getElementById('root')).render(
    <StrictMode>
      <App tasks={DATA}/>
    </StrictMode>,
  )
  ```
  

  `ReactDOM.render(element, container)` 的作用是**将虚拟 DOM 转换为真实 DOM，并挂载到指定的容器中**。它的核心步骤如下：

   (1) 递归处理虚拟 DOM 树

  React 会从根元素（`element`）开始，递归遍历整个虚拟 DOM 树，逐层创建真实的 DOM 节点。

   (2) 创建真实 DOM 节点

  - 根据 `element.type`（如 `'div'`）调用 `document.createElement()` 创建对应的 DOM 元素。
  - 如果 `type` 是一个函数/类（即组件），则先执行组件函数，得到其返回的虚拟 DOM，再继续处理。

  (3) 设置属性和事件

  - 遍历 `element.props`，将属性（如 `className`、`style`）赋值给真实 DOM。
  - 特殊属性（如 `onClick`）会被绑定为事件监听器。
  - `children` 会被递归处理（可能是文本、数组或嵌套的虚拟 DOM）。

  (4) 挂载到容器

  - 将最终生成的真实 DOM 节点插入到传入的 `container` 中

    简化的ReactDOM.render内部实现过程

```
function render(element, container) {
  // 1. 创建 DOM 节点
  const domNode = document.createElement(element.type);

  // 2. 设置属性（排除 children）
  for (const propName in element.props) {
    if (propName === 'children') continue;
    domNode[propName] = element.props[propName];
  }

  // 3. 处理 children
  const children = element.props.children;
  if (typeof children === 'string') {
    domNode.textContent = children; // 文本子节点
  } else if (Array.isArray(children)) {
    children.forEach(child => render(child, domNode)); // 递归处理数组
  } else if (children?.$$typeof === Symbol.for('react.element')) {
    render(children, domNode); // 单个子虚拟 DOM
  }

  // 4. 挂载到容器
  container.appendChild(domNode);
}

// 使用示例
const element = React.createElement('div', { className: 'box' }, 'Hello');
const container = document.getElementById('root');
render(element, container); // 最终生成 <div class="box">Hello</div>
```

* React.createElement（type`、`props`、`...children）参数介绍

  * **`type`**（必填）：元素类型（如 `'div'`、组件类、函数组件）

  * **`props`**（可选）：属性对象（如 `{ className: 'box' }`），可为 `null` 或省略。

    ```
    props参数为空的几种写法
    // 写法1：显式传递（经典写法）：可读性差，不推荐
    React.createElement('div',, 'Hello', 'World');
    
    // 写法2：传递空对象（明确表示无 props）
    React.createElement('div', {}, 'Hello', 'World');
    
    // 写法3：直接省略 props（利用参数默认值）
    React.createElement('div', undefined, 'Hello', 'World');
    ```
    在第二个参数props为空的情况下，后边的多个children参数仍然会被归集到props里；或者说无论 `props` 是否为空，`children` 都会被归集到 `props.children`

  * **`...children`**（可选）：剩余参数，收集所有子元素（字符串、数字、React 元素、数组等）

    * 参数多于3个以上的话，会把后边的多个参数收集在一个数组里，始终保持三个参数
    * `children` **必须**是 `props` 的一个属性，而不是与 `type`/`props` 平级的字段。
    * children都要收集在props里
    
    
  
  * createElement返回的对象数据结构
  
    ```
    {
      type: string | Function, // 元素类型（如 'div' 或组件函数）
      props: Object,          // 所有属性（包括 children）
      key: string ,
      ref: Object ,
      // ...其他内部字段（如 $$typeof 标识）
    }
    ```
  
    

