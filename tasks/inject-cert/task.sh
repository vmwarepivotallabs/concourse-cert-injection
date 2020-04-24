#!/bin/bash

source /opt/resource/common.sh

max_concurrent_downloads=3
max_concurrent_uploads=3
start_docker ${max_concurrent_downloads} ${max_concurrent_uploads}

stop_docker