#!/usr/bin/env bash
# 虚拟机环境：Docker
# 启动
# minikube config set driver docker
minikube start --kubernetes-version=v1.24.1 --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'