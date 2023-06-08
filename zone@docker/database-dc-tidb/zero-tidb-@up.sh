#!/usr/bin/env bash
# 先生成模板
# helm template -f zero-tidb-helm.yaml compose > zero-tidb-compose.yml
# docker-compose -f zero-tidb-compose.yml pull
docker-compose -f zero-tidb-compose.yml up -d