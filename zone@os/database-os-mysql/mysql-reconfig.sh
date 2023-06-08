#!/usr/bin/env bash
./mysql-stop.sh
cp my.cnf /opt/homebrew/etc/my.cnf
./mysql-start.sh