#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

git clone -b pyro git://git.yoctoproject.org/poky.git
cd poky
git clone -b pyro git://git.yoctoproject.org/meta-intel.git
git clone -b pyro git://git.openembedded.org/meta-openembedded 
git clone -b pyro https://github.com/emutex/meta-up-board
TEMPLATECONF=meta-up-board/conf source oe-init-build-env

cat <<EOF >> conf/local.conf 
LICENSE_FLAGS_WHITELIST = "commercial"
INHERIT += "own-mirrors"
SOURCE_MIRROR_URL = "file://$YOCTO_DOWNLOAD_CACHE"
BB_GENERATE_MIRROR_TARBALLS = "1"
EXTRA_IMAGE_FEATURES = "tools-sdk tools-debug tools-profile"
CORE_IMAGE_EXTRA_INSTALL += "rt-tests"
PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-rt"
EOF
