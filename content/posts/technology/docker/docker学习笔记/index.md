---
title: "Docker学习笔记"
slug: "docker%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0"
date: 2025-10-04T18:24:13+08:00
draft: false
categories: ["默认分类"]
tags: ["默认标签"]
toc: true
description: "docker is an platform for  developer  to pack  the application and the environment  together ,and finally delivery  the docker  container  to customer to use "
thumbnail: "images/grass_sky.jpg"
---

# Docker 学习笔记

## 什么是docker

docker is a virtual platform for  developer  to pack  the application and the environment  together as  container ,and finally delivery  the docker  container  to customer to use . 

## 准备工作

prerequisite（docker  is originally from  `linux` ,so you must  install  windows  subsystem  for  `linux`）

- enable the two  options of `wsl`  and  virtual machine platform within  program function in  control  panel of windows.
- reboot  windows

## 如何安装docker

- install    `ubuntu` of the  newest ·`lts` version   from `microsoft`  store .please  refer  to  the `microsoft`  document  on how to  install `wsl`.  after download the installation execution file ,double the file to run setup ，remember to select the option of Use `WSL 2` instead of Hyper-V (recommended) and don't select the option of" Allow Windows Containers to be used with this installation",because we need to run docker under `wsl`.
- start   `wsl `  
  - you  should  use windows `powershell` to  run  `wsl`  command ,and then  run  into the shell of  `wsl` . remember  not  to  run  `ubuntu`  directly   which is installed  from   `microsoft`  store.    you should  use  `wsl2`  rather  than `wsl1`.if  you open the ` ubuntu` from windows  start  menu,the default  version  is `wsl1`,so you'd  better  run `wsl`  within  windows ` powershell`.

the core  concepts of  docker 

*  image

   like a configuration   template of the application and its  environment .

* container

  be a  instance  of  the configuration  template of the application and  environment .
  
  ```
  1. 镜像 (Image) = 产品设计图
  
      包含应用程序和运行环境
  
      标准化、不可变的模板
  
  2. 容器 (Container) = 产品实例
  
      根据设计图创建的运行实例
  
      每个实例都是独立的
  
  3. Docker Compose = 装配说明书
  
      定义多个产品如何组装成完整系统
  
      管理实例间的协作关系
  ```
  
  

## 使用docker构建基于`mysql`，`nginx`、`wordpress`的个人站点



## 理解 Docker 


### 1. 概念

#### 1.1 Docker Image（镜像）

- **定义**：是一个只读的模板，或者把它看做一个package,包含了运行应用所需的代码、运行时、库、环境变量和配置文件。
- **特点**：
  - 分层存储，每一层代表镜像构建过程中的一步，这些层是只读的。
  - 可以共享和版本化管理（通过标签）。
- **类比**：如同软件安装包（例如Office安装程序），已经包含了所有必要的文件，但尚未运行。

#### 1.2 Docker Container（容器）

- **定义**：是镜像的一个运行实例。容器进程运行于隔离的环境中，拥有自己的文件系统、网络和进程空间。
- **特点**：
  - 基于镜像创建，在镜像之上添加一个可写层（容器层）。
  - 容器内的修改是临时的，当容器删除后，这些修改也会丢失（除非使用数据卷）。
- **类比**：如同运行中的软件（例如打开的Word程序），有运行状态和数据。

#### 1.3 Image 与 Container 的关系

- 一个镜像可以创建多个容器，这些容器相互独立。
- 容器是镜像的一次运行，镜像静态存储，容器动态运行。

### 2. Dockerfile

#### 2.1 作用

- 用于定义镜像构建过程，包含一系列指令，每一条指令构建一层。

- 通过Dockerfile可以自定义镜像，包括基础镜像选择、文件复制、依赖安装、环境变量设置、启动命令等。

  ```
   作用：构建镜像的蓝图/说明书
   包含：环境配置、依赖安装、代码复制、启动命令
   结果：通过 docker build 生成 Docker Image
  ```

  

#### 2.2 常用指令

- `FROM`：指定基础镜像。
- `RUN`：执行命令，例如安装软件。
- `COPY` 或 `ADD`：复制文件到镜像中。
- `WORKDIR`：设置工作目录。
- `ENV`：设置环境变量。
- `EXPOSE`：声明容器运行时监听的端口。
- `CMD` 或 `ENTRYPOINT`：指定容器启动时运行的命令。

#### 2.3 示例

dockerfile

```
FROM python:3.9
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```



### 3. Docker Compose

#### 3.1 作用

- 用于定义和运行多容器Docker应用程序。通过一个YAML文件配置应用的服务、网络、数据卷等。

- 可以一键启动、停止、重建整个应用。

  ```
   作用：多容器应用编排工具
   功能：协调多个相关容器协同工作
   场景：Web应用 + 数据库 + 缓存等完整项目栈
  ```

  

#### 3.2 概念

- **服务（Service）**：一个服务代表一个容器，对应一个镜像。
- **项目（Project）**：由一组关联的服务组成，通常对应一个完整的应用（例如前端、后端、数据库）。

#### 3.3 示例

yaml

```
version: '3'
services:
  web:
    build: .
    ports:
      - "8000:8000"
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
```



### 4. 常用命令

#### 4.1 镜像相关

- `docker build -t [image_name] .`：构建镜像。
- `docker images`：列出本地镜像。
- `docker rmi [image_id]`：删除镜像。

#### 4.2 容器相关

- `docker run [options] [image]`：创建并启动容器。
  - 常用选项：`-d`（后台运行）、`-p`（端口映射）、`-v`（数据卷）、`-e`（环境变量）、`--name`（容器命名）。
- `docker ps`：查看运行中的容器。
- `docker stop [container_id]`：停止容器。
- `docker start [container_id]`：启动已停止的容器。
- `docker rm [container_id]`：删除容器。

#### 4.3 Compose 相关

- `docker-compose up -d`：启动所有服务（后台运行）。
- `docker-compose down`：停止并删除所有服务。
- `docker-compose logs [service]`：查看服务日志。

### 5. 实践建议

1. **从简单项目开始**：例如将一个静态网站或简单的Web应用容器化。
2. **逐步增加复杂度**：尝试多服务应用，比如带数据库的Web应用。
3. **学习优化**：例如使用多阶段构建减小镜像大小，合理使用数据卷持久化数据。

### 6. 常见问题排查

- 容器启动失败：查看日志 `docker logs [container_id]`。
- 进入容器调试：`docker exec -it [container_id] bash`。
- 检查网络：`docker network ls`，确保容器间网络连通。

希望这份笔记能帮助您巩固Docker的知识！实践出真知，动手操作是最好的学习方式。

#### 3. **Dockerfile**

- **作用**：构建镜像的蓝图/说明书
- **包含**：环境配置、依赖安装、代码复制、启动命令
- **结果**：通过 `docker build` 生成 Docker Image



### 从开发到部署

```
Dockerfile → docker build → Image → docker run → Container
```

### 多服务项目

text

```
多个Dockerfile → 多个Image → docker-compose up → 多个协同工作的Container
```

## 理解要点

### Image 与 Container 关系

- **一个 Image** 可以创建 **多个 Container**

- Image 是模板，Container 是实例

- Container = Image + 可写层 + 运行时状态

  Docker 的设计哲学就是：

  - **镜像包含一切**：应用代码、运行时、依赖、配置
  - **容器即进程**：启动容器就像启动一个进程
  - **声明式配置**：所有运行时配置通过命令行参数指定

  **从 Image 到 Container，只需要 `docker run` 这一个命令**



## 用简单的实例来理解Docker容器化整个项目过程



假设我们要构建一个简单的Django项目，并使用Docker进行容器化，同时使用Docker Compose来管理多个服务（比如Django和PostgreSQL）。

### 项目结构

假设项目结构如下：

text

```
my_django_app/
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── project/
    ├── manage.py
    └── ... (其他Django项目文件)
```



### 步骤

#### 1. 创建Dockerfile

Dockerfile用于构建Django应用的镜像。

Dockerfile

```
# 使用官方Python运行时作为基础镜像
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 复制当前目录（项目）内容到容器的/app目录
COPY . /app

# 安装所需的包
RUN pip install -r requirements.txt

# 暴露端口8000，以便外部访问
EXPOSE 8000

# 运行Django开发服务器
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```



#### 2. 创建docker-compose.yml

docker-compose.yml用于定义和运行两个服务：web（Django）和db（PostgreSQL）。

yaml

```
version: '3'

services:
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/app
    ports:
      - "8000:8000"
    depends_on:
      - db
    environment:
      DATABASE_URL: postgres://user:password@db:5432/myapp

volumes:
  postgres_data:
```



#### 3. 创建requirements.txt

确保在项目根目录有requirements.txt文件，包含Django和psycopg2（PostgreSQL适配器）等依赖。

text

```
Django>=3.2
psycopg2-binary>=2.9
```



#### 4. 配置Django项目

在Django项目的settings.py中，需要配置数据库连接，使用环境变量。

python

```
import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_DB', 'myapp'),
        'USER': os.environ.get('POSTGRES_USER', 'user'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD', 'password'),
        'HOST': 'db',  # 使用Compose中定义的服务名
        'PORT': 5432,
    }
}
```



#### 5. 构建并运行

在项目根目录（有docker-compose.yml的目录）运行：

bash

```
docker-compose up
```



这将构建web服务的镜像（如果还没有的话），并启动db和web两个容器。web容器将运行Django开发服务器，并监听8000端口。

#### 6. 执行数据库迁移

在另一个终端，运行：

bash

```
docker-compose exec web python manage.py migrate
```



#### 7. 访问应用

打开浏览器访问 http://localhost:8000，应该能看到Django欢迎页面。

### 深入细节

#### 数据持久化

在docker-compose.yml中，我们定义了一个卷`postgres_data`，用于持久化数据库数据。即使容器被删除，数据仍然保留。

#### 开发模式

上面的配置中，我们将主机上的项目目录挂载到容器的/app目录，这样在主机上修改代码时，容器内的代码也会实时更新，便于开发。

#### 生产环境

对于生产环境，我们需要调整一些配置，比如：

- 使用生产级的Web服务器（如Gunicorn）代替Django开发服务器。
- 设置静态文件服务。
- 使用环境变量文件（.env）来管理敏感信息。

### 总结

通过这个项目，我们实践了：

- 使用Dockerfile构建镜像
- 使用Docker Compose编排多服务容器
- 配置Django与PostgreSQL数据库连接
- 使用数据卷持久化数据

这只是一个起点，实际项目中还会有更多细节需要处理，但基本流程如此。希望这个实践帮助你加深对Docker的理解。

**完美总结**
