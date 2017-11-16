title: Chapter 1, Kubernetes概念概述
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 第一课 - Kubernetes概念概述
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, Kubernetes的前生
* Part 02, Kubernetes的今世
* Part 03, Kubernetes核心资源对象
* Part 04, 参考材料

[slide]

## Part 01, Kubernetes的前生

[slide]

## Kubernetes思想起源: Google SRE团队

----

* 主要工作, 运维在分布式集群管理系统上运行的具体业务服务(service)
* 团队构成, 标准软件开发工程师(50%)
            同时具有开发技能和其他技能(了解UNIX系统与网络知识)工程师(50%)
* 工作目标, 业务服务(service)的可靠性、可靠性、可靠性!

[slide]

## SRE团队背景造就的倾向

----

将基本的运维工作全部消除, 全力投入在研发任务上. 因为整个系统应该可以自主运行, 可以自动修复问题.
终极目标是整个系统趋向于无人化运行, 而不仅仅是自动化某些人工流程.

[slide]

## Google生产环境: SRE视角

* 物理服务器(machine), 代表具体的硬件(有时候也代表一个VM虚拟机)
* 软件服务器(server), 代表对外提供服务的软件系统

为了将硬件故障与实际业务服务用户隔离开来, 物理服务器上可以运行任何类型的软件服务器. Google并不会使用专门的物理服务器运行专门的软件服务器.

[slide]

## 管理物理服务器的系统管理软件, Borg

Borg是一个分布式集群操作系统, 负责在集群层面管理任务编排工作.

* 任务. 任务可以是无限运行的软件服务器, 或者是批量任务. 每个任务可以由多个实例组成(task).
* BNS(Borg名称解析系统), BNS名称(例如: /bns/<集群名>/<用户名>/<任务名>/<实例名>)用作任务实例间的连接. 
* 任务声明资源, 在任务配置文件中声明需要的具体资源(例如: 3CPU核心, 2GB内存等)

![Borg架构](/img/borg-arch.png)

[slide]

## Part 02, Kubernetes的今世

[slide]

## Kubernetes为何而生
<small>Google开源Kubernetes的时机</small>
----

* 容器技术成熟, 越来越多的开发者对容器产生兴趣
* 云计算的发展, IaaS模式趋向稳定. 云计算厂商转向应用支撑领域, 寻找新盈利点

[slide]

## What is Kubernetes?

----

Kubernetes is an open-source platform designed to automate deploying, scaling, and operating application containers.
With Kubernetes, you are able to quickly and efficiently respond to customer demand:
* Deploy your applications quickly and predictably.
* Scale your applications on the fly.
* Roll out new features seamlessly.
* Limit hardware usage to required resources only.

[slide]

## Kubernetes的声明式定义

> 声明式编程让我们去描述我们想要的是什么，让底层的软件/计算机/等去解决如何去实现它们。

Kubernetes is not a mere orchestration system. In fact, it eliminates the need for orchestration. The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. In contrast, Kubernetes is comprised of a set of independent, composable control processes that continuously drive the current state towards the provided desired state. It shouldn’t matter how you get from A to C. Centralized control is also not required; the approach is more akin to choreography. This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

[slide]

## Kubernetes的架构

![Kubernetes架构](/img/k8s-arch.png)

[slide]

## Part 03, Kubernetes核心概念介绍

[slide]

## Pod, the smallest deployable object in the Kubernetes object model.

----

Pod是Kubernetes最小的部署单元, 包含一个或多个紧密相关的业务容器. 
多容器被绑定调度到同一个节点, 且可共享:
* 一个唯一的网络IP
* 挂载的存储资源

![Pod的组成与容器的关系](/img/Pod.png)

[slide]

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: webserver
    labels:
        app:  demo
spec:
    containers:
    - name: webserver-container
        image: python:3.6
        command: ['python', '-m', 'http.server']
        ports:
        - containerPort: 8000
```

[slide]

## 多容器设计模式 - Example 1, Sidecar(跨斗)

![Sidecar](Pod - Sidecar containers.png) 

[slide]

## 多容器设计模式 - Example 2, Ambassador(外交官)

![Sidecar](Pod - Ambassador containers.png) 

[slide]

## 多容器设计模式 - Example 3, Adapter(适配器)

![Sidecar](Pod - Adapter containers.png) 

[slide]

## Label

----

Label是可附加到各种资源(Pod、Node、Service等)上的 key = value 形式的键值对
* 一个资源对象可以定义任意数量的Label
* 一个Label也可以被添加到任意数量的资源对象上

[slide]

## 通过Label Selector查询和筛选拥有某些Label的资源对象

* name = redis-slave: 匹配所有具有标签 name=redis-slave的资源对象
* env != production: 匹配所有不具有标签 env = production 的资源对象
* name in (redis-master, redis-slave): 匹配所有具有标签 name = redis-master 或 name = redis-slave 的资源对象
* name not in (php-frontend): 匹配所有不具有标签 name = php-frontend 的资源对象

[slide]

```console
kubectl get pods -l env=prod
kubectl get pods -l app
kubectl get pods -l !app
kubectl get pods -l 'app, env != dev'
```

[slide]

## Relication Controller/ReplicaSet

----

声明某种Pod的预期副本数量, 并保障在任意时候Pod数量都符合预期值. RC/RS定义包括如下几个部分:
* Pod期待的副本数量
* 用于筛选目标Pod的Label Selector
* 当Pod的副本数量小于预期数量的时候, 用于创建新Pod的Pod模板(template)

[slide]

## Service

Service是对一组提供相同功能的Pods的抽象，并为它们提供一个统一的入口.
* 拥有固定的内部访问域名与IP
* 自动实现服务发现与负载均衡
* 配合Deployment等资源来保证后端容器的正常运行

[slide]

## Service类型

* ClusterIP：默认类型，自动分配一个仅cluster内部可以访问的虚拟IP
* NodePort：在ClusterIP基础上为Service在每台机器上绑定一个端口，这样就可以通过<NodeIP>:NodePort来访问改服务
* LoadBalancer：在NodePort的基础上，借助cloud provider创建一个外部的负载均衡器，并将请求转发到<NodeIP>:NodePort

> 可以将已有的服务以Service的形式加入到Kubernetes集群中来，只需要在创建Service的时候不指定Label selector，而是在Service创建好后手动为其添加endpoint

[slide]

## Deployment

**时间原因待续**

[slide]

## 资源对象一览

Base
* Pod
* PodPreset

[slide]

Controllers
* ReplicaSet
* Replication Controller
* StatefulSet
* DaemonSet
* Job
* Cron Job
* Horizontal Pod Autoscaler (HPA)

[slide]

Network
* Service
* Ingress
* Netwrok Policy

[slide]

Storage
* Volume
* Persistent Volume
* Persistent Volume Claim
* StorageClasses

[slide]

Configuration
* ConfigMap
* Secret
* ServiceAccount
* ResourceQuota

[slide]

Environment
* Namespace

[slide]

RBAC
* Role
* RoleBinding

[slide]

## 参考材料

* [SRE: Google运维解密](https://book.douban.com/subject/26875239/)
* [Kubernetes权威指南(第2版)](https://book.douban.com/subject/26902153/)
* [Borg, Mesos, Omega, and Kubernetes](https://share.weiyun.com/0a023c9256358752236f840f6cd31482)
* [What is Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

[slide]

## **大道至简**
<small>第一课 - Kubernetes概念概述(完)</small>
