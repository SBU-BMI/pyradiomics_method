#!/bin/bash

#step 1: download dodcker image from docker hub
docker pull sbubmi/radiomics_core:latest

#remove old docker container if available
docker stop radiomics-core
docker rm radiomics-core

#Run docker container
docker run --name=radiomics-core --restart unless-stopped -itd \
    -e IMAGE_FORMAT=svs \
    -e PATCH_SIZE=512 \
    -e HAS_TUMOR_REGION=no \
    -v /data04/shared/bwang/tmp/images/:/image_files/ \
    -v /data04/shared/bwang/tmp/segment/:/segment_results/ \
    -v /data04/shared/bwang/tmp/pyradiomics2/:/output/ \
   sbubmi/radiomics_core
 

#login computing node to run container 
docker exec radiomics-core  /app/computing_patch_level_radiomics_features.sh 
