#!/bin/bash

export JAVA_HOME=/opt/jdk/jdk-11
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar
export PATH=$JAVA_HOME/bin:$PATH
