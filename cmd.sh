#!/bin/bash

echo $@ | docker attach --sig-proxy=false mcyohanesu_paper_1 &
pid=$!
sleep 1
kill $pid
