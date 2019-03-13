#!/bin/bash

docker run -itdP --name etcd3.3 --hostname etcd \
-v $HOME/.docker-data/etcd:/data/etcd:rw limingyao/etcd3.3
