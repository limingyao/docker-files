#!/bin/bash

docker run -itdP --name zookeeper3.4 --hostname zookeeper -p 2181:2181 \
-v $HOME/.docker-data/zookeeper:/data/zookeeper:rw limingyao/zookeeper3.4
