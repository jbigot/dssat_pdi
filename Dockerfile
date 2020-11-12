FROM pdidevel/xenial_pdi

USER 0 

RUN apt-get update -y
RUN apt-get install -y git

USER 1001

RUN git clone https://gitlab.inria.fr/emorsi/dssat-csm-os.git
RUN cd dssat-csm-os \
 && mkdir BUILD \
 && cd BUILD \
 && pdirun cmake .. \
 && pdirun make -j
