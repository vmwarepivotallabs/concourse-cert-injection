#!/bin/bash -e

source /opt/resource/common.sh

max_concurrent_downloads=3
max_concurrent_uploads=3
start_docker ${max_concurrent_downloads} ${max_concurrent_uploads}

image_file="$(find image/*.tgz 2>/dev/null | head -n1)"
echo "importing ${image_file} as current:latest"
docker import "${image_file}" current:latest

pushd source/docker
   docker build --build-arg ca_pem="${CA_PEM}" -t modified:latest .
   docker images
popd

docker run \
    --cidfile=/tmp/container.cid \
    -v /opt/resource/print-metadata:/tmp/print-metadata \
    --entrypoint /tmp/print-metadata  \
    modified:latest > modified/metadata.json

mkdir -p modified/rootfs/
docker export $(cat /tmp/container.cid) | tar --exclude="dev/*" -xf - -C modified/rootfs/

stop_docker