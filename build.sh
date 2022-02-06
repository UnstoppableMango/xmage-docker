#!/bin/bash
set -ex

if [ -z "$1" ]
  then
    version=`cat VERSION`
  else
    version=$1
fi

echo "Building ${version}"

source config.sh
TAG=$version

docker build --build-arg version=$version \
    -t $USERNAME/$IMAGE:$TAG \
    -t $USERNAME/$IMAGE:latest \
    .

echo "Finished build for ${version}"
