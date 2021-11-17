#!/bin/bash

echo $@ | docker attach --sig-proxy=false mcyohanesu-paper-1 &
pid=$!
sleep 1
kill $pid
