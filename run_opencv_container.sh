#!/bin/sh
if [[ "$(docker images -q greglinscheid/polynote:opencv 2> /dev/null)" == "" ]]; then
  source build_image.sh
fi

cmd='docker run -p 8192:8192 -v '$HOME'/poly-notes:/usr/src/app/polynote/notebooks --name=polynote -d -t greglinscheid/polynote:opencv'
echo $cmd
$cmd
