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
ln -s `pwd`/minecraft-backup.timer "${HOME}/.config/systemd/user/"
ln -s `pwd`/minecraft-backup.service "${HOME}/.config/systemd/user/"
ln -s `pwd`/minecraft-expose.service "${HOME}/.config/systemd/user"
systemctl --user daemon-reload
loginctl enable-linger sksat  #11
#systemctl enable --user --now minecraft-expose.service
systemctl enable --user --now minecraft-backup.timer
