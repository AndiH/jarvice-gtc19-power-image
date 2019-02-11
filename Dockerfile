FROM nimbix/ubuntu-cuda-ppc64le
MAINTAINER Andreas Herten 

RUN apt-get -y update && \
    apt-get -y install python3-pip zeromq

RUN python3 -m pip install -U cython

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh 3 && rm -f /tmp/install-ubuntu.sh


# RUN curl -L -o pgi.tar.gz --referer https://www.pgroup.com/support/download_community.php\?file\=pgi-community-linux-openpower https://www.pgroup.com/support/downloader.php\?file\=pgi-community-linux-openpower


COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate
