#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

cd poky
source oe-init-build-env 
bitbake upboard-image-sato
#bitbake upboard-image-sato -c populate_sdk

