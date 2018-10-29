#!/bin/bash

docker run -itdP --name kafka-manager --hostname kafka-manager \
-p 9901:9901 --link zookeeper3.4:zk limingyao/kafka-manager
