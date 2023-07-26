FROM ubuntu:16.04
SHELL ["/bin/bash", "-c"] 
RUN apt-get update &&\
    apt-get install zlib1g-dev libeigen3-dev libopencv-dev cmake git -y
WORKDIR /vig_calibration
RUN git clone https://github.com/Peize-Liu/mono_dataset_code.git &&\
    cd ./mono_dataset_code/thirdparty &&\
    tar -xvf ./aruco-1.3.0.tgz &&\
    cd aruco-1.3.0 &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make &&\
    make install &&\
    cd ../../ &&\
    tar -xvf ./libzip-1.1.1.tar.gz &&\
    cd libzip-1.1.1 &&\
    ./configure &&\
    make &&\
    make install &&\
    cp ./lib/zipconf.h /usr/local/include/zipconf.h &&\
    cd /vig_calibration/mono_dataset_code &&\
    cmake . && make