#!/bin/bash

docker run -itdP --name hbase1.3 --hostname hbase -p 3181:3181 -p 8080:8080 -p 8085:8085 \
-p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 \
--link hadoop2.7:hadoop --link zookeeper3.4:zk \
-v $HOME/.docker-data/hbase:/data/hbase:rw limingyao/hbase1.3
