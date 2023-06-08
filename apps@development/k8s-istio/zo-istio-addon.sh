#!/usr/bin/env bash
kubectl apply -f istio/samples/addons/grafana.yaml
kubectl apply -f istio/samples/addons/jaeger.yaml
kubectl apply -f istio/samples/addons/prometheus.yaml
kubectl apply -f istio/samples/addons/kiali.yaml
kubectl apply -f istio/samples/addons/extras/zipkin.yaml