#!/bin/bash
E="echo "[*]"
platform=`uname`
if [ $(uname -p) = 'powerpc' ]; then
      $E PowerPC architecture is not supported."
       exit 1
fi
if [ "$platform" = 'Darwin' ]; then
        adb="./files/adb.osx"
       version="OSx"
else
        adb="./files/adb.linux"
        version="Linux"
fi
if [ -f $adb ]
  then
    fi
else
       $E ADB not found"
        exit 1
fi
chmod +x $adb
