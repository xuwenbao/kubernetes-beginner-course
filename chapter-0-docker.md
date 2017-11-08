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
* Part 03, 手动打造一个Docker
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

<small>像不像java?</small>

[slide]

## 关键点是Docker镜像

----

* **Build**, Dockerfile、镜像分层机制, 统一可复现可重用的生成方式
* **Ship**, 镜像仓库, Docker Reigstry、Docker Hub、Harbor ..., 便捷的获取方式
* **Run**, 运行镜像, UnionFS、Namespace、CGroup ..., 隔离的运行环境

[slide]

## Docker的隐喻

----

**集装箱改变世界**

[slide]

* Part 03, 手动打造一个Docker

[slide]

## 进阶

----

```shell
# 安装Docker及其他工具, 操作系统Ubuntu 16.04

apt-get update

apt-get install -y ebtables socat apt-transport-https bash-completion ntp wget bridge-utils cgroup-tools tree

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'

apt-get update

apt-cache policy docker-engine
apt-get install -y docker-engine
```

[slide]

```shell
# 了解Docker Image内部机制

# 模拟Docker创建镜像目录
mkdir /var/lib/xocker/
mkdir /var/lib/xocker/image

# 下载Demo容器镜像 busybox
docker pull busybox:glibc

# 另存镜像为tar包, 并解压
cd /tmp
docker save busybox:glibc -o busybox.tar
mkdir busybox
tar -xvf busybox.tar -C busybox/

# 查看镜像配置文件
cat  manifest.json | python3 -m json.tool

# 查看layer内容
cd 47f54add1c481ac7754f9d022c2c420099a16e78faf85b4f2926a96ee40277fe
# 解压layer内容, 查看文件内容
tar -xvf layer.tar
# 构造一个假的镜像
mv 47f54add1c481ac7754f9d022c2c420099a16e78faf85b4f2926a96ee40277fe /var/lib/xocker/image/busybox
```

[slide]

```shell
# 实现文件系统隔离(无联合文件系统)

# 备份
cp -r /var/lib/xocker/image/busybox/ /var/lib/xocker/image/busybox.bak
# 文件系统隔离
chroot /var/lib/xocker/image/busybox/ /bin/sh
# 执行 rm -rf *, 然后退出看看效果
# 恢复回来
cp -r /var/lib/xocker/image/busybox.bak /var/lib/xocker/image/busybox
```

[slide]

```shell
# 实现文件系统隔离(联合文件系统 aufs)
mkdir -p /var/lib/xocker/mnt/1
mkdir -p /var/lib/xocker/mnt/1-data
mkdir -p /var/lib/xocker/mnt/1-init
mkdir -p /var/lib/xocker/mnt/1-init/etc/ && mkdir -p /var/lib/xocker/mnt/1-init/proc && echo "hello" > /var/lib/xocker/mnt/1-init/etc/myinit && tree /var/lib/xocker/mnt/1-init
mount -t aufs -o dirs=/var/lib/xocker/mnt/1-data:/var/lib/xocker/mnt/1-init:/var/lib/xocker/image/busybox none /var/lib/xocker/mnt/1
chroot /var/lib/xocker/mnt/1 /bin/sh
touch /tmp/test.data
rm /etc/myinit
```

[slide]

```shell
# 网络隔离

# 准备一个网桥
brctl addbr xocker0
ip addr add 172.18.0.1/24 dev xocker0
ip link set dev xocker0 up

# 准备 veth peer
ip link add dev veth0_1 type veth peer name veth1_1
ip link set dev veth0_1 up
ip link set veth0_1 master xocker0
ip netns add netns_test
ip link set veth1_1 netns netns_test
ip netns exec netns_test ip link set dev lo up
ip netns exec netns_test ip link set veth1_1 address 02:42:ac:11:00:01
ip netns exec netns_test ip addr add 172.18.0.2/24 dev veth1_1
ip netns exec netns_test ip link set dev veth1_1 up
ip netns exec netns_test ip route add default via 172.18.0.2

# 创建具有网络与文件系统隔离的容器
cgcreate -g cpu,cpuacct,memory:/test
cgexec -g "cpu,cpuacct,memory:/test"  ip netns exec netns_test unshare -fmuip --mount-proc chroot "/var/lib/xocker/mnt/1" /bin/sh -c "/bin/mount -t proc proc /proc && /bin/sh"
```

[slide]

## 参考材料
----
* Docker容器与容器云
* Docker源码分析
* [linux 网络虚拟化: network namespace简介](http://cizixs.com/2017/02/10/network-virtualization-network-namespace)

[slide]

## **大道至简**
<small>预备课(完)</small>


