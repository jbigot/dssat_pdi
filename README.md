# DSSAT - PDI coupling debug docker image

To use this:

Clone this repository with recursive flag and change dssat branch:

```bash
git clone --recursive https://github.com/jbigot/dssat_pdi.git
cd dssat-csm-os && git checkout develop-bis && cd ..
```

To build Dokcer image:

```bash
docker build -t dssat_coupling .
```

To run the Docker image:

```bash
docker run dssat_coupling
```

or interactive run:

```bash
docker run -it dssat_coupling /bin/bash
```
