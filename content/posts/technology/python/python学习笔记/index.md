---
title: "Python学习笔记"
date: 2024-02-09T09:49:02+08:00
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
cover:
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

#### python的几个主要数据类型

* numeric

  * int
  * float 

* string

  * python没有单个的字符类型，指定一个字符串的索引位置就获得一个字符。

* list

  * 字符串和list的共同的几个特点，它们统称为sequence数据类型，可以indexd和sliced,也可以concatenate。

  * 在对字符串进行sliced操作时，使用str[start:end]的书写形式，start是包含在内的，而end是不包含的。

  * 常用的方法append

#### operator

#### expression

####  variable

####  function

####  module

#### Package

包就相当于是Windows的目录和子目录，moudel就是一个后缀名为py的python源文件。而module文件里是各种变量、函数和类等所有名称的定义。有了这样的概念，在包和模块之间重用代码的方式有如下几种形式

* import   module_name

* import   package_name/sub_package_name/module_name

* from   module_name  import     func_var_names

* from   pacakage_name/sub_package_name  import   module_name

* 就像在website里使用相对路径引用html文件方法一样，在python的当前module中引用其他package下的module也同样适用：

  * from  .  import  sibling_module_name

  * from  ..   import  other_module_name

  * from  ..  sub_package_name  import  other_module_name

总结一下：from 后面可以是package、package_subpackage_module    ，import后面可以是module、variable、function、class。但是能不能在import后直接跟一个package_name?下次确认一下再总结。

####  数据结构(data  structure)

除了基本的数值类型和字符串类型之外，在python中提供了四种数据复合的数据结构，分别是list、tuple、dictionary、set。其中前边三种数据类型都是有序的(sequence)，可以进行index(下标从0开始)和slice操作，也经常会使用for   x  in   sequences  语句进行遍历实现各种操作。

* list

  ```
  # web  programming language list
  weblist = ['php', 'asp', 'jsp', 'javascript','java','ruby','python','go']
  ```

  

* tuple

  tuple有类似string的特征，就是定义之后不能被修改。

* dictionary

* set

####  class

#### 输入和输出（input and output)

常见的输入输出方式有两种，一种是通过用户的输入来读取数据，然后显示在用户界面上。另外一种是通过对文件的操作实现输入(read from  file)和输出(write  to file )。

* input()和 print()。通过python内置的这两个函数实现输入和输出。

  ```python
  # 提示用户输入
  str1 = input("please  input you  login  account:")
  print("your  username is ",str1)
  ```
  
* 文件的操作

  * open
    * r 读取模式  （read）
    * w  写模式 （write）
    * a  追加模式 （append）
    * b  以二进制模式打开（binary）
    * t 已文本模式打开（text）
    
  * write 
  
    ```python
    # Open for 'w'riting
    f = open('poem.txt', 'w')
    # Write text to file
    f.write(poem)
    # Close the file
    f.close()
    ```
  
    
  
  * close
