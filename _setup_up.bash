#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

TEMPLATECONF=meta-up-board/conf source src/oe-init-build-env build_up
cat <<EOF >> conf/local.conf 
LICENSE_FLAGS_WHITELIST = "commercial"
INHERIT += "own-mirrors"
BB_GENERATE_MIRROR_TARBALLS = "1"
SOURCE_MIRROR_URL = "file://$YOCTO_DOWNLOAD_CACHE"
EXTRA_IMAGE_FEATURES = "tools-sdk tools-debug tools-profile"
CORE_IMAGE_EXTRA_INSTALL += "rt-tests"
#DISTRO_FEATURES_append = " systemd"
#DISTRO_FEATURES_remove = "x11 wayland"
#VIRTUAL-RUNTIME_init_manager = "systemd"
EOF
