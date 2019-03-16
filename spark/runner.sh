#!/bin/bash

docker run -itdP --name spark2.2 --hostname spark --link hadoop2.7:hadoop --link hive1.2:hive \
-p 8080:8080 -v $HOME/.docker-data/spark:/data/spark:rw limingyao/spark2.2

