title: Chapter 5, Kubernetes包管理工具Helm
speaker: Wenbao Xu
url: https://github.com/xuwenbao/kubernetes-beginner-course
transition: slide
theme: moon

[slide]

# Kubernetes从入门到放弃
## 第五课 - Kubernetes包管理工具Helm
<small>分享人: Wenbao Xu</small>

[slide]

目录
----
* Part 01, Helm简介
* Part 02, Helm Charts
* Part 03, Helm安装与演示
* Part 04, 参考材料

[slide]

## Part 01, Helm简介

[slide]

## Kubernetes的隐喻

[slide]

## 数据中心操作系统
----
![数据中心操作系统](/img/kubernetes-in-datacenter.png)

[slide]

## Helm, Kubernetes的包管理
----
* yum in centos
* apt in ubuntu

[slide]

## Helm的能力
----
* 声明式定义复杂应用
* 更轻松更新应用
* 更简单地分享
* 更简单地应用回滚

[slide]

## Helm的本质
----
基于Kubernetes声明式定义配置的应用配置定制化与变体生成

[slide]

## Helm的实现机制
----
**参数化渲染**

[slide]

## Part 02, Helm Chart

[slide]

## Chart, Helm的安装包
----
Chart是一组相关的Kubrentes资源定义文件集合

[slide]

```
wordpress/
  Chart.yaml                   # A YAML file containing information about the chart
  LICENSE                          # OPTIONAL: A plain text file containing the license for the chart
  README.md                      # OPTIONAL: A human-readable README file
  requirements.yaml   # OPTIONAL: A YAML file listing dependencies for the chart
  values.yaml                # The default configuration values for this chart
  charts/                         # OPTIONAL: A directory containing any charts upon which this chart depends.
  templates/                  # OPTIONAL: A directory of templates that, when combined with values,
                                           # will generate valid Kubernetes manifest files.
  templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes
```

[slide]

example: https://github.com/kubernetes/charts/tree/master/stable/prometheus

[slide]

## Part 03, Helm安装与演示

[slide]

## 运行Charts Repo
----
官方Repo被墙, 需要自行启动一个Charts Repo, 参见: [charts.yml](examples/chapter-5/charts.yaml)

[slide]

安装可参照: https://docs.helm.sh/using_helm/#installing-helm

[slide]

```
# 初始化Helm RBAC设置
kubectl create -f helm-rbac-config.yaml
# 安装Helm
curl -SsL https://storage.googleapis.com/kubernetes-helm/helm-v2.7.2-linux-amd64.tar.gz -o /tmp/helm-v2.7.2-linux-amd64.tar.gz
tar -zxvf /tmp/helm-v2.7.2-linux-amd64.tar.gz -C /tmp
mv /tmp/linux-amd64/helm  /usr/local/bin/helm
chmod 755 /usr/local/bin/helm
# 初始化Helm
helm init --service-account tiller --stable-repo-url http://charts.kube-system.svc.cluster.local --tiller-image xuwenbao/tiller:v2.7.2
```

[slide]

```console
helm search
helm install stable/prometheus
helm list
helm status <release name>
helm history <release name>
helm delete <release name>
```

[slide]

## Part 04, 参考材料
----
* [Infrastructure As Code](https://martinfowler.com/bliki/InfrastructureAsCode.html)
* [Installing Helm](https://docs.helm.sh/using_helm/#installing-helm)
* [Kubernetes Charts](https://github.com/kubernetes/charts)


[slide]

## **大道至简**
<small>第五课, Kubernetes包管理工具Helm(完)</small>










