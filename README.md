# Kubernetes从入门到放弃

## 课程安排

-  [预备课：Docker原理简介](chapter-0-docker.md)
-  [第一课：Kubernetes 概念概述](chapter-1-kubernetes-introducing.md)
-  [第二课：Kubernetes 架构概述](chapter-2-kubernetes-architecture.md)
-  [第三课：Kubernetes 的 API Spec](chapter-3-kubernetes-api-spec.md)
-  [第四课：Kubernetes 的应用案例](chapter-4-kubernetes-application-example.md)
-  [第五课：Kubernetes 的包管理工具Helm](chapter-5-helm.md)

## 运行课件方式

```console
# 编译课件镜像
docker build -t kube-ppt:v1 .
# 运行课件镜像
docker run -d -p 8080:8080 kube-ppt:v1
```

查看课件内容访问: http://localhost:8080
