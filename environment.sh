#!/usr/bin/env bash

export CUDA_ROOT=/usr/local/cuda/

export CUDA_SAMPLES_DIR=/opt/cuda-samples/

PGI_VERSION=18.10
export PGI_INSTALL_DIR=/usr/local/pgi
PGI_ARCH=linuxpower
export PGI_HOME=${PGI_INSTALL_DIR}/${PGI_ARCH}/${PGI_VERSION}
export PGI_ACC_POOL_ALLOC=0

export MPI_ROOT=/usr/local/pgi/linuxpower/18.10/mpi/openmpi/


export PATH=${CUDA_ROOT}/bin/:${PATH}
export PATH=${CUDA_SAMPLES_DIR}:${PATH}
export PATH=${PGI_HOME}/bin/:${PATH}
export PATH=${MPI_ROOT}/bin/:${PATH}

export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${PGI_HOME}/lib/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${MPI_ROOT}/lib/:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${CUDA_ROOT}/lib64/:${LIBRARY_PATH}
export LIBRARY_PATH=${PGI_HOME}/lib/:${LIBRARY_PATH}
export LIBRARY_PATH=${MPI_ROOT}/lib/:${LIBRARY_PATH}

export CPATH=${CUDA_ROOT}/include/:${CPATH}
export CPATH=${MPI_ROOT}/include/:${CPATH}

export MANPATH=${PGI_HOME}/man/:${MANPATH}
