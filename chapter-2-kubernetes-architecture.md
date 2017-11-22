title: Chapter 2, Kubernetes架构概述
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 第二课 - Kubernetes架构概述
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, Kubernetes的架构理念
* Part 02, Kubernetes的组件介绍
* Part 03, Kubernetes的部署
* Part 04, 参考材料

[slide]

## Part 01, Kubernetes的架构理念

[slide]

架构目标
----
* 可移植性, 可在各种环境中运行, 并保障行为一致, 包括公有云、私有云、裸金属、个人电脑.
* 通用性, 可在同一基础设施上运行所有主要类别的工作负载, 包括无状态应用、有状态应用、微服务应用、单体应用、批处理任务等.
* 灵活性, 可自由替换的内置功能.
* 扩展性, 可通过内置功能将你的额外能力暴露为相同标准的接口.
* 自动性, 面向自愈和自制能力设计的声明式API.
* 抽象性, 不受所依赖系统的限制, 提供统一的抽象定义. 如: 容器运行时、 云服务提供商、网络、存储. 

[slide]

一个Kubernetes集群包含若干Node节点(kubelet)、一个集群控制器(master)和一个用于保存集群状态的分布式数据存储系统(etcd).

[slide]

![Kubernetes架构](/img/k8s-arch.png)

[slide]

## Kubernetes的逻辑架构
----
1. Declare，Observe，React
2. 一个状态存储
3. 多个控制器

[slide]

![Kubernetes架构](/img/k8s-arch2.png)

[slide]

## Part 02, Kubernetes的组件介绍

[slide]

Master
----
集群控制器被划分为多个组件. 这些组件可以运行在一个master节点上, 也可多副本方式分布式运行, 甚至可以Kubernetes自己运行(AKA self-hosted).

[slide]

API Server
----
kube-apiserver用于暴露Kubernetes API。任何的资源请求/调用操作都是通过kube-apiserver提供的接口进行。

[slide]

Cluster state store
----
etcd是Kubernetes提供默认的存储系统，保存所有集群数据，使用时需要为etcd数据提供备份计划。

[slide]

Controller-Manager Server
----
kube-controller-manager运行管理控制器，它们是集群中处理常规任务的后台线程。逻辑上，每个控制器是一个单独的进程，但为了降低复杂性，它们都被编译成单个二进制文件，并在单个进程中运行。

[slide]

Scheduler
----
kube-scheduler 监视新创建没有分配到Node的Pod，为Pod选择一个Node。

[slide]

Node
----
Node节点中包含运行应用程序容器所必须的服务, 并被Master所管理.

[slide]

Kubelet
----
Kubernetes中最重要和最突出的控制器. 通过Pod和Node API控制容器执行层.

[slide]

Container runtime
----
每个节点都运行一个Container runtime(容器运行时). Kubelet不侵入基础容器运行时, 相反, Kubernetes通过定义CRI规范控制容器运行时, 保障其可插拔.   目前除Docker外, 还支持rkt、 cri-o和frakti.

[slide]

Kube Proxy
----
The service abstraction provides a way to group pods under a common access policy (e.g., load-balanced). The implementation of this creates a virtual IP which clients can access and which is transparently proxied to the pods in a Service. Each node runs a kube-proxy process which programs iptables rules to trap access to service IPs and redirect them to the correct backends. This provides a highly-available load-balancing solution with low performance overhead by balancing client traffic from a node on that same node.

Service endpoints are found primarily via DNS.

[slide]

Add-ons and other dependencies

----

A number of components, called add-ons typically run on Kubernetes itself:

DNS
Ingress controller
Heapster (resource monitoring)
Dashboard (GUI)

[slide]

Federation
----
联邦集群, 略 ...

[slide]

## Part 03, Kubernetes的部署

[slide]

## 使用kubeadm安装Kubernetes

[slide]

```
# 安装Docker
apt-get  update
apt-get  install -y docker.io
```

[slide]

```
# 安装kubelet kubeadm
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
```

[slide]

```
# 初始化Master
# 执行 swapoff -a 命令, 如出现 "running with swap on is not supported. Please disable swap" 错误
kubeadm init --pod-network-cidr=10.244.0.0/16
```

[slide]

```
# 复制并保存 init token 查看 pod 状态
kubectl get pods --all-namespaces
# 查看node状态
kubectl get nodes
kubectl describe node
```

[slide]

```
# 初始化网络
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.0/Documentation/kube-flannel.yml
# 查看Pod状态
kubectl get pods --all-namespaces
```

[slide]

## Part 04, 参考材料

[slide]

## **大道至简**
<small>第二课 - Kubernetes架构概述(完)</small>

