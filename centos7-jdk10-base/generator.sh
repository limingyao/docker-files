#!/bin/bash

if [ ! -f "./soft/jdk-10.0.2_linux-x64_bin.tar.gz" ]; then
    echo "./soft/jdk-10.0.2_linux-x64_bin.tar.gz not exist"
    echo "please see README.md to download jdk-10.0.2_linux-x64_bin.tar.gz"
    exit 1
fi

cat > Dockerfile <<EOF
FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/jdk
ADD ./soft/jdk-10.0.2_linux-x64_bin.tar.gz /opt/jdk/
ADD ./soft/jdk.sh /etc/profile.d/

EOF
