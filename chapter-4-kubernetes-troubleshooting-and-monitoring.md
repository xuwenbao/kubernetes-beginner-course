title: Chapter 4, Kubernetes 故障排查与监控
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 第四课 - Kubernetes 故障排查与监控
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, Kubernetes 故障排查
* Part 02, Kubernetes 日志查看
* Part 03, Kubernetes 监控
* Part 04, 参考材料

[slide]

## Part 01, Kubernetes 故障排查

[slide]

## Step 0, 检查kubelet进程状态
----
如果是通过静态Pod方式启动集群组件, 首先检查主/从节点上的kubelet进程状态

[slide]

```console
# 查看kubelet进程状态
systemctl status kubelet
# 确保kubelet随机启动
systemctl enable kubelet
# 查看kubelet日志
journalctl -f -u kubelet
```

[slide]

## 常见问题
----
* 静态Pod创建不成功, 静态Pod YAML定义错误
* 连接不到API Server, API Server未启动完成或状态异常

[slide]

## Step 1, 检查Node状态
----
```console
# 查看节点状态
kubectl get nodes
# 查看节点 Conditions
kubectl describe node master
```

[slide]

## 常见问题
----
* 节点NoReady
* Conditions状态为False

[slide]

## Step 2, Pod问题排查
----
- kubectl apply/create 报错
    - apiserver 和 etcd 
    - 排查参数和yaml（api 版本）
        ```console
        Deployment in version "v1beta2" cannot be handled as a Deployment:
        no kind "Deployment" is registered for version "apps/v1beta2"
        ```
    - 通过 kubectl api-versions 确认当前集群支持的版本
    - 排查 Admission 设置
- 提交 Deployment 成功，但通过 kubectl 看不到 pod
    - 确认 controller-manager 状态

[slide]

- Pod 一直是 Init:XX 状态
    - 排查 init-container 
- Pod 一直是 Pending 状态 
    - 通过 kubectl describe 查看 event，确认具体原因
- Pod 一直是 ContainerCreating 状态
    - 确认镜像以及镜像仓库（墙）
- Pod 一直 CrashLoopBackOff
    - 确认镜像的 command 以及 arg 设置正确
    - 通过 kubectl log/kubectl log --previous 查看具体的日志错误
    - 通过 docker 排查

[slide]

## Kubernetes Debug Container
----
- [Propose a feature to troubleshoot running pods](https://github.com/kubernetes/community/pull/649)
- https://github.com/kubernetes/kubernetes/pull/46243
- Kubernetes 1.9

```console
kubectl debug -c debug-shell --image=debian target-pod -- bash
```

[slide]

## Step 3, **网络问题排查**

[slide]

## Pod的网络状态
----
* 每个Pod拥有独立的虚拟IP
* Pod之间可以直接互通，不需要 NAT
* 节点可以和Pod直接互通，不需要 NAT
* Pod看到的自己 IP 应该和其他Pod看到的一样

[slide]

## 网络故障排查
----
*  确认同一主机上的 pod 网络是否互通，否，排查本机网络 arp, iptables
*  确认跨主机 pod 网络是否互通
*  确认 dns 服务是否正常
*  确认请求 Service ClusterIP 是否正常 （排查 Service iptables) 
*  确认 pod 到 apiserver 请求是否正常
*  确认出 pod 请求公网是否正常
 
[slide]

## 终极排查方法

[slide]

**Fucking Google It!**

[slide]

## Part 02, Kubernetes 日志

[slide]

## Container Log
----
- Container stdout/stderr
- Docker Logger Driver (syslog, **journal, json-file**)
- Log Sidecar
    ```yanl
    name: logsidecar
    image: busybox:1.27.1
    args: [/bin/sh, -c, 'tail -n+1 -F /var/log/logdir/logfile']
    ```

[slide]

## Kubectl log
----
- Kubelet log api
    - https://nodeip:10250/logs/pods/   
- Pod log: /var/log/containers/<pod_name>_<pod_namespace>_<container_name>-<container_id>.log

[slide]

## Part 03, Kubernetes 监控

[slide]

![80%](https://github.com/kubernetes/community/raw/33160bede67e7355f123d8c3ba121f71a7a01411/contributors/design-proposals/monitoring_architecture.png?raw=true)

[slide]

## Kubernetes 监控涉及的组件
----
1. Cadvisor
2. Kubelet Stats/Metrics API
3. Heapster
4. 自定义监控数据和自动伸缩
4. Kube-state-metrics
5. Prometheus
6. Grafana

[slide]

## Cadvisor
----
- https://github.com/google/cadvisor
- http://nodeip:4194/
    - ContainerState
    - PodState
    - ImageFS 

[slide]

## Kubelet State API
- https://nodeip:10250/stats/
    - /container/
    - /summary/
- https://nodeip:10250/metrics/ 
- 数据项
    - filesystem
    - network
    - cpu
    - memory

[slide]

## Heapster
----
- Backend(Sinks)
    -  elasticsearch
    -  influxdb
    -  kafka
    -  opentsdb
    -  stackdriver

[slide]

## Kube-state-metrics 
----
生成新的 metrics

[slide]

## 自定义监控数据和自动伸缩
----
- [Arbitrary/Custom Metrics in the Horizontal Pod Autoscaler](https://github.com/kubernetes/features/issues/117)
- 基于自定义 API 机制

[slide]

## Prometheus
----
- Metrics Type
- Metrics Data Model(Label)
- Metrics SDK(Kubelet,etc..)
- Metrics Storage
- Metrics Query
- AlertManager
- Web UI

[slide]

## Part 04, 参考材料
----
* [How to collect and graph Kubernetes metrics](https://www.datadoghq.com/blog/how-to-collect-and-graph-kubernetes-metrics/)
* [Run Heapster in a Kubernetes cluster with an InfluxDB backend and a Grafana UI](https://github.com/kubernetes/heapster/blob/master/docs/influxdb.md)
* [Kubernetes监控之Heapster介绍](http://dockone.io/article/1881)

[slide]

## **大道至简**
<small>第四课 - Kubernetes 故障排查与监控(完)</small>


