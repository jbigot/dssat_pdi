FROM pdidevel/xenial_pdi as builder

USER 0 

RUN apt-get update -y
RUN apt-get install -y git python3-numpy

COPY dssat-csm-os .
RUN ls -l && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE="DEBUG" -DCMAKE_INSTALL_PREFIX=/dssat-install .. && \
    make install
RUN cp Coupling/* /dssat-install


FROM pdidevel/xenial_pdi
USER 0
COPY --from=builder /dssat-install /dssat-install

COPY dssat-run /dssat-install
WORKDIR /dssat-install

CMD pdirun bash -x dssat-run
