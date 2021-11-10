#!/usr/bin/env sh

set -e

docker login -u $DOCKERHUB_USER -p $DOCKERHUB_TOKEN
docker push ayberkozgur/stm32-ci:1.0
#docker push ayberkozgur/uavcan-ci:1.0
