#!/bin/bash

if [ -z "$YOCTO_DOWNLOAD_CACHE" ]; then
	echo "Error: YOCTO_DOWNLOAD_CACHE environment variable is not set" 
	exit -1
fi

export IMAGE_NAME=ubuntu_16_yocto
export RUN_ARGS="--rm -v `pwd`:`pwd` -e YOCTO_DOWNLOAD_CACHE=$YOCTO_DOWNLOAD_CACHE -v $YOCTO_DOWNLOAD_CACHE:$YOCTO_DOWNLOAD_CACHE -e "CI_SOURCE_PATH=`pwd`" -t $IMAGE_NAME"

# Create Docker image
if [ -z $(docker images -q $IMAGE_NAME) ]; then
   echo "Building image ..."
   docker build -t $IMAGE_NAME docker	
fi

if [ ! -d "src" ]; then
   git clone -b sumo git://git.yoctoproject.org/poky.git src
   cd src 
   git clone -b sumo git://git.yoctoproject.org/meta-intel.git
   git clone -b sumo git://git.openembedded.org/meta-openembedded 
   git clone -b sumo git://git.yoctoproject.org/meta-virtualization
   git clone -b sumo git://git.yoctoproject.org/meta-security
   git clone -b sumo https://github.com/meta-qt5/meta-qt5
   git clone -b sumo https://github.com/mattcurf/meta-up-board.git
   cd ..
fi

if [ ! -d "build_up" ]; then
   docker run $RUN_ARGS /bin/sh -c 'cd $CI_SOURCE_PATH; ./_setup_up.bash'
fi

# Build it
echo "Building ..."
docker run $RUN_ARGS /bin/bash -c 'export LC_ALL=en_US.UTF-8; export LANG=en_US.UTF-8; export export LANGUAGE=en_US.UTF-8; cd $CI_SOURCE_PATH; source src/oe-init-build-env build_up; bitbake upboard-image-sato'
