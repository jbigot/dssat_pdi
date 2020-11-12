FROM pdidevel/xenial_pdi

USER 0 

RUN apt-get update -y
RUN apt-get install -y git

USER 1001

COPY dssat-csm-os*.tar.bz2 .
RUN tar -xf dssat-csm-os*.tar.bz2
RUN rm dssat-csm-os*.tar.bz2
RUN mkdir build
RUN cd build && pdirun cmake -DCMAKE_BUILD_TYPE="DEBUG" -DCMAKE_INSTALL_PREFIX=~/dssat-install ../dssat-csm-os*
RUN make -C build
RUN cd dssat-install \
 && source /usr/local/flowvr-config.sh \
 && flowvr
 && python CSM.py
 && flowvr csm
