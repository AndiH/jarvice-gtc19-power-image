FROM nimbix/ubuntu-cuda-ppc64le
MAINTAINER Andreas Herten 

RUN apt-get -y update && \
    apt-get -y install python3-pip

RUN python3 -m pip install -U cython

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh 3 && rm -f /tmp/install-ubuntu.sh

COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate
