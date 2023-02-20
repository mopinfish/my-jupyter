#!/bin/bash
PROJ_DIR=`pwd ${PWD%/*}`
echo $PROJ_DIR

IMAGE="my-jupyter"
TAG="latest"
CONTAINER="my-jupyter"
WORK_DIR="/home/jovyan/tmp/"
INSTALL_TIMEOUT=1800

# コンテナを起動
docker container run -e PIPENV_INSTALL_TIMEOUT="$INSTALL_TIMEOUT" --name "$CONTAINER" --rm -td "$IMAGE":"$TAG"

# ホスト -> コンテナにPipfile, Pipfile.lockを追加
docker container exec "$CONTAINER" mkdir ${WORK_DIR}
docker container cp ${PROJ_DIR}/src/notebook/Pipfile "$CONTAINER":${WORK_DIR}Pipfile
docker container cp ${PROJ_DIR}/src/notebook/Pipfile.lock "$CONTAINER":${WORK_DIR}Pipfile.lock

# コンテナでPipfile.lock更新
docker container exec --workdir ${WORK_DIR} "$CONTAINER" pipenv lock

# コンテナ -> ホストにPipfile.lockを取得
docker container exec "$CONTAINER" cat "$WORK_DIR"Pipfile | grep "osmnx"
docker container exec "$CONTAINER" cat "$WORK_DIR"Pipfile.lock | grep "osmnx"
docker container cp "$CONTAINER":"$WORK_DIR"Pipfile.lock "$PROJ_DIR"/src/notebook/Pipfile.lock

# コンテナを停止/削除
docker container stop "$CONTAINER"
