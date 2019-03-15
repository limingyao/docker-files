#!/bin/bash

docker run -itdP --name hive1.2 --hostname hive --link hadoop2.7:hadoop --link mysql5.7:mysql \
-p 9999:9999 -p 10000:10000 -v $HOME/.docker-data/hive:/data/hive:rw limingyao/hive1.2
