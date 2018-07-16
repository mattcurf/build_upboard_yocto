#!/bin/bash
export IMAGE_NAME=ubuntu_16_yocto

if [ -z "$YOCTO_DOWNLOAD_CACHE" ]; then
	echo "Error: YOCTO_DOWNLOAD_CACHE environment variable is not set" 
	exit -1
fi

# Create Docker image
if [ -z $(docker images -q $IMAGE_NAME) ]; then
	echo "Building image ..."
	docker build -t $IMAGE_NAME docker	
fi

# Setup directory structure for Yocto build
if [ ! -d "poky" ]; then
	echo "Setting up directory structure ..."
	docker run --rm -v `pwd`:`pwd` -e "YOCTO_DOWNLOAD_CACHE=$YOCTO_DOWNLOAD_CACHE" -e "CI_SOURCE_PATH=`pwd`" -t $IMAGE_NAME /bin/sh -c 'cd $CI_SOURCE_PATH; ./_setup_yocto.bash'
fi

# Build it
echo "Building ..."
docker run --rm -v `pwd`:`pwd` -v $YOCTO_DOWNLOAD_CACHE:$YOCTO_DOWNLOAD_CACHE -e "CI_SOURCE_PATH=`pwd`" -t $IMAGE_NAME /bin/sh -c 'cd $CI_SOURCE_PATH; ./_build_yocto.bash'
