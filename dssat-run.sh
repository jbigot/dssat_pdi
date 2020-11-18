#!/bin/bash

echo -e
echo -e
echo -e "\e[1mlaunching the flowvr daemon...\e[0m"
echo -e
echo -e "\e[1mnext, \e[32mto start the execution\e[39m, in another terminal, run:\e[0m"
echo -e "$ docker exec -ti ${HOSTNAME} flowvr csm"
echo -e
echo -e "\e[1if you prefer, \e[32mto enter the container\e[39m, in another terminal, run:\e[0m"
echo -e "$ docker exec -ti ${HOSTNAME} bash -li"
echo -e
echo -e "\e[1monce done, \e[31mto stop the daemon\e[39m, in another terminal, run:\e[0m"
echo -e "$ docker stop ${HOSTNAME}"
echo -e
echo -e
echo -e
echo -e
echo -e
echo -e
echo -e
echo -e

flowvrd
