#!/usr/bin/env bash
source ../../.env.development
# 1. 删除 ServiceAccount, ClusterRole, ClusterRoleBinding
# 2. 删除 PVC / StorageClass
./ko-tidb-store.sh
# 3. 删除 Cluster
./ko-tidb-cluster.sh
./ko-tidb-cluster-init.sh