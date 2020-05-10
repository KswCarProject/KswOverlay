@echo off

echo =========================================================
echo "  _  __              ___                 _             ";
echo " | |/ /_____      __/ _ \__   _____ _ __| | __ _ _   _ ";
echo " | ' // __\ \ /\ / / | | \ \ / / _ \ '__| |/ _\ | | | |";
echo " | . \\__ \\ V  V /| |_| |\ V /  __/ |  | | (_| | |_| |";
echo " |_|\_\___/ \_/\_/  \___/  \_/ \___|_|  |_|\__,_|\__, |";
echo "                                                 |___/ ";                                                 
echo " KswOverlay - written by Nicholas Chum (@nicholaschum) "
echo =========================================================

echo This will set up your device to be able to easily install
echo overlay APKs through the file browser.
echo YOU SHOULD ONLY RUN THIS AS YOUR FIRST INSTALL!
pause

echo I will now try to connect to your device...
pause
SET /P _inputname= Please enter your device's IP and port (e.g. 192.168.0.1:5555):
SET /P _veritycheck= Is your device's verity disabled already? If you don't know, type N:
IF "%_veritycheck%"=="N" GOTO :disableverity
GOTO :continuepush

:disableverity
"%cd%\.compiler\adb" disconnect
"%cd%\.compiler\adb" connect %_inputname%
timeout 1 >nul
"%cd%\.compiler\adb" root
timeout 1 >nul
"%cd%\.compiler\adb" disable-verity
timeout 1 >nul
start "" /min "%CD%\.compiler\adb.exe" reboot
timeout 1 >nul
%cd%\.compiler\adb disconnect
GOTO :continuepush

:continuepush
echo Alright, if the tablet is ready to be connected to, press any key
pause
"%cd%\.compiler\adb" disconnect
"%cd%\.compiler\adb" connect %_inputname%
timeout 1 >nul
"%cd%\.compiler\adb" root
timeout 1 >nul
"%cd%\.compiler\adb" remount
timeout 1 >nul
"%cd%\.compiler\adb" push %cd%\kswoverlay.apk /storage/emulated/0
"%cd%\.compiler\adb" shell mv /storage/emulated/0/kswoverlay.apk /system/app
"%cd%\.compiler\adb" shell chmod 644 /system/app/kswoverlay.apk
timeout 1 >nul
"%cd%\.compiler\adb" reboot
GOTO :continueactivate

:continueactivate
echo Rebooted your tablet, now wait till it boots up again
pause
"%cd%\.compiler\adb" connect %_inputname%
timeout 1 >nul
"%cd%\.compiler\adb" shell cmd overlay enable ksw.overlay
timeout 1 >nul
start "" /min "%CD%\.compiler\adb.exe" reboot
timeout 1 >nul
"%cd%\.compiler\adb" disconnect
echo Done!
echo Rebooted your tablet, now wait till it boots up again
pause

:end
