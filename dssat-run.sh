#!/bin/bash

. /usr/local/bin/flowvr-config.sh

flowvrd &
sleep 2

python3 CSM.py
flowvr csm