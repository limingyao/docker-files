#!/bin/bash

docker run -itdP --name kafka_2.12-0.10.2.0 --hostname kafka --link zookeeper3.4:zk \
-p 9092:9092 -v $HOME/.docker-data/kafka:/data/kafka:rw limingyao/kafka_2.12-0.10.2.0
