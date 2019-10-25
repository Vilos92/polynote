#!/bin/sh
if [[ "$(docker images -q greglinscheid/polynote:latest 2> /dev/null)" == "" ]]; then
  source build_image.sh
fi

VOLUME_NAME='poly-notes'

cmd='docker run -p 8193:8193 -v poly-notes:/usr/src/app/polynote --name=polynote -d -t greglinscheid/polynote:latest'
echo $cmd
$cmd
