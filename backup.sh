#!/bin/bash
cd $(dirname $0)

DATE=$(date -u +"%Y-%m-%d")
echo "date: ${DATE}"

./cmd.sh say "start backup"
for i in {10..0}; do
	./cmd.sh say "${i}"
	sleep 1
done
./cmd.sh save-all

mkdir -p tmp/data
cp -r data/world tmp/data/
cp -r data/world_nether tmp/data/
cp -r data/world_the_end tmp/data/
./cmd.sh say 'copy data to temporary is complete'

cd tmp
tar -I 'zstd --ultra -22 -T0' -cvpf ${DATE}.tar.zst data
ls -lh ${DATE}.tar.zst

# upload
echo 'start upload'
rclone copy ${DATE}.tar.zst 'gdrive:Minecraft/mc.yohane.su/'

cd ..
rm -rf tmp

echo 'done'
