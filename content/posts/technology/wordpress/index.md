---
title: "在本地计算机安装WordPress"
date: 2022-12-16T22:23:57+08:00
draft: false
# weight: 2
tags: ["WordPress"]
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
thumbnail: "images/dashboard.png"
description: " 通过Xampp安装WordPress及其所需要的各种软件非常方便，帮助你快速上手WordPress，构建出自己喜欢的个人站点。也可以完全手动安装Apache、php、mysql、WordPress这些软件，手动配置各项参数，可以更加了解这些软件是如何协同工作的"
---

####   安装  xampp、下载 WordPress

* 下载安装[xampp](https://www.apachefriends.org/index.html)，下载[WordPress](https://WordPress.org/)。把解压后的wordperss目录复制在xampp的htdocs目录下，这里为c:\xampp\htdocs\WordPress

* 启动xampp面板，选择 start  Apache、start mysql。如果有别的web服务器启动，需要先停止服务。比如本机自动启动caddy的话，终止caddy服务，解决端口冲突，因为这里有Apache启动。

#### 使用phpMyAdmin创建mysql数据库

* 打开浏览器，在地址栏输入localhost，此时会显示`Welcome to XAMPP for Windows `，点击屏幕顶部的`phpMyAdmin`，进入数据库设置面板。或者直接在地址栏输入`localhost/wordperss/phpMyAdmin`
* 选择左侧目录树顶部的`新建`，输入数据库名称，序规则选择 utf8mb4_general_ci。之后，点击“创建”按钮就可以完成数据库创建。选择左侧的数据库，再选权限标签，可以根据实际情况修改密码。

  ![](images/phpMyAdmin.png)
  ![](images/phpMyAdmin-2.png)
  ![](images/phpMyAdmin-3.png)



 #### 连接数据库

   在浏览器地址栏输入`localhost/WordPress` ，配置连接数据库的参数。需要输入前边创建的数据库名称、用户名(root)、密码。输入`localhost/wordperss`之后，地址栏地址变化为`localhost/wordperss/wp-admin/setup-config.php`,进入数据库参数设置页面。自己估计应该是在Apache的代理设置里做了路由匹配，把`/WordPress`直接映射为/WordPress/wp-admin/setup-config.php。
 ![](images/WordPress-setup-connect-database.png)  
 ![](images/WordPress-setup-create-database-2.png)
 ![](images/WordPress-setup-create-database-3.png)
  成功连接创建的数据库WordPress_db1后，WordPress已经可以和新建的数据库通讯了，点击左下角的[run the install]开始安装WordPress.

 #### 安装WordPress
  ![](images/WordPress-setup.png)
  ![](images/WordPress-installation.png)
  ![](images/WordPress-setup-create-database-4.png)

经过这一系列列的操作，最终把各项参数保存在新建的wp-config.php文件中。如果想重新学习安装流程，可以把wp-config.php删除，再把旧的数据库表删除，如下图提示：

![](images/WordPress-reinstall.png)

#### WordPress管理界面

登录WordPress的管理界面dashboard：https://localhost/WordPress/wp-admin

（在没有学会重置密码前，最好记录好数据库用户名、密码和站点登录的用户名和密码，时间长了可能会忘记）

![](images/dashboard.png)



下面就可以在dashborad里熟悉各种功能，比如下载和应用themes。

#### 使用xampp在本地安装WordPress总结

* WordPress是用php开发的基于Web(Apache)和数据库(mysql等)的内容管理系统(CMS)。而xampp是方便用户使用WordPress的本地集成环境。
* 利用xampp在本地安装WordPress总共有四步
  * 安装xampp、解压WordPress到htdocs
  * 利用phpMyAdmin创建数据库
  * 连接数据库，把所有连接参数保存在新建的wp-config.php文件里
  * 安装WordPress并登录管理面板，开始使用WordPress建立自己的站点

#### 手动安装Apache、php、mysql、WordPress  

通过Xampp安装WordPress及其所需要的各种软件非常方便，帮助你快速上手WordPress，构建出自己喜欢的个人站点。如果想知道背后的细节，有有必要自己手动安装所有的组件，实现同样的功能。从xampp提供的环境及整个安装流程，大概知道首先要配置Apache的相关配置文件，让Apache可以支持WordPress,或者说支持php，毕竟WordPress是由php制作的软件，然后由wordress去完成数据库的创建和连接，所有这些基础设施准备好之后，主角登场，开始安装WordPress。

* 安装设置Apache

  * 为什么要先安装Apache呢，因为WordPress是由php开发的基于浏览器的web应用，所有的功能都通过http请求完成。web服务器收到http请求后,对静态的资源直接回传给浏览器，动态资源由web服务器调用php引擎（比如php.exe），由php引擎执行完毕后把结果返回给web服务器，再由web服务器把网页传送给客户端的浏览器。
  * 配置Apache的配置文件，设置站点目录等。web服务器设置后之后，就可以运行php程序，让流程走起来。
  * 如果是在真实的云服务器设置自己的站点，一般会有相应的web服务器,也许就不需要自己安装，设置就好（有点懒，等购买了真实的域名和服务器部署完成后再来改写这篇文章）

  
  
  WordPress自带的readme.html文件其中一部分，看了这个就知道如何完成WordPress安装

~~~
Installation: Famous 5-minute install

    Unzip the package in an empty directory and upload everything.
    Open wp-admin/install.php in your browser. It will take you through the process to set up a wp-config.php file with your database connection details.
        If for some reason this does not work, do not worry. It may not work on all web hosts. Open up wp-config-sample.php with a text editor like WordPad or similar and fill in your database connection details.
        Save the file as wp-config.php and upload it.
        Open wp-admin/install.php in your browser.
    Once the configuration file is set up, the installer will set up the tables needed for your site. If there is an error, double check your wp-config.php file, and try again. If it fails again, please go to the WordPress support forums with as much data as you can gather.
    If you did not enter a password, note the password given to you. If you did not provide a username, it will be admin.
    The installer should then send you to the login page. Sign in with the username and password you chose during the installation. If a password was generated for you, you can then click on “Profile” to change the password.

~~~

---

#####  如何手动安装WordPress

###### 1.  手动安装WordPress之前的准备工作(系统环境)

- PHP version 7.4+
- MySQL version 5.7+ or MariaDB 10.2+
- HTTPS support
- 从官网下载 [WordPress](https://WordPress.org/download/) （Recommend PHP 7.4 or greater and MySQL 5.7 or MariaDB version 10.3 or greate）
- 把解压的WordPress目录使用FTP Client上传到站点服务器的Apache的htdocs目录下

###### 2. 创建MySQL数据库和数据库用户

   设置 MySQL 数据库名称,数据库用户名称, 密码

###### 3. 配置wp-config.php

 wp-config.php是让WordPerss连接数据库服务器的配置文件。首先把WordPress目录下的wp-config-sample.php重命名为wp-config.php。

* 使用编辑器打开wp-config.php文件。（这里编辑器使用vscode）
* 在文件中查找下面的内容，把文件中的 **database_name_here**, **username_here**, and **password_here**替换为新建立的MySql数据库对应的参数 。

  ~~~nginx
// ** MySQL settings - You can get this info from your web host ** // 

/** The name of the database for WordPress */

define( 'DB_NAME', 'database_name_here' );

/** MySQL database username */

define( 'DB_USER', 'username_here' );

/** MySQL database password */

define( 'DB_PASSWORD', 'password_here' );

/** MySQL hostname */

define( 'DB_HOST', 'localhost' );
  ~~~




##### 4. 运行安装WordPress的php脚本

 在浏览器输入yourdoman/wp-admin/install.php,打开WordPress安装页面

* 选择站点使用的语言后继续

![](images/WordPress-setup.png)

* 在下图所示的表单中填写站点基本信息

![](images/WordPress-installation.png))

- **Site Title**：  为WordPress 站点指定标题

- 设置 WordPress站点的用户名、密码、 邮箱 ，用来登录到WordPress Dashboard进行站点后台管理。

- 如果不想让搜索引擎索引搜索你的站点，选中`Discourage search engines from indexing this site`选项。

  设置完毕后点击左下角的`**Install WordPress**`按钮完成安装。

* 填写用户名和密码登录WordPress站点

