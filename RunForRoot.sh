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
$E Welcome to CRASHROOT"
$E Version number is: 1.0"
$E You are running $version."
$E
$E NOTE: THIS PROCESS IS DANGEROUS, AND WILL MOST LIKELY VOID"
$E ANY AND ALL WARRANTIES. I AM NOT RESPONSIBLE FOR DEAD OR"
$E BRICKED DEVICES, BROKEN SD CARDS, SUDDEN DEATH, ETC."
$E
$E                 USE AT YOUR OWN RISK"
$E
$E Please open developer options and allow Android Debugging"
$E Please plug in your device to start."
$E It may take a moment for it to be detected."
