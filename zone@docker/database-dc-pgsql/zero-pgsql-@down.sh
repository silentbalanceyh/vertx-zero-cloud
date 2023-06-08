#!/usr/bin/env bash
docker-compose -f zero-pgsql-compose.yml down
rm -rf data/*