FROM nimbix/ubuntu-cuda-ppc64le
LABEL maintainer "Andreas Herten <a.herten@fz-juelich.de>"

RUN apt-get -y update && \
    apt-get -y install bash python3-pip libzmq3-dev

#### INSTALL NIMBIX NOTEBOOK STUFF

RUN python3 -m pip install -U cython

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh 3 && rm -f /tmp/install-ubuntu.sh

#### PGI: INSTALL & CONFIGURE

RUN curl -L -o /tmp/pgi.tar.gz --referer https://www.pgroup.com/support/download_community.php\?file\=pgi-community-linux-openpower https://www.pgroup.com/support/downloader.php\?file\=pgi-community-linux-openpower
RUN tar -x -C /tmp/ -f /tmp/pgi.tar.gz

ENV PGI_VERSION 18.10
ENV PGI_INSTALL_DIR /usr/local/pgi
ENV ARCH linuxpower
ENV PGI_HOME ${PGI_INSTALL_DIR}/${ARCH}/${PGI_VERSION}
ENV PGI_BIN_DIR ${PGI_HOME}/bin
ENV PGI_LIB_DIR ${PGI_HOME}/lib
ENV PGI_MAN_DIR ${PGI_HOME}/man

RUN export PGI_SILENT=true && \
    export PGI_ACCEPT_EULA=accept && \
    export PGI_INSTALL_NVIDIA=true && \
    export PGI_INSTALL_MANAGED=true && \
    export PGI_INSTALL_AMD=false && \
    export PGI_INSTALL_JAVA=false && \
    export PGI_INSTALL_MPI=true && \
    export PGI_MPI_GPU_SUPPORT=true && \
    /tmp/install && \
    rm -rf /tmp/*

ENV PATH ${PGI_BIN_DIR}:${PATH}
ENV LD_LIBRARY_PATH ${PGI_LIB_DIR}:${LD_LIBRARY_PATH}
ENV LIBRARY_PATH ${PGI_LIB_DIR}:${LIBRARY_PATH}
ENV MANPATH ${PGI_MAN_DIR}:${MANPATH}

#### CUDA: CONFIGURE

ENV CUDA_ROOT /usr/local/cuda/
ENV PATH ${CUDA_ROOT}/bin/:${PATH}
ENV LD_LIBRARY_PATH ${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
ENV LIBRARY_PATH ${CUDA_ROOT}/lib64/:${LIBRARY_PATH}
ENV CPATH ${CUDA_ROOT}/include/:${LIBRARY_PATH}

#### OTHER STUFF

# RUN sudo chsh -s /bin/bash nimbix
SHELL ["/bin/bash", "-c"]

#### META DATA FOR NIMBIX / JARVICE

COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate
