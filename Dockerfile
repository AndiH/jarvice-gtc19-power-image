FROM nimbix/ubuntu-cuda-ppc64le
LABEL maintainer "Andreas Herten <a.herten@fz-juelich.de>"

RUN apt-get -y update && \
    apt-get -y install python3-pip libzmq3-dev

RUN python3 -m pip install -U cython

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh 3 && rm -f /tmp/install-ubuntu.sh

RUN curl -L -o /tmp/pgi.tar.gz --referer https://www.pgroup.com/support/download_community.php\?file\=pgi-community-linux-openpower https://www.pgroup.com/support/downloader.php\?file\=pgi-community-linux-openpower
RUN tar -x -C /tmp/ -f /tmp/pgi.tar.gz

ENV PGI_VERSION 18.10
ENV PGI_INSTALL_DIR /usr/local/pgi
ENV ARCH linuxpower
ENV PGI_HOME    ${PGI_INSTALL_DIR}/${ARCH}/${PGI_VERSION}
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

COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate
