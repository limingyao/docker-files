#!/bin/bash

docker run -itdP --name hadoop2.7 --hostname hadoop -p 8020:8020 -p 8042:8042 \
-p 8088:8088 -p 19888:19888 -p 50070:50070 \
-v $HOME/.docker-data/hadoop:/data/hadoop:rw limingyao/hadoop2.7
