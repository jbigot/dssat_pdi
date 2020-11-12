FROM pdidevel/xenial_pdi as builder

USER 0 

RUN apt-get update -y
RUN apt-get install -y git python3-numpy

USER 1001

COPY dssat-csm-os*.tar.bz2 .
RUN tar -xf dssat-csm-os*.tar.bz2
RUN rm *.tar.bz2
RUN mkdir build
RUN cd build && cmake -DCMAKE_BUILD_TYPE="DEBUG" -DCMAKE_INSTALL_PREFIX=~/dssat-install ../dssat-csm-os*
RUN cd build && make -j install
RUN cp -R dssat-csm-os*/Coupling/* dssat-install
COPY dssat-run dssat-install

#FROM pdidevel/xenial_pdi
#COPY --from=builder ${HOME}/dssat-install ${HOME}/dssat-install

RUN cd dssat-install && pdirun bash -x dssat-run
