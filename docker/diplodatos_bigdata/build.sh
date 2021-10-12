#!/bin/bash

set -x

IM_VERSION=1.0
IM_BASE_VERSION=0.10.0

IM=diplodatos/bigdata:$IM_VERSION

IM_BASE=apache/zeppelin:$IM_BASE_VERSION

# Stop all containers
for c in $(docker ps -a -q  --filter ancestor=$IM)
do
    docker stop $c
done

if [ -n "$(docker images -q $IM 2>/dev/null)" ]
then
    docker image rm $IM
fi

docker build --tag $IM -f dockerfiles/Dockerfile context

