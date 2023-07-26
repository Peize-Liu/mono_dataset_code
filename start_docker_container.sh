#!/bin/bash
DOCKERIMAGE="photometric_calibration:latest"
DATA_SET_PATH=/media/khalil/ssd_data/data_set/
REPO_PATH=/home/khalil/workspace/mono_dataset_code/

if [ $# -eq 0 ]; then
  echo "[INFO] No start option, will start docker container only for application"
  START_OPTION=0
else
  echo "[INFO] Start option is ${1}"
  START_OPTION=$1
fi
xhost +
if [ ${START_OPTION} == 1 ]; then
  echo "[INFO] Start docker container with mapping current dir to docker container"
  CURRENT_DIR=$(pwd)
  echo "${CURRENT_DIR} will be mapped in to docker container with start option 1"
  docker run -it --rm --net=host -v ${CURRENT_DIR}:/vig_calibration/mono_dataset_code -v ${DATA_SET_PATH}:/vig_calibration/data_set/  --privileged -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  ${DOCKERIMAGE} /bin/bash 
else
  echo "Start docker container for image transportation only"
  docker run -it --rm --net=host --privileged -e DISPLAY  -v ${DATA_SET_PATH}:/vig_calibration/data_set/  -v /tmp/.X11-unix:/tmp/.X11-unix  ${DOCKERIMAGE} /bin/bash
fi