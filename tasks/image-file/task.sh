#!/bin/bash -e

source /opt/resource/common.sh

max_concurrent_downloads=3
max_concurrent_uploads=3
start_docker ${max_concurrent_downloads} ${max_concurrent_uploads}

image_file="$(find image/*.tgz 2>/dev/null | head -n1)"
echo "importing ${image_file} as existing:latest"
docker import "${image_file}" existing:latest

pushd source/docker
   docker build --build-arg ca_pem=${CA_PEM} -t new-image:latest .
   docker images
popd

pushd modified-image
  docker save -o latest.tgz new-image:latest
  tar -xvf latest.tgz
  rm latest.tgz
popd 


stop_docker