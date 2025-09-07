---
title: "React学习笔记"
slug: "react%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-08-29T18:48:48+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: "jsx是javascript和HTML的混合体，将类XML标签语言和javascript组合在一起，以标签语言的书写形式，融入了javascript的变量和表达式、函数实现动态的界面构建技术，以熟悉的方式高效构建动态可复用的用户界面。每个组件函数返回jsx表示的用户界面，由Bable/Parcel编译，通过对React.createElement（）函数的调用，生成虚拟的DOM（内存中的 JavaScript 对象），并通过Diffing技术实现真实DOM的渲染"
thumbnail: "images/jsx.png"
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

  ```
  index.html is the most important top-level file. Vite injects your code into this file so that  browser can run it.
  ```
  
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

​       这里的`<App />`书写方法还可以带参数，类似`html`标签里的属性和值的写法一样，下面的代码会显示这一特征。

* By writing `<App />` as this JSX expression, we're telling React to call the `App()` *function*, which renders the `App` *component* inside the root node.

  [我的翻译-通过把<App />作为jsx表达式传递给render作为参数，告诉 React调用App（）函数在root节点下渲染App组件。]

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

    * return  `<> jsx expression </>` 。当返回的同级元素多于一个时就要用jsx  fragmen（`<> </>`）包裹。

      ```
      #如果返回的是单个元素则不需要<> </>包裹
      <h1>one expression</h1>  
      #如果返回的是多个同级元素，要用<> </>包裹
      <>
        <p>first  paragraph  </p>
        <p2>second  paragraph</p>
      </>
      #最外层是一个元素的嵌套多个元素，也不需要<> </>包裹
      <div>
         <span> one  </span>
         <span>  two </span>
      </div>
      ```

      

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
  
    

###  JSX实践

**JSX is a powerful syntax extension for JavaScript that enables  developers to write UI components with a familiar HTML-like structure  while seamlessly integrating dynamic JavaScript logic through embedded  expressions (`{}`).** Unlike traditional templates, JSX compiles to React.createElement()  calls, allowing it to leverage the full power of JavaScript for  rendering logic, conditional statements, and loops. Its  component-centric design promotes reusability and modularity, while  automatic escaping of embedded content ensures security against XSS  attacks. By blending declarative markup with  JavaScript, JSX  bridges the gap between design and functionality, making it the  cornerstone of React’s efficient, virtual DOM-driven rendering pipeline.

#### React如何使用javascript

React使用了javascript的大部分模式，但是最大的不同就是使用了jsx语法。JSX扩展了javascript语法，让类HTML代码可以和javascript代码一起工作。比如：

```
const heading = <h1>Mozilla Developer Network</h1>;
```

`heading`常量叫做JSX表达式，React可以在我们的程序中渲染`<h1>`元素，这是单个元素的写法。再看看多个元素嵌套的写法：

```
const header = (
  <header>
    <h1>Mozilla Developer Network</h1>
  </header>
);
```

这里的括号是可选的，是提高代码阅读性加的，但是更推荐这种带括号的写法，避免不必要的错误产生。

这种写法和HTML标签的写法类似，JSX是HTML和javascript的混合体，只要熟悉HTMl的写法，很快熟悉jsx的写法，轻松直观的编写用户界面。

浏览器并不能直接识别jsx代码，需要用Babel/Parcel进行编译，最终转换为标准的的javascript代码，如下所示：

```
const header = React.createElement(
  "header",
  null,
  React.createElement("h1", null, "Mozilla Developer Network"),
);
```

jsx表达式中的标签都会转换为React.createElement的调用，返回一个javascript对象，结构如下：

```
{
  type: "header",
  props: {
    children: {
      type: "h1",
      props: { children: "Mozilla Developer Network" }
    }
  }
}
```

这个对象是虚拟 DOM 的最小单位，React 会将这些 React 元素组成的树状结构（虚拟 DOM）与真实的 DOM 进行对比（通过 Diffing 算法），然后高效地更新真实 DOM。虚拟 DOM 本身不是浏览器 DOM，而是一个轻量级的 JavaScript 对象表示。与真实 DOM 的区别：

- 真实 DOM 是浏览器提供的 API（如 `document.createElement("header")` 返回的对象），操作成本较高。
- React 元素（虚拟 DOM）是纯 JS 对象，创建和对比的开销极小。

**通过对jsx表达式的编译，转为对React.createElement（）函数的调用，最终生成的是虚拟的DOM树状结构对象，通过Diffing算法，渲染真实的DOM。**

#### 在JSX中应用变量、表达式

* 在标签的内容部分应用变量和表达式

  `<h1> content-area</h1> `

在这里所示的`content-area`部分使用`{}`书写变量，会取变量的值进行渲染。

```
const subject = "React";
function App() {
  // code omitted for brevity
}

//{subject}会读取变量subject的值，最终呈现的是<h1> Hello ,React</h1>
<h1>Hello, {subject}</h1>
```

* props（在标签的属性部分书写属性和值）

  props是jsx中在组件之间传递数据的一种方式。书写方式和HTML标签中的属性和值的写法相同。两者的不同之处在于传递数据的对象不同，HTML标签中的属性和值的写法是给HTML element传递数据，而jsx中的props是在组件之间传递数据，通常是父组件给子组件传递数据。比如`prop="value"。

  打开项目程序`/src/main.jsx`，在主程序中加入下面的jsx元素
  
  ```
  
  <App subject="Clarice" />
  
  ```
  
  这样的写法，是在main.jsx程序中调用App组件，并以`prop=value`的形式给App组件传递数据,这里是`subject="Clarice"`。
  
  接下来就要在App组件中给App函数添加接收数据的props参数：
  
  ```
  function App(props) {
    return (
      <>
        <header>
          <h1>Hello, {props.subject}!</h1>
          <button type="button" className="primary">
            Click me!
          </button>
        </header>
      </>
    );
  }
  ```
  
  props在React中是以javascript对象的形式保存数据的，通过标签书写形式（其中的props则是类似属性和值的写法）完成父组件对子组件的调用，数据是通过props对象传递给子组件的函数参数。
  
  **简单理解JSX的基本思想：把XML-HTML类的标签语言引入到javascript，把这些标签组成的UI作为变量、表达式这些可编程元素来构建动态UI。所谓的动态是让标签的内容部分和属性部分引用javascript变量、表达式、函数，真正实现了动态的标签。**这就是javascript和html的相互融合。而要理解React组价的核心，主要是component、props、state。要通过实例慢慢熟悉这些设计思想，只有充分理解了这些设计思想，才能真正掌握这些技术。
  
  ```
  1. 模块调用标签化  <App      />的写法
  2. 函数返回标签化   return( <> )
  3. 数据传递标签  各种props的扩展
  ```
  
  

###  React  Component

[  ]  todolist 

**Componentizing the  app**

 components are either obvious pieces of UI, reused pieces of UI

这句话多看几遍：在React  todo App的【React  events  and  state】部分

Instead, we can write a function in `<App />` that will expect some data from our form as an input, then pass that function to `<Form />` as a prop. This function-as-a-prop is called a **callback prop**. Once we have our callback prop, we can call it inside `<Form />` to send the right data to `<App />`.

### jsx中的注意事项

#### 几个特别的属性

* className

* htmlfor

* boolean  atribution

  ```
  Because JSX is JavaScript, there's a gotcha to be aware of with boolean attributes: writing defaultChecked="false" will set a string value of "false" rather than a boolean value. Non-empty strings are truthy, so React will consider defaultChecked to be true and check the checkbox by default. This is not what we want, so we should avoid it.
  
  If you'd like, you can practice writing boolean attributes with another attribute you may have seen before, hidden, which prevents elements from being rendered on the page. Try adding hidden to the <h1> element in App.jsx to see what happens, then try explicitly setting its value to {false}. Note, again, that writing hidden="false" results in a truthy value so the <h1> will hide. Don't forget to remove this code when you're done.
  ```

  比如说hidder="false",在javascript中，布尔值有true 和false。其他值可以通过是否为空来判断，非空为真值。所以及时hidden=“false”，以为"false"是一个字符串，非空，所以最终还是hidden =  true ,偏离了本意。

#### reuse  of  component

```
Make a unique <Todo />

Components are powerful because they let us re-use pieces of our UI, and refer to one place for the source of that UI. The problem is, we don't typically want to reuse all of each component; we want to reuse most parts, and change small pieces. This is where props come in.
```

```
What's in a name?

In order to track the names of tasks we want to complete, we should ensure that each <Todo /> component renders a unique name.
In App.jsx, give each <Todo /> a name prop. Let's use the names of our tasks that we had before:
jsx

<ul
  role="list"
  className="todo-list stack-large stack-exception"
  aria-labelledby="list-heading">
  <Todo name="Eat" />
  <Todo name="Sleep" />
  <Todo name="Repeat" />
</ul>
```

```
Once again, we want to reuse most of the UI that makes up a <Todo /> component, but change one thing. That's a good job for another prop
```

整体的思路，在复用一个组件时要修改UI的一部分，重复利用props来给子组件传递参数，来定制jsx element的显示或者行为：**通过传递props来动态设置jsx元素**。

 下面这段文档是React官网对component概念的解释。

 Creating and nesting components

React apps are made out of *components*. A component is a piece of the UI (user interface) that has its own logic and appearance. A component can be as small as a button, or as large as an entire page.

React components are JavaScript functions that return markup:

```
function MyButton() {

  return (

    <button>I'm a button</button>

  );

}
```

Now that you’ve declared `MyButton`, you can nest it into another component:

```
export default function MyApp() {

  return (

    <div>

      <h1>Welcome to my app</h1>

      <MyButton />

    </div>

  );

}
```

Notice that `<MyButton />` starts with a capital letter. That’s how you know it’s a React component. React component names must always start with a capital letter, while HTML tags must be lowercase.
