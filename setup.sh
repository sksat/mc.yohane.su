#!/bin/bash

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

# setup systemd service
if [ -z ${CI+x} ]; then
	sudo rm -f /etc/systemd/system/minecraft-*
	sudo ln -s `pwd`/minecraft-backup.timer "/etc/systemd/system/"
	sudo ln -s `pwd`/minecraft-backup.service "/etc/systemd/system/"
	sudo systemctl daemon-reload
	#loginctl enable-linger sksat  #11
	#systemctl enable --user --now minecraft-expose.service
	sudo systemctl enable --now minecraft-backup.timer
fi
