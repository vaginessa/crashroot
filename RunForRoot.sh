#!/bin/bash
platform=`uname`
if [ $(uname -p) = 'powerpc' ]; then
      echo "[*] PowerPC architecture is not supported."
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
       echo "[*] ADB not found"
        exit 1
fi
chmod +x $adb
echo "[*] Welcome to CRASHROOT"
echo "[*] Version number is: 1.0"
echo "[*] You are running $version."
echo "[*]"
echo "[*] NOTE: THIS PROCESS IS DANGEROUS, AND WILL MOST LIKELY VOID"
echo "[*] ANY AND ALL WARRANTIES. I AM NOT RESPONSIBLE FOR DEAD OR"
echo "[*] BRICKED DEVICES, BROKEN SD CARDS, SUDDEN DEATH, ETC."
echo "[*]"
echo "[*]                 USE AT YOUR OWN RISK"
echo "[*]"
echo "[*] For maximum happiness, please run this script as ROOT."
echo "[*] Please open developer options and allow Android Debugging."
echo "[*] Please plug in your device to start."
echo "[*] It may take a moment for it to be detected."
$adb kill-server
$adb wait-for-device
echo "[*]"
echo "[*] Device found."
echo "[*]"
$adb version
echo "[*]"
echo "[*] Success."
if [ -f files/su ]
  then
    fi
else
       echo "[*] SU binary not found. Attempting to download..."
       curl -# -O ./files/su 'https://www.dropbox.com/s/upr5kwfptgcsx6a/su?dl=1'
       echo "[*] Restart CRASHROOT"
       exit 1
fi
echo "[*]"
read -p "[*] Press any key to root your device."
echo "[*] Starting: Stage 1 of 3"
$adb shell mv /data/local/tmp /data/local/tmp.bak
$adb shell ln -s /data /data/local/tmp
echo "[*]"
echo "[*] Rebooting..."
$adb reboot
echo "[*] When your device reboots, unlock it."
$adb wait-for-device
echo "[*]"
echo "[*] Device found. Starting stage 2 of 3."
echo "[*]"
$adb shell rm /data/local.prop
$adb shell "echo \"ro.kernel.qemu=1\" > /data/local.prop"
echo "[*] Rebooting once more..."
echo "[*] When your device reboots, unlock it."
$adb wait-for-device
echo "[*]"
echo "[*] Device found. Starting stage 3 of 3."
$adb kill-server
echo "[*] Attempting root!"
$adb root
$adb shell mount -o remount,rw /system
$adb push ./files/su /system/xbin/
$adb shell chown 0.0 /system/xbin/su
$adb shell chmod 06755 /system/xbin/su
$adb shell rm /data/local.prop
$adb shell rm -r /data/local/tmp
$adb shell mv /data/local/tmp.bak /data/local/tmp
echo "[*] Rebooting final time."
read -p "[*] Unlock your device then press any key."
$adb wait-for-device
$adb shell am start -a android.intent.action.VIEW -d 'http://play.google.com/store/apps/details?id=eu.chainfire.supersu'
echo "[*]"
echo "[*] Install this app. Follow the on-screen instructions."
echo "[*]"
echo "[*] Cleaning up..."
$adb kill-server
killall adb
echo "[*]"
echo "[*] Thanks for choosing CRASHROOT."
read -p "[*] Press any key to exit."
