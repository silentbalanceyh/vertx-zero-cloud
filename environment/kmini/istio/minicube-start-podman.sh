#!/usr/bin/env bash
# 虚拟机环境：Podman
# 启动
# minikube config set driver podman
minikube config set rootless false
minikube start --kubernetes-version=v1.24.1 --driver=podman --container-runtime=cri-o --alsologtostderr -v=7 --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'