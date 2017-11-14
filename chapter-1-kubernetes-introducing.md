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

* 任务
* BNS
* 任务声明资源

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

## Pod

[slide]

## Label

[slide]

## Service

[slide]

## Relication Controller/ReplicaSet

[slide]

## Deployment

[slide]

## Namespace

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
