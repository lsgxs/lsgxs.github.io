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
    image: "images/冰山.jpg" # image path/url
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
* tuple
* dictionary
* set
#### operator

####  流程控制

* if

  if   exp1   :

  ​    elif  exp2: 

  ​    elif  expn:

  ​    else:

  

* while

  ```python
  # 用户输入一个数字，和9比大小，显示输入的数字比9大、小或者是猜中了。
  number = 9
  guess = input("please input  a number:")
  
  
  while test1:
  
      if guess == number:
          print('Congratulations, you guessed it.')
          # this causes the while loop to stop
          running = False
      elif guess < number:
          print('No, it is a little higher than that.')
      else:
          print('No, it is a little lower than that.')
  else:
      print('The while loop is over.')
      # while语句可以带else子语句，但是如果while语句块中遇到break时，else子语句不会被运行
      # 可以在此运行任何你想运行的任务   
  
  ```

* for

  ```python
  #这里只是用内置函数range()函数生成了一个包含数值的列表，实际上for..in 循环语句可以遍历包换任何对象的序列(sequence)。 
  #对于sequence中的每一个元素都运行一次for循环中的语句，这个sequence可以是range(num)、string、list、tuple、dictionary等。
  for i in range(1, 9):
      print(i)
  else:
      # 在python中，for语句可以带else子语句，但是如果for语句块中遇到break时，else子语句不会被运行
      print('The for loop is over')    
  ```

* break

  在循环语句中遇到break会结束当前的循环语句块。

* continue

  在循环语句块中遇到continue会跳过剩下的语句，直接进入一下个循环。

####  function

* 局部变量

  函数内部定义的变量称为局部变量，和函数之外定义的同名变量没有关系

  ```
  x = 40
  
  def func(x):
      print('x is', x)
      x = 3
      print('Change local x to', x)
  
  func(x)
  print('x is still', x)
  ```

  output:

  ```
  x is 40
  Changed local x to 3
  x is still 40
  ```

* 全局变量

  在python代码块中，如果要显式的使用全局变量，则可以使用global来表明：

  ```
  global   var_name
  ```

* 参数的类型

  * 默认参数
  * 位置参数
  * 关键字参数

####  module

函数是实现特定功能的代码段，达到重用一段代码的目的，那如果要重用多个函数，如何实现呢？这里就有了module这个概念，实际就是一个后缀名为.py的文件，里边包含各类变量、函数、类等对象。需要这些功能时，直接引用（import）这些module文件就可以了。

#### Package

有了大量的功能完备的module，如何分类组织组织这些modules呢？这里就有了packages的概念，包就相当于是Windows的目录和子目录，每个包下面都包含一个`__init__.py`文件，用来标识这个目录是一个包，包含若干个modules。而module文件里是各种变量、函数和类等所有名称的定义。有了这样的概念，在包和模块之间重用代码的方式有如下几种形式

* import   module_name
  * module_name.func_name(argn...)
* import   package_name/sub_package_name/module_name
* from   module_name  import     func_var_names
* from   pacakage_name/sub_package_name  import   module_name
* 就像在website里使用相对路径引用html文件方法一样，在python的当前module中引用其他package下的module也同样适用：

  * from  .  import  sibling_module_name

  * from  ..   import  other_module_name

  * from  ..  sub_package_name  import  other_module_name

总结一下：from 后面可以是package、package_subpackage_module    ，import后面可以是module、variable、function、class。但是能不能在import后直接跟一个package_name?下次确认一下再总结。

为了避免出现自己的module和第三方module的标识符冲突，建议直接使用import的引用形式，使用是使用module_name.object_name。这样就相当于有扩大了名称空间，不会出现变量、函数、对象等标识符重复的现象。就好像给学生的名字加了前缀：某校.某班级.学生姓名，这样就不会重复，如果重复，那就继续扩大引用的名称空间。

####  数据结构(data  structure)

除了基本的数值类型和字符串类型之外，在python中提供了四种数据复合的数据结构，分别是list、tuple、dictionary、set。其中前边三种数据类型都是有序的(sequence)，可以进行index(下标从0开始)和slice操作，也经常会使用for   x  in   sequences  语句进行遍历实现各种操作。

* list

  ```python
  # web  programming language list
  weblist = ['php', 'asp', 'jsp', 'javascript','java','ruby','python','go']
  ```

* tuple

  tuple有类似string的特征，就是定义之后不能被修改。

* dictionary

* set

####  class

在python中包括基本的数值和字符，以及复合的list、tupule、dictionary、set都是对象。

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

#### 异常的处理

使用try  ..except语句块来实现异常的处理

```python
try:
    text = input('Enter something ')
except EOFError:
    print(' you enter  ctrl+z and  enter')
except KeyboardInterrupt:
    print('You cancel the operation.')
else:
    #You can also have an `else` clause associated with a `try..except` block. 
    #The `else` clause is executed if no exception occurs.
    print('You entered {}'.format(text))
```

如果一个错误或者异常没有被处理，则系统会调用python默认的处理程序，显示一个错误信息，然后终止程序的运行。

也可以使用try  ..except..finally 语句块,在finally语句块中运行必须做的任务，比如释放打开文件时占用的资源等，也可以使用with语句来实现资源的自动释放。

####   Basic  Elements  For Learning  Python(include  other  Languages) 

~~~python
1、数据类型(number|int-float、string、list、tuple、dictionary、set)
2、运算符  (+、-、*、/、//、%、**、not、and、or)
3、表达式  (算数运算及逻辑运算及函数共同组成各类表达式)
4、语句块
5、流程控制 （if、for 、while）
6、函数 （def   function_name(argn...): ）
7、类及对象
8、Module及Package
9、异常处理
10、Library

对于大多数的编程语言，学习路径就是从数据类型到语句块，再到函数和模块，
如果是面向对象的编程语言，再加上OOP特征，最后扩大到标准库。
学习一门新的编程语言，同样可以使用这种方法和路径去学习和理解。
在学习了各种编程语言之后，你会发现，除了这些在多方面类似的语言特征外，
最核心的还是算法和数据结构，无论学习多少编程语言，最底层的还是算法和数据结构。
~~~

