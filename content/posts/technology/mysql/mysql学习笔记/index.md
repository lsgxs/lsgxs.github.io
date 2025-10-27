---
title: "MySQL学习笔记"
date: 2023-12-25T20:14:00+08:00
draft: false
# weight: 2
tags: [mysql]
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: true
hidemeta: false
comments: false
canonicalURL: "https://canonical.url/to/page"
disableHLJS: true # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
UseHugoToc: false
ShowCodeCopyButtons: true
thumbnail: "images/冰山.jpg"   
description: "简单记录MySQL的初步学习过程，从基础的软件包版本选择和下载，了解不同操作系统下的软件包选择，到最后的Windows平台的安装和数据库登录、学习初步的SQL基本语言，创建数据库和表，熟悉SQL语言" 
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

  把需要运行的多行语句保存在后缀名为.sql或者.txt的文件里，然后在Windows的CMD提示符下运行下面的命令：

  ```
  mysql  <  batch-file.sql
  mysql  -u  root -p   < batch-file.sql
  mysql  -u  root -p   < batch-file.txt
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

#### 连接到MySQL服务器

* 使用mysql和命令行参数。`mysql  -u  root  -p  `

* 在选项文件中保存连接参数。在选项文件的[client]分组中设置连接参数。

  ```
  [client]
  host=host_name
  user=user_name
  password=password
  ```
  
* 也可以使用环境变量
  
* 连接到MySQL服务器的几种写法
  
  ```
  #   command-line options  connect  string 
  mysql --host=localhost --user=myname --password=password mydb
  mysql -h localhost -u myname -ppassword mydb
  ```
  
  ```
  # URI-like  connect  string
  # MySQL Shell's shell.parseUri() and shell.unparseUri() methods can be used to deconstruct and assemble a URI-like connection # string. 
  mysql://user_name@localhost:3333
  ```
  
  ```
  # key-value  pairs  connect  string 
  {user:'user_name', host:'localhost', port:33065}
  ```
  
  

#### MySQL服务端程序

* mysqld   MySQL后端的服务器程序，启动后listen默认的3306端口，响应客户端的连接和数据请求。
* msyqld_safe  在Unix平台上推荐使用mysqld_safe启动mysqld服务，它添加了一些安全特性。

####  MySQL客户端程序

* **mysql**   最为常用的和后端服务交互的客户端程序。常见的启动方法（以Windows为例）

  ```bash
  mysql -u  username  -p   
  # 比如：
  mysql  -u  root  -p
  mysql  -u  root -p   < myCreate.sql
  ```

  使用`mysql  -u  root -p`连接到MySQL服务器之后，就可以在提示符下输入下面的命令行：

  ```
  # 在指定的目录下新建create databsase and create  tables语句，保存为myCreate.sql
  # 运行source  file-name.sql就可以运行保存在文本文件里的SQL语句.
  # On Windows, specify path name separators as / or \\
  source   myCreate.sql
  #或者
  \.  file_name.sql
  ```

* **exit   or quit**     (退出mysql命令行)

* **use   db_name**       （切换数据库）

* **mysqladmin**     MySQL  server的管理程序

 mysqladmin是一个独立的管理工具，带有众多的参数。比如常用的create  db_name  、drop  db_name

```
# 在windows的cmd下直接运行下面的命令，会创建名称为mydatabase的数据库。
# 但是并不会显示像mysql一样的命令提示符
mysqladmin  -u  root   -p   create  mydatabase
# 可以使用show databases的命令来显示刚创建的数据库
show  databases;
```

* **mysqldump  客户端的数据库备份程序mysqldump**。使用mysqldump可以进行数据库的逻辑备份，不适合特别大数据库备份。备份数据库的方法有三种

  ```
  # 备份指定数据库的表
  mysqldump [options] db_name [tbl_name ...]
  # 备份指定数据库
  mysqldump [options] --databases db_name ...
  # 备份所有数据库
  mysqldump [options] --all-databases
  ```

  **备份数据库的写法**

```
mysqldump -u root -p mydatabase > backup.sql
# 生成的backup.sql可以使用vscode打开浏览其结构和内容
```

```
backup.sql文件中通常还会包含一些数据定义语句（DDL）和数据操作语句（DML），用于创建表和插入初始数据。这些语句通常以--或/* */注释标记，以便区分结构定义和数据。在备份文件中，数据通常以INSERT语句的形式呈现，用于将数据插入到表中。这些INSERT语句可以在数据库中执行，以恢复数据到备份时的状态。因此，虽然backup.sql文件主要包含数据库的结构定义，但其中也包含了用于恢复数据的INSERT语句,可以使用这些语句来还原数据。
```

​    **还原数据库的写法**

```
mysql -u root -p mydatabase < backup.sql
```

* **mysqlimport  从文本文件导入数据到数据库**

  本来是使用LOAD  DATA 语句从外部数据源向数据库导入数据。mysqlimport提供了一个命令行接口，可以直接把文本文件中的数据导入到数据库表中。

  * LOAD  DATA  简单的用法示例

    ```bash
    #LOAD DATA can be used to read files obtained from external sources. For example, many programs can export data in comma-#separated values (CSV) format, such that lines have fields separated by commas and enclosed within double quotation #marks, with an initial line of column names. If the lines in such a file are terminated by carriage return/newline #pairs, the statement shown here illustrates the field- and line-handling options you would use to load the file: 
    
    LOAD DATA INFILE 'data.txt' INTO TABLE tbl_name
      FIELDS TERMINATED BY ',' ENCLOSED BY '"'
      LINES TERMINATED BY '\r\n'
      IGNORE 1 LINES;
    ```
    
  * To read the comma-delimited file, the correct statement is:      
    
    ```
    LOAD DATA INFILE 'data.txt' INTO TABLE table2
      FIELDS TERMINATED BY ',';
    ```
    
  * to  read  tab-delimited file  the  correct  statement  is:
  
    ```
    LOAD DATA INFILE 'data.txt' INTO TABLE table2
      FIELDS TERMINATED BY '\t';
    ```
  
    详细的用法参照MySQl官网关于[LOAD  DATA](https://dev.mysql.com/doc/refman/8.0/en/load-data.html)的介绍，并通过亲自实践可以熟练运用。
    
  * **mysqlimport**  
    
    ```bash
    # 其中的--local是在MySQL服务器所在的host读取文本文件，而不是从远程的client上读取文本文件。
    # --password后面没有跟随密码，可以在运行时提示输入密码。
    
    mysqlimport --local --user=root --password --database=your_database_name --fields-terminated-by=',' --lines-terminated-by='\n' --verbose --ignore-lines=1 "C:\Users\win10\your_text_file.txt"
    
    #使用mysqlimport命令时加上--verbose选项，它会以详细模式运行并显示操作过程中的信息。具体显示的内容可能包括以下几项：
    #    导入进度：它会显示正在导入的记录数和总记录数，以便了解数据导入的进度。
    #    导入记录的状态：对于每条导入的记录，它会显示成功导入或失败导入的信息。
    #    错误信息：如果在导入过程中遇到任何错误，它会显示错误信息，以便你可以了解问题的所在并进行相应的处理。
    #    导入速度：它还会显示数据导入的速度，让你了解数据导入的效率。
    #    总之，使用--verbose选项可以提供更多的反馈信息，帮助你更好地了解数据导入的过程和状态。
    ```
    
     
  

总结一下，本人作为普通数据库用户（比如web应用开发者），在localhost上需要熟悉简单的几个客户端命令。其他成百上千的命令行选项，需要在具体的项目中不断学习和实践才能熟悉。

```bash
# 运行myCreate.sql里保存的SQL语句
mysql -u  root -p   < myCreate.sql

#逻辑备份数据库
mysqldump  -u  root -p   >  myDump.sql

#如果想成为DBA,那除了日常的应用、管理、安全、优化之外，还要理解数据库本身的架构，源代码研究，进行更深入的研究了。
#从文本文件向数据库表中导入数据
mysqlimport --local --user=root --password --database=your_database_name --fields-terminated-by=',' --lines-terminated-by='\n' --verbose --ignore-lines=1 "C:\Users\win10\your_text_file.txt"
 
```

#### 数据库的备份和恢复

#### 优化

##### 优化SQL语句

##### 优化与索引

#### MySQL数据类型

#### MySQL函数和操作符

#### SQL语句

# MySQL Workbench

```bash
#  from  MySQL Workbench :https://dev.mysql.com/doc/refman/8.0/en/workbench.html

MySQL Workbench provides a graphical tool for working with MySQL servers and databases. MySQL Workbench fully supports MySQL versions 5.5 and higher.
The following discussion briefly describes MySQL Workbench capabilities. For more information, see the MySQL Workbench manual, available at https://dev.mysql.com/doc/workbench/en/.
MySQL Workbench provides five main areas of functionality:

    SQL Development: Enables you to create and manage connections to database servers. As well as enabling you to configure connection parameters, MySQL Workbench provides the capability to execute SQL queries on the database connections using the built-in SQL Editor. This functionality replaces that previously provided by the Query Browser standalone application.

    Data Modeling: Enables you to create models of your database schema graphically, reverse and forward engineer between a schema and a live database, and edit all aspects of your database using the comprehensive Table Editor. The Table Editor provides easy-to-use facilities for editing Tables, Columns, Indexes, Triggers, Partitioning, Options, Inserts and Privileges, Routines and Views.

    Server Administration: Enables you to create and administer server instances.

    Data Migration: Allows you to migrate from Microsoft SQL Server, Sybase ASE, SQLite, SQL Anywhere, PostreSQL, and other RDBMS tables, objects and data to MySQL. Migration also supports migrating from earlier versions of MySQL to the latest releases. 
```

​    

