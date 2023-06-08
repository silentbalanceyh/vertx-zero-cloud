#!/usr/bin/env bash
kubectl port-forward -n $ZK_NS svc/$ZC_TIDB-tidb 4000 > logs/tidb-database-4000.log
kubectl port-forward -n $ZK_NS svc/$ZC_TIDB-grafana 1202:3000 > logs/tidb-grafana-1202.log
kubectl port-forward -n $ZK_NS svc/$ZC_TIDB-prometheus 1203:9090 &> logs/tidb-prometheus-1203.log