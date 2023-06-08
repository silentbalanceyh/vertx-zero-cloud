#!/usr/bin/env bash
docker-compose -f zero-mysql-8-compose.yml stop
rm -rf data/*