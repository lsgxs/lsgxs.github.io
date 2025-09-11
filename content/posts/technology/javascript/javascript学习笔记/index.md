---
title: "Javascript学习笔记"
slug: "javascript%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-08-14T07:00:32+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: " 变量的名称就是一段内存地址的名称，变量的值就是这段内存地址保存的内容。就好像一个盒子和盒子里面装的东西。 "
thumbnail: "images/boxes.png"
---

### javaScript学习笔记

#### 变量

```
We say variables contain values. This is an important distinction to make. Variables aren't the values themselves; they are containers for values. You can think of them being like little cardboard boxes that you can store things in.
```

变量的名称就是一段内存地址的名称，变量的值就是这段内存地址保存的内容。就好像一个盒子和盒子里面装的东西。

#### 数据类型

    * number（integer  or  float  or double）
   * string
   * boolean 
   * array
   * object  通过对现实世界对象特征的数据抽象组成一个具体的对象。这些特征通过{attribute: values，..}的数据结构来描述。
     理解javascript的数据类型：和其他类似C语言的数据类型不同，javascript使用动态数据类型，在声明变量时不必指定具体的数据类型，而是由编译器根据变量初始化时保存的值来动态判断变量所属的类型。比如：
         let  myName = "What is  your  name";
         let   lengthBox = 43;
         let   isCar = true;

   ----- c  like ----
    int  ibox= 43;
    目前标准的js使用let 来声明变量，早期使用的是var。

#### 变量的命名规则

* 首字符非数字和下划线(下划线是js内部保留使用)
* 使用具有一定语义的单词缩写组合来表示一个变量，首单词小写、后续单词首字母大写的驼峰结构

#### 字符串

   *  可以一致的使用双引号或者单引号来表示字符串。在你的代码中，根据自己的习惯选择统一使用双引号或者单引号，而不是两者的混合。 \
   *   反引号backstick可以用来在字符串中引用变量或者表达式，被称作模版字符串（template literal），通常用${}来包含变量或者表达式。反引号字符串可以自然书写，扩充到多行字符串，browser会认可换行符。如果要用常规的双引号或者单引号表示多行字符串换行，需要在对应的位置加转义字符\n表示换行符。
   * 字符串的连接
              a.常规的连接使用+号，如果是数值和字符串的直接链接，会自动转换为字符串再链接。
              b.可以使用template  literal  ，${}包含变量来实现连接字符串
   *  使用转义字符\来表示引号是普通的文本。
   * 使用string()和number（）两个函数在数值和字符串之间转换类型。
####  Javascript语句块
            （一）  条件语句。三种常用的条件语句
               1、if   ()   {}  elseif{}  else {}
               2、switch ()   {  case:  ...}
               3、三元运算符     conditon  ?   code1  :code2;
              (二）四种循环语句
             1、for  (a;b;c)
             2、for  of
             3、 while （）  
             4、do  while   和while()循环不同，至少执行一次循环体代码  
              5、break   ：调出循环语句块，执行循环代码块的下一条语句。
              6、continue： 跳过continue后边的语句，直接开始下一次循环。
      六、函数
            1、函数和方法
            2、函数声明的提升
            3、匿名函数和箭头函数
            4、函数变量的作用域和if {}、for{}变量作用域的差异
      七、事件
            1、HTML元素构建的用户界面，通过事件响应和处理实现良好的交互。大部分HTML  element都有一定的事件响应方法。比如button ，用户通过鼠标单击、双击、划过、划出等动作，编写对应的事件相应代码实现特定的功能。前面说过，一般是三个步骤实现事件响应处理：
           a.   const  btn = doument.querySelector("element-selector-name");  声明一个变量来引用指定的html  element。
           b.   btn.addEventListener("event-name",event-handler)         ；调用element的addEventListener方法，注册事件handler。
           c.    function   event-handler {}     ；编写事件响应处理代码。
           2、事件对象
             在事件响应句柄（事件响应方法function）中，可以使用event/evt/e等任意名称的事件对象作为参数，在事件处理代码中可以处理响应事件的element的更多信息。比如一下代码：
              const textBox = document.querySelector("#textBox");
              const output = document.querySelector("#output");
              textBox.addEventListener("keydown", (event) => {
                  output.textContent = `You pressed "${event.key}".`;
              });
           3、事件冒泡与事件捕获
              在多层嵌套的html元素中，如果这些元素都有相同的事件响应处理，默认会从最内层向最外层冒泡。如果需要阻止向外层的冒泡，在某个指定的html  element的事件中调用stopPropagation阻止向外层element冒泡。
              事件捕获则是正好相反，从最外层向内层。默认是冒泡机制，要使用捕获机制的话，则要在事件句柄注册时加上第三个参数：{capture:true}。比如：
                     document.body.addEventListener("click", handleClick, { capture: true });
                     container.addEventListener("click", handleClick, { capture: true });
                     button.addEventListener("click", handleClick);
            4、事件句柄  event  handler  
                实际上就是事件响应的函数名，在addEventListener("event-name",event-handler)时不用带后面的一对圆括号（），否则就会在加载文件时直接调用了这个事件处理函数。

#### javascript  对象

*  对象是属性和方法的集成块，向外界提供一定的功能。普通的变量和函数包装在对象里就称为属性和方法。这些属性的值可以是任何javascript类型的变量值，当然也可以是一个对象。

* javascript对象的创建和传统的oop不同，不需要从类开始，而是声明一个对象直接初始化就好，添加需要的属性、方法。
         const person = {
         name: ["Bob", "Smith"],
         age: 32,
         bio() {
           console.log(`${this.name[0]} ${this.name[1]} is ${this.age} years old.`);
          },
        introduceSelf() {
          console.log(`Hi! I'm ${this.name[0]}.`);
         },
      };

* 引用对象属性的两种方法dot  notation和bracket  notation（[ ]）。前者直接、可读性强。后者可以接受变量级别的引用。

* 构造函数的两个版本

  ```
  a.  function createPerson(name) {
                  const obj = {};
                  obj.name = name;
                  obj.introduceSelf = function () {
                  console.log(`Hi! I'm ${this.name}.`);
                  };
                 return obj;
             }
  b.  function Person(name) {
                    this.name = name;
                   this.introduceSelf = function () {
                   console.log(`Hi! I'm ${this.name}.`);
                    };
                  }
  
     const salva = new Person("Salva");
     salva.name;
     salva.introduceSelf();
     // "Hi! I'm Salva."
      
    const frankie = new Person("Frankie");
    frankie.name;
    frankie.introduceSelf();
    // "Hi! I'm Frankie."
       
  ```

  #### prototype
          a.每个javascript对象都有一个prototype属性，通过这个属性来设置该对象的原型，而这个prototype属性的值也是一个对象，这个对象也要自己的prototype，从而可以构建完整的原型链。
          b.通过Object.create和Object.assign两种常见方法来设置对象的原型。后者是把要创建的对象的构造函数和另外一个对象关联起来，从而拥有关联对象的原型。
            b1. Object.create(other-object)
              const personPrototype = {
                  greet() {
                  console.log("hello!");
                },
               };
      
            const carl = Object.create(personPrototype);
            carl.greet(); // hello!
      
            b2.  Object.assign
              const personPrototype = {
                greet() {
                console.log(`hello, my name is ${this.name}!`);
                },
              };
      
        function Person(name) {
      
             this.name = name;
        }
      
      Object.assign(Person.prototype, personPrototype);  构造函数Person的prototype属性（首字母大写的函数为构造函数）
  

===============

#### 在javascript中动态创建HTML element的基本方法：
Here we first create an h1 element with createElement(), set its textContent to equal the squadName property of the object, then append it to the header using appendChild()。 We then do a very similar operation with a paragraph: create it, set its text content and append it to the header. 

=================

#### 异步编程（asynchronous）

下面这段文章是MDN文档里介绍Node和Express的相关内容，复制在这里理解异步编程。

### [Using asynchronous APIs](https://developer.mozilla.org/en-US/docs/Learn_web_development/Extensions/Server-side/Express_Nodejs/Introduction#using_asynchronous_apis)

JavaScript code frequently uses asynchronous rather than  synchronous APIs for operations that may take some time to complete. A  synchronous API is one in which each operation must complete before the  next operation can start. For example, the following log functions are  synchronous, and will print the text to the console in order (First,  Second).

​          js                                                                  

```
console.log("First");
console.log("Second");
```

By contrast, an asynchronous API is one in which the API will start  an operation and immediately return (before the operation is complete).  Once the operation finishes, the API will use some mechanism to perform  additional operations. For example, the code below will print out  "Second, First" because even though `setTimeout()` method is called first, and returns immediately, the operation doesn't complete for several seconds.

​          js                                                                  

```
setTimeout(() => {
  console.log("First");
}, 3000);
console.log("Second");
```

Using non-blocking asynchronous APIs is even more important on Node than in the browser because *Node* applications are often written as a single-threaded event-driven  execution environment. "Single threaded" means that all requests to the  server are run on the same thread (rather than being spawned off into  separate processes). This model is extremely efficient in terms of speed and server resources. However, it does mean that if any of your  functions call synchronous methods that take a long time to complete,  they will block not only the current request, but every other request  being handled by your web application.

There are multiple ways for an asynchronous API to notify your  application that it has completed. Historically, the approach used was  to register a callback function when invoking the asynchronous API,  **which (这个非限制性定语从句的which是指代前边的先行词callback  funtion)**is then called when **the operation completes（这里指的是异步API的操作完成）** (this is the approach  used above).

```
意思是传统的方法是在调用异步API时注册一个回调函数（作为参数），当异步API的操作完成之后回调函数会被调用。
```



**Note:** Using callbacks can be quite "messy" if you have a sequence of dependent asynchronous operations that must be performed in order, because this  results in multiple levels of nested callbacks. This problem is commonly known as "callback hell".

**Note:** A common convention for Node and Express is to use error-first callbacks. In this convention, the first value in your *callback functions* is an error value, while subsequent arguments contain success data.  There is a good explanation of why this approach is useful in this blog: [The Node.js Way - Understanding Error-First Callbacks](https://fredkschott.com/post/2014/03/understanding-error-first-callbacks-in-node-js/) (fredkschott.com).

Modern JavaScript code more commonly uses [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) and [async/await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function) to manage asynchronous program flow. You should use promises where possible. If working with code that uses callbacks, you can use the Node.js [`utils.promisify`](https://nodejs.org/api/util.html#utilpromisifyoriginal) function to handle the callback → Promise conversion ergonomically.

  个人总结的关于异步编程的思想
   需要等待时间和资源的操作都可以设计为异步操作，不用等待异步API完成就直接返回主线程运行后边的的任务，而执行异步API调用时带有函数作为参数时，这个参数就是回调函数，异步API并不直接调用这个作为参数的回调函数，而是启动异步API的时候注册回调函数，由Javascript引擎通过事件队列来管理回调函数，等这个异步API的操作完成后就在主线程空闲时调用这个回调函数。

​    比如请求网络资源和读写文件的操作，都是需要一定时间等待，此时就可以调用异步API来完成操作，等这个操作完成后会由系统调用回调函数。运行异步API并把回调函数作为参数，就会注册这个回调函数，由系统决定何时调用这个回调函数。这种方法是传统的使用异步编程的方式，现在大多使用Promises和[async/await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function) 来实现。可以继续深入学习相关的知识。

       1、callback
       2、promiser
            const fetchPromise =fetch(
                 "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json",
                  );
    
             console.log(fetchPromise);
    
             fetchPromise.then((response) => {
              console.log(`Received response: ${response.status}`);
              });
    
              console.log("Started request…");
    
                    fetch  作为一个异步调用函数，返回一个promise对象。初步学习理解，自己感觉是由这个promise对象来链接异步执行的线程，保存异步线程的状态，最后调佣promise.then()这个函数与主线程通信。从设计的思想理解，是在主线程和子线程之间使用第三方promise来保持相互的通信。
    
       3、worker
       
    
#### javascript和Browser APIs、第三方API及其他javascript工具之间的关系

* javascript是内置于browser的编程语言
* browser API：是内置于浏览器的、在javascript之上的API。第三方公司开放的API的工作方式类似
* javascript library  :包含自定义函数的javascript文件，由开发者调用library中的函数实现特定功能。常见的有 jQuery, Mootools and React
* 使用FrameWork:和library的工作方式相反，这些设定好的javascript  framework,是有自己的一套工作流程，开发者编写的一部分代码被这些框架调用完成整个APP的功能。

Your code interacts with APIs using one or more JavaScript objects, which serve as containers for the data the API uses (contained in object properties), and the functionality the API makes available (contained in object methods)   使用Browser API实际上通过browser API中的对象，调用对象的方法和数据实现应用功能。
 第三方API的使用一般有几个步骤
   a.在第三方的站点注册并取得API  Key
   b.在自己的代码中链接第三方的js文件
   c.使用第三方API对象方法编程

         使用browser  api操作HTML 元素的基本思路
           const  btn   =   document.querySelecor("xxx");
           btn.xxxxxx
    
           const   inputxx=  document.createElement("")
            inputxxx.aut   设置新建的元素的属性
            把元素添加到父容器元素中



              javascript动态操作html element的css样式有两种方法，参考链接：（https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Manipulating_documents#manipulating_styles）


              1、设置html  element元素的style属性
    
              2、在.css文件中编辑sheetstyle表，然后使用代码动态添加(调用元素的setAttribute方法关联设置好的样式表)：
                           para.setAttribute("class", “element-class-namexxxx");


​           Elsewhere in the MDN learning area, we talked about the difference between static sites and dynamic sites. Most major modern websites are dynamic — they store data on the server using some kind of database (server-side storage), then run server-side code to retrieve needed data, insert it into static page templates, and serve the resulting HTML to the client to be displayed by the user's browser.

#### 表单及组件

       1、<form action="/my-handling-form-page" method="post">…</form>
       2、<form>中的小组件都有一个name 属性，通过用户的输入，最终形成name :value的数据，通过form组件submit中的post方法传递到后台的处理程序（javascript 、php、python 、ruby、java等）3、通过<fieldset>  和<legend>对表单组件进行合理分组，美化<form>的布局
       4、<lable>组件通过设置 for 属性为<input    type="text"  id="name1‘’>的id值，把<lable>和指定的<input>关联起来。可以在鼠标单击<lable>的时候切换到<input>组件，对于比较小的单选和复选按钮就比较方便，单击旁边的label就可以选择。
            < div>
               <label for="username">Name: <span aria-label="required">*</span></label>
               <input id="username" type="text" name="username" required />
            </div>
            //可以在<label>组件后添加*号，表示这<input>是必须要输入的数据项。
    
             As you can see in the examples, it's common practice to wrap a label and its widget with a <li> element within a <ul> or <ol> list. <p> and <div> elements are also commonly used. Lists are recommended for structuring multiple checkboxes or radio buttons.
    对于一组单选或者复选按钮，可以使用<fieldset>+<legend>进行分组；对于一组的checkbox 或者radiobutton，<input name="share-one-name">,name属性要相同。 对于分散性的表单组件，可以使用<p>  或者<div>来分组
    
       表单组件的美化
      1、text和button两类组件容易使用css设置样式
      2、列表类、日期、颜色、文件选择器不容易设置样式和彻底设置样式
      3、对表form数据的有效性验证( validation)、关闭浏览器默认的验证、设置自定义的验证等。
      4、表单数据的提交
           a. <form   action="url"   method="GET">  
                <input  type="text" id="key1" value="val1">
                <input  type="text" id="key2"  value="val2">
              </form>
              通过GET方法提交的表单中数据，是通过键值对的形式附加在URL的后边，比如：http://www.foo.com?key1=val1&key2=val2
               (The data is appended to the URL as a series of name/value pairs. After the URL web address has ended, we include a question mark (?) followed by the name/value pairs, each one separated by an ampersand (&). In this case, we are passing two pieces of data to the server:)
                Each time you want to reach a resource on the Web, the browser sends a request to a URL. An HTTP request consists of two parts: a header that contains a set of global metadata about the browser's capabilities, and a body that can contain information necessary for the server to process the specific request
                The GET method is the method used by the browser to ask the server to send back a given resource: "Hey server, I want to get this resource." In this case, the browser sends an empty body. Because the body is empty, if a form is sent using this method the data sent to the server is appended to the URL.


           b.  <form   action="url"   method="POST"> 
                </form>




​    
​              http请求分为两段:header  和body  。当使用get方法时，body就为空，数据以键值对的形式附加在url的后边发送到web服务器。如果要传送大一点的数据则要使用post方法，数据会附加在http请求的body部分。
​              先记录大概的思路，细节以后补齐，参考这个链接（https://developer.mozilla.org/en-US/docs/Learn/Forms/Sending_and_retrieving_form_data#on_the_client_side_defining_how_to_send_the_data），简单理解表单数据的传送路径是没问题的，要更深入可以参考tcp/ip协议。
​           c.关于http的总体认识：https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview
