#!/bin/bash

#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8

TEMPLATECONF=meta-up-board/conf source src/oe-init-build-env build_up
bitbake-layers add-layer ../src/meta-openembedded/meta-filesystems
bitbake-layers add-layer ../src/meta-openembedded/meta-python
bitbake-layers add-layer ../src/meta-openembedded/meta-networking
bitbake-layers add-layer ../src/meta-virtualization

cat <<EOF >> conf/local.conf 
LICENSE_FLAGS_WHITELIST = "commercial"
INHERIT += "own-mirrors"
BB_GENERATE_MIRROR_TARBALLS = "1"
SOURCE_MIRROR_URL = "file://$YOCTO_DOWNLOAD_CACHE"
EXTRA_IMAGE_FEATURES = "tools-sdk tools-debug tools-profile"
CORE_IMAGE_EXTRA_INSTALL += "rt-tests"
DISTRO_FEATURES_append = " systemd virtualization kvm kubernetes"
#DISTRO_FEATURES_remove = "x11 wayland"
VIRTUAL-RUNTIME_init_manager = "systemd"
IMAGE_INSTALL_append = "  docker docker-contrib connman connman-client"
PREFERRED_PROVIDER_virtual/kernel = "linux-intel"
# PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
PREFERRED_VERSION_linux-intel = "4.19%"
"
EOF
