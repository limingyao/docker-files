#!/bin/bash

docker run -itdP --name spark2.2 --hostname spark --link hadoop2.7:hadoop \
-p 4040:4040 -p 8080:8080 -p 8081:8081 -v $HOME/.docker-data/spark:/data/spark:rw limingyao/spark2.2

