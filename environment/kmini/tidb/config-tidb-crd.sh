#!/usr/bin/env bash
kubectl create -f zero-crd-tidb.yml
# 必须安装，否则无法在 minikube dashboard 中看到
helm install --namespace $ZC_TIDB tidb-operator pingcap/tidb-operator --version v1.3.6