title: Chapter 0, Docker简介
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 预备课 - Dokcer简介
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, 什么是容器
* Part 02, 什么是Docker
* Part 03, 演示
* Part 04, 拓展
* Part 05, 作业

[slide]

## Part 01, 什么是容器

[slide]

容器本质上是将操作系统管理的资源划分到孤立的组中, 在孤立的组中平衡有冲突的资源使用需求.

组中包含一个或*若干*与普通操作系统进程毫无差别的应用进程, 通过namespace进行资源隔离, 并通过cgroup实现资源限制.

![Docker in Namespace](/img/docker-in-namespace.png "Docker in Namespace")

[slide]

Linux内核实现namespace的主要目的之一就是实现轻量级虚拟化(容器)服务. 在同一个namespace下的进程可以感知彼此的变化, 而对外界的进程一无所知. 这样就可以让容器中的进程产生错觉, 仿佛自己置身于一个独立的系统环境中. 资源隔离包括:
* UTS, 主机名与域名隔离
* IPC, 信号量、消息队列和共享内存隔离
* PID, 进程编号隔离
* Network, 网络设备、网络栈、端口等隔离
* Mount, 文件系统隔离
* User, 用户和用户组隔离

[slide]

## 进阶

----

Docker使用namespace最基本的操作系统调用:

```c
int clone(int (fn)(void ), void *child_stack, int flags, void *arg);
```

[slide]

## 容器相对于虚拟机的优点

* 隔离, 进程级的资源隔离
* 资源, 运行的是不完整的操作系统(尽管它们可以), 占用资源更少
* 复用, 在云硬件(或虚拟机)中可以被复用, 就像虚拟机在裸机上可以被复用
* 速度, 秒级甚至毫秒级分配, 虚拟机则需要几分钟

[slide]

## Part 02, 什么是Docker

[slide]

## Docker出现之前, 已有的容器技术

----

* OpenVZ
* FreeBSD Jails
* Zones
* Parallels

[slide]

> 为什么Docker更火热?

[slide]

## Docker官方标语

----

Docker - **Build**, **Ship**, and **Run** Any App, Anywhere

[slide]

## 关键点是Docker镜像

----

* **Build**, Dockerfile、镜像分层机制, 统一可复现可重用的生成方式
* **Ship**, 镜像仓库, Docker Reigstry、Docker Hub、Harbor ..., 便捷的获取方式
* **Run**, 运行镜像, UnionFS、Namespace、CGroup ..., 隔离的运行环境




