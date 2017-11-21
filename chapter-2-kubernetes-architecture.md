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
* Part 03, Kubernetes核心资源对象
* Part 04, 参考材料

[slide]

架构目标

----

The project is committed to the following (aspirational) design ideals:

Portable. Kubernetes runs everywhere -- public cloud, private cloud, bare metal, laptop -- with consistent behavior so that applications and tools are portable throughout the ecosystem as well as between development and production environments.
General-purpose. Kubernetes should run all major categories of workloads to enable you to run all of your workloads on a single infrastructure, stateless and stateful, microservices and monoliths, services and batch, greenfield and legacy.
Meet users partway. Kubernetes doesn’t just cater to purely greenfield cloud-native applications, nor does it meet all users where they are. It focuses on deployment and management of microservices and cloud-native applications, but provides some mechanisms to facilitate migration of monolithic and legacy applications.
Flexible. Kubernetes functionality can be consumed a la carte and (in most cases) Kubernetes does not prevent you from using your own solutions in lieu of built-in functionality.
Extensible. Kubernetes enables you to integrate it into your environment and to add the additional capabilities you need, by exposing the same interfaces used by built-in functionality.
Automatable. Kubernetes aims to dramatically reduce the burden of manual operations. It supports both declarative control by specifying users’ desired intent via its API, as well as imperative control to support higher-level orchestration and automation. The declarative approach is key to the system’s self-healing and autonomic capabilities.
Advance the state of the art. While Kubernetes intends to support non-cloud-native applications, it also aspires to advance the cloud-native and DevOps state of the art, such as in the participation of applications in their own management. However, in doing so, we strive not to force applications to lock themselves into Kubernetes APIs, which is, for example, why we prefer configuration over convention in the downward API. Additionally, Kubernetes is not bound by the lowest common denominator of systems upon which it depends, such as container runtimes and cloud providers. An example where we pushed the envelope of what was achievable was in its IP per Pod networking model.

[slide]

A running Kubernetes cluster contains node agents (kubelet) and a cluster control plane (AKA master), with cluster state backed by a distributed storage system (etcd).

[slide]

master

The Kubernetes control plane is split into a set of components, which can all run on a single master node, or can be replicated in order to support high-availability clusters, or can even be run on Kubernetes itself (AKA self-hosted).

[slide]

API Server

[slide]

Cluster state store

[slide]

Controller-Manager Server

[slide]

Scheduler

[slide]

node

----

The Kubernetes node has the services necessary to run application containers and be managed from the master systems.

[slide]

Kubelet

[slide]

Container runtime

[slide]

Kube Proxy

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


