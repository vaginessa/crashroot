@echo off
SetLocal
cd /d "%~dp0"
color 0f
set e=echo [*]
title  
files\adb >nul 2>&1
if %errorlevel%==9009 goto noadb
::If adb is found, start menu.
%E% Welcome to CRASHROOT
%E% Version number is: 1.0
%E%
%E% NOTE: THIS PROCESS IS DANGEROUS, AND WILL MOST LIKELY VOID
%E% ANY AND ALL WARRANTIES. I AM NOT RESPONSIBLE FOR DEAD OR
%E% BRICKED DEVICES, BROKEN SD CARDS, SUDDEN DEATH, ETC.
%E%
%E%                 USE AT YOUR OWN RISK
%E%
%E% Please open developer options and allow Android Debugging
%E% Please plug in your device to start.
%E% It may take a moment for it to be detected.
files\adb kill-server >nul 2>&1
files\adb wait-for-device >nul 2>&1
%E%
%E% Device found.
%E%
%E% Testing adb...
%E%
files\adb version
files\adb devices
%E% Success.
%E%
::%E% Change screen-time to max.
::files\adb shell am start -n com.android.settings/.DisplaySettings >nul 2>&1
::%E% Press any key when done.
::pause >nul
::%E%
if NOT EXIST files\su (
%E% Downloading latest su binary...
pushd files
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.dropbox.com/s/upr5kwfptgcsx6a/su?dl=1', 'su')"
popd
%E% Complete
%E%
)
%E% Press any key to root your device.
pause >nul
::preps kernel flag
%E% Preparing device...
pushd files
adb shell mv /data/local/tmp /data/local/tmp.bak >nul 2>&1
adb shell ln -s /data /data/local/tmp >nul 2>&1
%E%
%E% Rebooting, one moment...
adb reboot >nul 2>&1
%E% When your device reboots, unlock it.
%E% Press any key to continue.
pause>nul
%E%
%E% Checking for device...
%E%
adb wait-for-device
%E% Device found.
%E%
%E% Preparing data on device...
adb shell rm /data/local.prop >nul 2>&1
adb shell "echo \"ro.kernel.qemu=1\" > /data/local.prop" >nul 2>&1
%E%
%E% Rebooting, one moment...
adb reboot >nul 2>&1
%E% When your device reboots, unlock it.
%E% Press any key to continue.
pause>nul
%E%
%E% Checking for device...
%E%
adb wait-for-device
%E% Device found.
%E%
%E% Rooting device in:
%E% 3
ping -n 2 localhost >nul
%E% 2
ping -n 2 localhost >nul
%E% 1
ping -n 2 localhost >nul
%E%
ping -n 2 localhost >nul
%E% Rooting device...
adb root >nul 2>&1
::mounts system, pushes su binary
adb shell mount -o remount,rw /system >nul 2>&1
adb push su /system/xbin/ >nul 2>&1
adb shell chown 0.0 /system/xbin/su >nul 2>&1
adb shell chmod 06755 /system/xbin/su >nul 2>&1
adb shell rm /data/local.prop > nul >nul 2>&1
adb shell rm -r /data/local/tmp >nul 2>&1
adb shell mv /data/local/tmp.bak /data/local/tmp >nul 2>&1
%E%
%E% Operation complete.
%E% & pause
%E% Rebooting, one moment...
adb reboot
%E% When your device reboots, unlock it.
%E% Press any key to continue.
pause>nul
%E%
%E% Checking for device...
%E%
adb wait-for-device
%E% Device found.
%E%
::launches play store, opens SuperSU page
files\adb shell am start -a android.intent.action.VIEW -d 'http://play.google.com/store/apps/details?id=eu.chainfire.supersu'
%E% Install this app. Open it. Follow on-screen instructions.
%E%
%E% Please, reboot your device.
%E% Press any key to exit.
pause >nul
adb kill-server
:: DO NOT REMOVE, MUST KILL ADB AT END
taskkill /f /im adb.exe
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
exit
:noadb
%e% ADB was not found.
%e% Stopping...
%e% Press any key to exit.
pause >nul
