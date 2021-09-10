#!/bin/bash

# PLUGIN=(repo, version, file-prefix)

# datasource=github-releases
PLUGIN_COREPROTECT=("PlayPro/CoreProtect" "v20.0" "CoreProtect")

# datasource=github-releases
PLUGIN_DISCORDSRV=("DiscordSRV/DiscordSRV" "v1.23.0" "DiscordSRV-Build")

# datasource=github-releases
PLUGIN_PROMETHEUS_EXPORTER=("sladkoff/minecraft-prometheus-exporter" "v2.4.2" "minecraft-prometheus-exporter")

function download_github(){
	echo $1
	echo $2
	echo $3
	REPO="$1"
	VERSION="$2"
	FNAME_PREFIX="$3"

	cd data/plugins
	echo "[${REPO}] remove old version"
	rm -f "${FNAME_PREFIX}"*.jar
	echo "[${REPO}] download new version(${VERSION})"
	VTMP="${VERSION#v}"
	FNAME="${FNAME_PREFIX}-${VTMP}.jar"
	URL="https://github.com/${REPO}/releases/download/${VERSION}/${FNAME}"
	echo "[$REPO] URL: $URL"
	wget -q "$URL"
	cd ../..
	echo "[${REPO}] done"
}

download_github ${PLUGIN_COREPROTECT[0]} ${PLUGIN_COREPROTECT[1]} "${PLUGIN_COREPROTECT[2]}"
download_github ${PLUGIN_DISCORDSRV[0]} ${PLUGIN_DISCORDSRV[1]} ${PLUGIN_DISCORDSRV[2]}
download_github ${PLUGIN_PROMETHEUS_EXPORTER[0]} ${PLUGIN_PROMETHEUS_EXPORTER[1]} ${PLUGIN_PROMETHEUS_EXPORTER[2]}
