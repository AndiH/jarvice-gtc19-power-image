#!/usr/bin/env bash

export CUDA_ROOT=/usr/local/cuda/
export PATH=${CUDA_ROOT}/bin/:${PATH}
export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LIBRARY_PATH}
export CPATH=${CUDA_ROOT}/include/:${LIBRARY_PATH}
