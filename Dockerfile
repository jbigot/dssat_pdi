FROM pdidevel/xenial_pdi as builder

USER 0 

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y git python3-numpy

COPY dssat-csm-os .
RUN mkdir /dssat-install
RUN chown -R 1001:1001 /home/default /dssat-install

USER 1001

RUN mkdir build
RUN cd build && cmake -DCMAKE_BUILD_TYPE="DEBUG" -DCMAKE_INSTALL_PREFIX=/dssat-install ..
RUN make -C build install
RUN cp Coupling/* /dssat-install

FROM pdidevel/xenial_pdi

USER 0

# this is here just to counter a lack in the base image
ENV BASH_ENV=/etc/profile
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["exec", "/bin/bash", "-li"]

# so are the next 2 lines, then we remove python2 and replace it by python3
RUN echo ". /usr/local/share/pdi/env.bash" > /etc/profile.d/pdi-env.sh \
 && . /etc/profile \
 && apt-get update -y \
 && apt-get upgrade -y \
 && apt-get purge -y python2.7-minimal \
 && apt-get install -y git python3-numpy \
 && apt-get autoremove -y \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/bin/python3 /usr/bin/python

USER 1001

# install everything we need
COPY --chown=1001:1001 --from=builder /dssat-install /dssat-install
COPY --chown=1001:1001 \
     dssat-csm-data/ \
     dssat-csm-data/Maize/UFGA8201.MZX \
     dssat-run.sh \
     /dssat-install/
WORKDIR /dssat-install

RUN chmod +x dssat-run.sh \
 && python CSM.py

CMD ["/dssat-install/dssat-run.sh"]
