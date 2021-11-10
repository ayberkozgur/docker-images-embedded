#!/usr/bin/env sh

set -e

# stm32-ci
cp -r scripts/ images/stm32-ci/
docker build --no-cache --tag ayberkozgur/stm32-ci:1.0 images/stm32-ci/
rm -rf images/stm32-ci/scripts/

# uavcan-ci
docker build --no-cache --tag ayberkozgur/uavcan-ci:1.0 images/uavcan-ci/
