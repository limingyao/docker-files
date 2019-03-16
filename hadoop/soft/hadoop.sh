#!/bin/bash

export HADOOP_HOME=/opt/hadoop/hadoop-2.7.5
export PATH=$HADOOP_HOME/bin:$PATH
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export TEZ_HOME=/opt/tez/tez-0.9.1
export TEZ_JARS=$TEZ_HOME
export TEZ_CONF_DIR=/opt/hadoop/hadoop-2.7.5/etc/hadoop/tez-site.xml
export HADOOP_CLASSPATH=${HADOOP_CLASSPATH}:${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*
