#!/usr/bin/env bash
kubectl delete -n $ZC_TIDB secret zero-tidb-secret
kubectl delete tidbinitializer $ZC_TIDB-initializer -n $ZC_TIDB