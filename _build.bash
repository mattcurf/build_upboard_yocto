#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8;

echo "Building ..."
source src/oe-init-build-env build_up
export MACHINE=up-board
bitbake upboard-image-sato
bitbake upboard-image-sato -c populate_sdk
