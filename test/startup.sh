#!/bin/bash
set -eu
cd `dirname $0`
cd 'test'

pwd

MINECRAFT_VERSION="1.17.1"

mkdir -p data

echo "EULA"
echo "eula=true" > data/eula.txt

echo "setup"
./setup.sh

echo "deploy plugin"
./deploy-plugin.sh
echo "plugin list:"
ls data/plugins/*.jar

echo "start server"
docker-compose up -d
sleep 5
docker-compose ps

if [ ! -z "$(docker-compose ps | grep 'Exit 1')" ]; then
	echo "error: service is down"
	exit 1
fi

echo "wait for start..."

# wait start loop
SECONDS=0
while true
do
	sleep 1
	MCSTATUS_JSON=$(mcstatus localhost json)
	MCSTATUS_ONLINE=$(echo ${MCSTATUS_JSON} | jq .online)
	if [ "${MCSTATUS_ONLINE}" == 'true' ]; then
		break
	fi
	echo "waiting...${SECONDS}"
	if [ $SECONDS -gt 300 ]; then
		echo "timeout"
		break
	fi
done

docker-compose logs

echo "${MCSTATUS_JSON}"
MCSTATUS_VERSION=$(echo ${MCSTATUS_JSON} | jq .version)

if [ "${MCSTATUS_ONLINE}" != 'true' ]; then
	echo "Minecraft server is down"
	exit 1
fi

if [ "${MCSTATUS_VERSION}" != "\"Paper ${MINECRAFT_VERSION}\"" ]; then
	echo "Minecraft version mismatch: ${MCSTATUS_VERSION}"
	exit 1
fi

env IMG_TAG="${IMG_TAG}" docker-compose down
sudo rm -rf data
exit 0
