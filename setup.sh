#!/bin/bash

if [ ! -d data ];then
	echo "Creating data dir"
	mkdir data
fi
if [ ! -e data/eula.txt ];then
	AGREE=`read -p "Agree to EULA? (y/N): " yn; case "$yn" in [yY]*) echo "true";; *) echo "false";; esac`
	echo "eula=${AGREE}" > data/eula.txt
fi

if [ ! -e data/password ];then
	echo "Generate password"
	echo `openssl rand -base64 32` > data/password
fi

PASSWORD=`cat data/password`
cat server.properties | sed -e "s|PASSWORD|${PASSWORD}|" > data/server.properties
