#!/bin/bash

COREPROTECT_REPO="PlayPro/CoreProtect"
DISCORDSRV_REPO="DiscordSRV/DiscordSRV"
PROMETHEUS_EXPORTER_REPO="sladkoff/minecraft-prometheus-exporter"

COREPROTECT_VERSION="20.0"
DISCORDSRV_VERSION="1.23.0"
PROMETHEUS_EXPORTER_VERSION="2.4.2"

COREPROTECT_FPREFIX="CoreProtect"
DISCORDSRV_FPREFIX="DiscordSRV-Build"
PROMETHEUS_EXPORTER_FPREFIX="minecraft-prometheus-exporter"

function download_github(){
	REPO="$1"
	VERSION="$2"
	FNAME_PREFIX="$3"

	cd data/plugins
	echo "[${REPO}] remove old version"
	rm "${FNAME_PREFIX}"*
	echo "[${REPO}] download new version(${VERSION})"
	wget -q "https://github.com/${REPO}/releases/download/v${VERSION}/${FNAME_PREFIX}-${VERSION}.jar"
	cd ../..
	echo "[${REPO}] done"
}

download_github "${COREPROTECT_REPO}" "${COREPROTECT_VERSION}" "${COREPROTECT_FPREFIX}"
download_github "${DISCORDSRV_REPO}" "${DISCORDSRV_VERSION}" "${DISCORDSRV_FPREFIX}"
download_github "${PROMETHEUS_EXPORTER_REPO}" "${PROMETHEUS_EXPORTER_VERSION}" "${PROMETHEUS_EXPORTER_FPREFIX}"
