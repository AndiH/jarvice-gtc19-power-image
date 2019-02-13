#!/usr/bin/env bash

export CUDA_ROOT=/usr/local/cuda/

export CUDA_SAMPLES_DIR=/opt/cuda-samples/


export PATH=${CUDA_ROOT}/bin/:${PATH}
export PATH=${CUDA_SAMPLES_DIR}:${PATH}

export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LIBRARY_PATH}

export CPATH=${CUDA_ROOT}/include/:${LIBRARY_PATH}
