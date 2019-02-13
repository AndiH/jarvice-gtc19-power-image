#!/usr/bin/env bash

export CUDA_ROOT=/usr/local/cuda/

export CUDA_SAMPLES_DIR=/opt/cuda-samples/

PGI_VERSION=18.10
export PGI_INSTALL_DIR=/usr/local/pgi
PGI_ARCH=linuxpower
export PGI_HOME=${PGI_INSTALL_DIR}/${PGI_ARCH}/${PGI_VERSION}


export PATH=${CUDA_ROOT}/bin/:${PATH}
export PATH=${CUDA_SAMPLES_DIR}:${PATH}
export PATH=${PGI_HOME}/bin/:${PATH}

export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${PGI_HOME}/lib/:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LIBRARY_PATH}
export LIBRARY_PATH=${PGI_HOME}/lib/:${LIBRARY_PATH}

export CPATH=${CUDA_ROOT}/include/:${LIBRARY_PATH}

export MANPATH=${PGI_HOME}/man/:${MANPATH}
