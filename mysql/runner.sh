#!/bin/bash

if [ ! -d $HOME/.docker-data/mysql ];then
    mkdir -p $HOME/.docker-data/mysql
    touch $HOME/.docker-data/mysql/my.cnf
fi

docker run -d --name mysql5.7 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root \\
-v $HOME/.docker-data/mysql/my.cnf:/etc/mysql/my.cnf -v $HOME/.docker-data/mysql/data:/var/lib/mysql mysql:5.7
