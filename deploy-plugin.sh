#!/bin/bash
cd `dirname $0`

# PLUGIN=(repo, version, file-prefix, file-versioning)

PLUGINS=(
  # datasource=github-releases versioning=docker
  "PlayPro/CoreProtect v20.4 CoreProtect nov"
  # datasource=github-releases
  "DiscordSRV/DiscordSRV v1.24.0 DiscordSRV-Build nov"
  # datasource=github-releases
  "sladkoff/minecraft-prometheus-exporter v2.4.2 minecraft-prometheus-exporter nov"
  # datasource=github-releases
  "kory33/itemstack-count-infrastructure v0.1.10 itemstack-count none"
  # datasource=github-releases
  "jrbudda/Vivecraft_Spigot_Extensions 1.17.1 Vivecraft_Spigot_Extensions zip"
  # datasource=github-releases
  "Siro256/ConfineChickens v1.0.2 ConfineChickens nov"
)

function download_github(){
	echo $1
	echo $2
	echo $3
	REPO="$1"
	VERSION="$2"
	FNAME_PREFIX="$3"
	FNAME_VERSIONING="$4"

	cd data/plugins
	echo "[${REPO}] remove old version"
	rm -f "${FNAME_PREFIX}"*.jar

	echo "[${REPO}] download new version(${VERSION})"
	FNAME="${FNAME_PREFIX}.jar"
	if [[ "$FNAME_VERSIONING" == 'nov' ]]; then
		VTMP="${VERSION#v}"
		FNAME="${FNAME_PREFIX}-${VTMP}.jar"
	elif [[ "$FNAME_VERSIONING" == 'zip' ]]; then
		FNAME="${FNAME_PREFIX}.${VERSION}b2.zip" # TODO for vivecraft only
	fi
	echo "[$REPO] fname: $FNAME"

	URL="https://github.com/${REPO}/releases/download/${VERSION}/${FNAME}"
	echo "[$REPO] URL: $URL"
	wget -q "$URL"
	if [ $? -gt 0 ]; then
		echo "[$REPO] download failed!"
		exit 1
	fi
	
	if [[ "$FNAME_VERSIONING" == 'zip' ]]; then
		unzip "${FNAME}"
		rm -f "${FNAME}"
	fi
	cd ../..
	echo "[${REPO}] done"
}

for plugin in "${PLUGINS[@]}"; do
	p=(${plugin[@]})
	repo="${p[0]}"
	version="${p[1]}"
	fprefix="${p[2]}"
	fversion="${p[3]}"
	echo "repo: $repo, version=$version, fprefix=$fprefix, fversion=$fversion"
	download_github "$repo" "$version" "$fprefix" "$fversion"
	if [ $? -gt 0 ]; then
		exit 1
	fi
done
