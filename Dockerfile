FROM nimbix/ubuntu-cuda-ppc64le
LABEL maintainer "Andreas Herten <a.herten@fz-juelich.de>"

RUN apt-get -y update && \
    apt-get -y install bash python3-pip libzmq3-dev libnuma1

#### INSTALL NIMBIX NOTEBOOK STUFF

RUN python3 -m pip install -U cython pyzmq==17.1.2

RUN pip3 freeze

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh 3 && rm -f /tmp/install-ubuntu.sh

#### PGI: INSTALL & CONFIGURE

RUN curl -L -o /tmp/pgi.tar.gz --referer https://www.pgroup.com/support/download_community.php\?file\=pgi-community-linux-openpower https://www.pgroup.com/support/downloader.php\?file\=pgi-community-linux-openpower
RUN tar -x -C /tmp/ -f /tmp/pgi.tar.gz

ENV PGI_VERSION 18.10
ENV PGI_INSTALL_DIR /usr/local/pgi
ENV ARCH linuxpower
ENV PGI_HOME ${PGI_INSTALL_DIR}/${ARCH}/${PGI_VERSION}

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

#### CUDA: CONFIGURE, INSTALL SAMPLES

ENV CUDA_ROOT /usr/local/cuda/
ENV PATH ${CUDA_ROOT}/bin/:${PATH}
ENV LD_LIBRARY_PATH ${CUDA_ROOT}/lib64/:${LD_LIBRARY_PATH}
ENV LIBRARY_PATH ${CUDA_ROOT}/lib64/:${LIBRARY_PATH}
ENV CPATH ${CUDA_ROOT}/include/:${LIBRARY_PATH}

RUN cuda-install-samples-8.0.sh /tmp/ && \
	cd /tmp/NVIDIA_CUDA-8.0_Samples/ && \
	make -j 10
RUN rsync --archive /tmp/NVIDIA_CUDA-8.0_Samples/bin/ppc64le/linux/release/ /opt/cuda-samples && \
	rm -rf /tmp/NVIDIA_CUDA-8.0_Samples

#### OTHER STUFF

# RUN sudo chsh -s /bin/bash nimbix
# SHELL ["/bin/bash", "-c"]
# RUN sudo echo "SHELL=/bin/bash" >> /etc/environment
RUN sed -i "s.exec jupyter.SHELL=/bin/bash exec jupyter." /usr/local/bin/nimbix_notebook
ADD environment.sh /opt/environment.sh

#### META DATA FOR NIMBIX / JARVICE

COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate
