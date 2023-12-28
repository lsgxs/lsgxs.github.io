---
title: "MySQL学习笔记"
date: 2023-12-25T20:14:00+08:00
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
    image: "images/冰山.jpg" 
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
---

#### 获取指定版本的MySQL

* 根据使用的操作系统：unix /linux、windows  、macOS，选择下载对应版本的[MySQL](https://dev.mysql.com/doc/refman/8.0/en/getting-mysql.html)
* 使用MD5等校验工具，检测下载的MySQL与官网是否一致。

#### 在Windows下安装MySQL

在Windows下安装mysql的最简单的方法是使用[MySQL  installer](https://dev.mysql.com/downloads/installer/),建议在64位的Windows下使用MySQL。使用MySQL installer安装MySQL时，有四个安装类型选择：

* **development**
* **server only**
* **Dedicated**
* **Manual**

#### 在Windows的cmd下操作MySQL

* 连接到MySQL数据库服务器

  ```
  mysql  -u  root -p
  
  #或者指定hostname
  #当然在本机不需要指定-h  127.0.0.1，只是需要了解这种格式。mysql服务默认使用3306端口，所以在指定-h hostname 时不许要指定端口号，主机名称也不需要加引号包裹。
  mysql  -h  127.0.0.1   -u  root  -p    
  mysql  -h  10.190.21.23   -u  root  -p
  ```

  ```
  /* -h host的默认值是localhost*,/
  mysql  -h  localhost  -u  root -p
  
  /*下面这行命令就是省略了-h  localhost*/
  mysql  -u  root  -p
  ```

  

* 在cmd下退出MySQL

  ```
  quit
  ```

  

* 在cmd的MySQL提示符下输入SQL query语句

  * 多行自由输入。需要换行时回车，提示符会变更为`->`,直到你输入结束符号`;`

  * 在输入多行语句时，中途想取消语句输入，输入`\c`就可以退出语句输入，回到提示符下。

  * MySQL的提示符状态

    | Prompt   | Meaning                                                      |
    | -------- | ------------------------------------------------------------ |
    | `mysql>` | Ready for new query。可以开始新的查询                        |
    | `->`     | Waiting for next line of multiple-line query。多行查询语句的下一行 |
    | `'>`     | Waiting for next line, waiting for completion of a string that began   with a single quote (`'`)。多行语句中，期待右侧的单引号，形成一个完整的字符串。 |
    | `">`     | Waiting for next line, waiting for completion of a string that began    with a double quote (`"`)。多行语句中，期待右侧的双引号，形成一个完整的字符串。 |
    | ``>`     | Waiting for next line, waiting for completion of an identifier that            began with a backtick (```) 。多行语句中，期待右侧的反引号。 |
    | `/*>`    | Waiting for next line, waiting for completion of a comment that began           with `/*` |

    * 多行语句经常出现忘记语句末尾输入分号的情况，直接敲入回车键，以为语句会执行，结果显示的是一个`->`提示符。没关系，在新的一行输入分号，回车就可以运行。

* MySQL的批处理模式

  把需要运行的多行语句保存在后缀名为.sql或者.txt的文件里，然后在MySQL提示符下运行下面的命令：

  ```
  mysql  <  batch-file.sql
  ```

  使用批处理模式在MySQL下运行脚本文件，有几个好处：

  * 一次脚本任务编写，多次运行

  * 便于保存和修改特定任务的脚本，如果脚本中部分代码出错，修改后保存就可以重新运行，不必像多行输入模式下重新输入。

  * 如果一个脚本的输出内容很多，可以使用`|more`来分页浏览

    ```
    mysql   < batch-file  |more
    ```

  * 可以把一个脚本执行的结果输出在一个文件中，进一步处理。

    ```
    mysql  <  batch-file  > mysql.out
    ```

    

#### MySQL的相关程序

  * mysqld是MySQL的后台主程序，只有启动了它，客户端程序才能连接到MySQL数据库服务器。   

    ```
    -- 可以在Windows的CMD下运行这个命令。
    -- mysqld拥有众多的参数
    mysqld  --verbose  --help  
    ```
    
  * 连接到MySQL服务器的客户端程序
    
    * myslq
    * mysqladmin
    * mysqldump
    * mysqlimport

* 运行MySQL程序时指定的参数或者选项
  * 指定参数使用单横线`-`或者双横线`--`，后边跟参数。比如:`mysql  -u  root -p`
  * 指定选项一般有三种方法，优先级从低到高。
    * 通过环境变量
    * 通过选项文件（选项文件内容的格式，请查看MySQL官方文档[Using Option Files](https://dev.mysql.com/doc/refman/8.0/en/option-files.html)）
    * 通过命令行选项

           MySQL programs determine which options are given first by examining environment variables, then by processing option files, and then by checking the command line. Because later options take precedence over earlier ones, the processing order means that environment variables have the lowest precedence and command-line options the highest. 


​          On Windows, MySQL programs read startup options from the files   shown in the following table, in the specified order (files     listed first are read first, files read later take   precedence).

**Option Files Read on Windows Systems **

| File Name                                                 | Purpose                                                      |
| --------------------------------------------------------- | ------------------------------------------------------------ |
| `%WINDIR%\my.ini`,                `%WINDIR%\my.cnf`       | Global options                                               |
| `C:\my.ini`, `C:\my.cnf`                                  | Global options                                               |
| `*`BASEDIR`*\my.ini`,                `*`BASEDIR`*\my.cnf` | Global options                                               |
| `defaults-extra-file`                                     | The file specified with                [`--defaults-extra-file`](https://dev.mysql.com/doc/refman/8.0/en/option-file-options.html#option_general_defaults-extra-file),                if any |
| `%APPDATA%\MySQL\.mylogin.cnf`                            | Login path options (clients only)                            |
| `*`DATADIR`*\mysqld-auto.cnf`                             | System variables persisted with                [`SET                 PERSIST`](https://dev.mysql.com/doc/refman/8.0/en/set-variable.html) or                [`SET                 PERSIST_ONLY`](https://dev.mysql.com/doc/refman/8.0/en/set-variable.html) (server only) |

在Windows中，按照表格中列出的选项文件的先后顺序读取选项文件，后读取的文件优先级高。

