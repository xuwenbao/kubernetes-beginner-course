title: Chapter 3, Kubernetes API Spec(Part 1)
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 第三课 - Kubernetes API Spec(Part 1)
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, Kubernetes API概述
* Part 02, Kubernetes的组件介绍
* Part 03, Kubernetes的部署
* Part 04, 参考材料

[slide]

## Part 01, Kubernetes API概述

[slide]

## YAML 简介
----

>YAML  is a human-readable data serialization language. It is commonly used for configuration files, but could be used in many applications where data is being stored or transmitted. 

- 空格缩进表示层级关系，不支持 TAB 
- : 用来分割 key/value
- \- 表示数组元素，每行一个，也可以用方括号（\[\] ）和 逗号（,）来区分。
- 字符串可以不用引号，也支持 " 和 '
- 可以用 \--- 区隔文档，把多个文档合并到同一个文件中
- 支持多行字符输入，通过 | 保留换行符，或者 > 折叠换行
- 支持锚点标记（&）和参考标记（\*）避免重复
- \# 表示注释 
- 是 json 格式的超集

[slide]

```yaml
# YAML Example
invoice: 34843
date   : 2001-01-23
bill-to: &id001
    given  : Chris
    family : Dumars
    address:
        lines: |
            458 Walkman Dr.
            Suite #292
        city    : Royal Oak
        state   : MI
        postal  : 48046
ship-to: *id001
product:
    - sku         : BL394D
      quantity    : 4
      description : Basketball
      price       : 450.00
    - sku         : BL4438H
      quantity    : 1
      description : Super Hoop
      price       : 2392.00
tax  : 251.42
total: 4443.52
comments: >
    Late afternoon is best.
    Backup contact is Nancy
    Billsmer @ 338-4338.
```

[slide]

## API数据交换格式
----
* JSON
* [Protobuf](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/protobuf.md) 

[slide]

## API Client Libraries
----
* [Go(Officially-supported)](github.com/kubernetes/client-go/)
* [Python(Officially-supported)](github.com/kubernetes-incubator/client-python/)
* [Java(Officially-supported)](github.com/kubernetes-client/java)
* [dotnet(Officially-supported)](github.com/kubernetes-client/csharp)
* [非官方API列表](https://kubernetes.io/docs/reference/client-libraries/)

[slide]

## API操作类型
----
* 创建(Create)
* 更新(Replace Patch)
* 读取(Get List Watch)
* 删除(Delete)

[slide]

## API Top Level元素
----
* apiVersion, API Group(v1,batch/v1,apps/v1beta1等)
* kind, Object类型(Pod, Service, Namespace等), 也可是list或simple类型
* metadata, Object元数据(name, namespace, labels等)
* spec, Object详细描述的主体部分
* status, Object的状态信息

[slide]

## API Group设计目标
----
* 拆分单个 v1 API 成多个模块化分组, 每个分组可以独立地启用/禁用. 未来可以把单体API Server拆分成多个更小的组件.
* 支持每个模块化的分组有独立的多版本, 可以让每个分组有不同的演进速度.
* 支持在不同分组中存在同样的类型, 可以支持稳定版本的API在原分组中, 同时实验性的API变化可以在实验分组中.
*  支持API插件机制的基础.
*  "Keeping the user interaction easy. For example, we should allow users to omit group name when using kubectl if there is no ambiguity." ?

[slide]

## API Group 与 kind(v1.8)
----
* v1(Pod|ReplicationController|Endpoints|Service|ConfigMap|Secret|Volume|PersistentVolumeClaim|StorageClass)
* apps/v1beta1(Deployment)
* apps/v1beta2(StatefulSet)
* batch/v1(Job)
* batch/v1beta1(CronJob)
* extensions/v1beta1(ReplicaSet|Ingress)
* extensions/v1beta2(DaemonSet)

[slide]

## metadata, Object元素数据
----
* namespace, 对象所属的命名空间, 如不指定, 对象将会被置于名为"default"的系统命名空间中
* name, 对象名字, 在一个命名空间中应具备唯一性
* lables, 标签
* annotations, 注解, 键和值都为字符创的map
* uid, 系统为每个对象生成的唯一ID
* resourceVersion, 系统为每个对象生成的内部版本号, 字符串类型
* creationTimestamp, 系统记录创建对象的时间戳
* deletionTimestamp, 系统记录删除对象的时间戳
* selfLink, 通过API访问Object自身的URL

[slide]

## status, 记录对象在系统中的当前状态
----


[slide]

参考材料
----
* [Kubernetes API Reference v1.8](https://kubernetes.io/docs/api-reference/v1.8/)
* [Supporting multiple API groups](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md)
