#!/bin/bash

echoerr() { echo "$@" 1>&2; }

prog_exists() {
    if ! command -v $1 &> /dev/null
    then
        echoerr $1 cannot be found
        exit 1
    fi
}

for prg in realpath docker id dirname
do
    prog_exists $prg
done

DIRNAME="$(dirname "$0")"
GIT_DIR="$(realpath "$DIRNAME")"/..

DOCKER_GIT_DIR="$GIT_DIR"/docker
DOCKER_VOLS_DIR="$DOCKER_GIT_DIR"/vols

CONF_DIR="$DOCKER_VOLS_DIR"/conf
LOGS_DIR="$DOCKER_VOLS_DIR"/logs
NOTEBOOK_DIR="$DOCKER_VOLS_DIR"/notebook


MYUID=$(id -u)
MYGID=$(id -g)

set -x

exec docker run -u $MYUID -it --rm --hostname localhost -p 8080:8080 -p 4040:4040 \
    -v "$CONF_DIR":/opt/zeppelin/conf \
    -v "$LOGS_DIR":/opt/zeppelin/logs \
    -v "$NOTEBOOK_DIR":/notebook \
    -v "$GIT_DIR":/diplodatos_bigdata \
    -e ZEPPELIN_LOG_DIR='/opt/zeppelin/logs' -e ZEPPELIN_NOTEBOOK_DIR='/notebook' \
    -e ZEPPELIN_INTERPRETER_CONNECT_TIMEOUT=120000 \
    --name diplodatos_bigdata diplodatos/bigdata:1.0
