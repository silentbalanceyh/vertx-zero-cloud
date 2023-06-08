#!/usr/bin/env bash
echo "--> 预处理：Database Storage"
# 数据库专用目录规范
<<comment
  官方推荐四个核心目录:
  1. /ssd,                用于存储TiKV数据
  2. /sharedssd:          用于存储PD数据
  3. /monitoring:         用于存储监控数据
  4. /backup:             用于存储TiDB Binlog和Backup数据
comment

mkdir -p storage/database/tidb/ssd/
mkdir -p storage/database/tidb/sharedssd/
mkdir -p storage/database/tidb/monitoring/
mkdir -p storage/database/tidb/backup/

mkdir -p storage/database/mysql/