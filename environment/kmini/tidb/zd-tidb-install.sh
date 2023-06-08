#!/usr/bin/env bash
source ../../.env.development
# 1. 创建 ServiceAccount, ClusterRole, ClusterRoleBinding
# 2. 创建 PVC / StorageClass
./ok-tidb-store.sh
# 3. 创建 DB / Monitor / Initializer
./ok-tidb-cluster.sh
./ok-tidb-cluster-monitor.sh
./ok-tidb-cluster-init.sh