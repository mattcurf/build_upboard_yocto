#!/bin/bash

TEMPLATECONF=meta-up-board/conf source src/oe-init-build-env build_up-rt
cat <<EOF >> conf/local.conf 
LICENSE_FLAGS_WHITELIST = "commercial"
INHERIT += "own-mirrors"
BB_GENERATE_MIRROR_TARBALLS = "1"
SOURCE_MIRROR_URL = "file://$YOCTO_DOWNLOAD_CACHE"
EXTRA_IMAGE_FEATURES = "tools-sdk tools-debug tools-profile"
CORE_IMAGE_EXTRA_INSTALL += "rt-tests"
PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-rt"
EOF
