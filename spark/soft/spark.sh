#!/bin/bash

export SPARK_HOME=/opt/spark/spark-2.2.3
export PATH=$SPARK_HOME/bin:$PATH

export SPARK_MASTER_IP=spark
export SPARK_WORKER_MEMORY=512m
export SPARK_DIST_CLASSPATH=$(hadoop classpath)

export SPARK_LOCAL_IP=spark
export SPARK_MASTER_HOST=spark
