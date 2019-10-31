#!/bin/sh
cmd='docker build -f Dockerfile.opencv -t greglinscheid/polynote:opencv .'
echo $cmd
eval $cmd
