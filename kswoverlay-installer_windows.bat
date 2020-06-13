@echo off
taskkill /f /im adb.exe
echo =========================================================
echo "  _  __              ___                 _             ";
echo " | |/ /_____      __/ _ \__   _____ _ __| | __ _ _   _ ";
echo " | ' // __\ \ /\ / / | | \ \ / / _ \ '__| |/ _\ | | | |";
echo " | . \\__ \\ V  V /| |_| |\ V /  __/ |  | | (_| | |_| |";
echo " |_|\_\___/ \_/\_/  \___/  \_/ \___|_|  |_|\__,_|\__, |";
echo "                                                 |___/ ";
echo " KswOverlay - written by Nicholas Chum (@nicholaschum) "
echo "            - installer bat by Chri (@kri)           "
echo =========================================================
echo.
echo This will set up your device to be able to easily install
echo overlay APKs through the file browser or directly.
echo Ensure you already have compiled your KswOverlay apk !
echo.
SET /p _IP= enter the IP address of the device (e.g. 192.168.0.1): 
@echo connecting to device ....
:initialconnect
@echo If %_ip% cannot be connected please check IP address again
timeout 2
ping -n 1 %_ip% |find "TTL=" || goto :initialconnect
echo Answer received.
"%cd%\.compiler\adb" connect %_ip%:5555
"%cd%\.compiler\adb" root
"%cd%\.compiler\adb" remount
set _inputname=%_ip%:5555

:menu
cls
echo =========================================================
echo "  _  __              ___                 _             ";
echo " | |/ /_____      __/ _ \__   _____ _ __| | __ _ _   _ ";
echo " | ' // __\ \ /\ / / | | \ \ / / _ \ '__| |/ _\ | | | |";
echo " | . \\__ \\ V  V /| |_| |\ V /  __/ |  | | (_| | |_| |";
echo " |_|\_\___/ \_/\_/  \___/  \_/ \___|_|  |_|\__,_|\__, |";
echo "                                                 |___/ ";
echo " KswOverlay - written by Nicholas Chum (@nicholaschum) "
echo "            - installer bat by Chri (@kri)           "
echo =========================================================
echo.
echo.  Connected IP Address: %_inputname%
echo.
echo.  Press "1" to install and enable on Snapdragon 625
echo.  Press "2" to update and enable Snapdragon 625
echo.  Press "3" to install and enable on PX6
echo.  Press "4" to update and enable PX6
echo.  Press "5" to enable KswOverlay
echo.  Press "6" to disable KswOverlay
echo.  Press "7" to reboot device
echo.
set installer=
set /P installer= Please select a number or press enter to end the script 
echo.
IF "%installer%"=="1" GOTO :installKSW625
IF "%installer%"=="2" GOTO :updateKSW625
IF "%installer%"=="3" GOTO :installKSWPX6
IF "%installer%"=="4" GOTO :updateKSWPX6
IF "%installer%"=="5" GOTO :enableKSWmanual 
IF "%installer%"=="6" GOTO :disableKSW
IF "%installer%"=="7" GOTO :rebooting
IF "%installer%" not defined GOTO :end

::functions

:pingloop
echo Waiting until %_ip% is reachable again...
timeout 3 >nul
ping -n 1 %_ip% |find "TTL=" || goto :pingloop
echo Answer received.
goto :eof

:connecting
echo Connecting to device...
"%cd%\.compiler\adb" disconnect
"%cd%\.compiler\adb" connect "%_inputname%"
timeout 1 >nul
echo Perfoming adb root
"%cd%\.compiler\adb" root
timeout 1 >nul
echo performing adb remount
"%cd%\.compiler\adb" remount
timeout 1 >nul
goto :eof

:disableverity
echo Performing disable-verity
"%cd%\.compiler\adb" disable-verity
timeout 1 >nul
echo rebooting device
start "" /min "%CD%\.compiler\adb.exe" reboot
timeout 1 >nul
goto :eof

:enableKSW
echo Activating ksw.overlay ...
timeout 1 >nul
"%cd%\.compiler\adb" shell cmd overlay enable ksw.overlay
echo.
echo ksw.overlay enabled - you may need to reboot device to take effect
goto :eof

:filesSD625
echo Pushing kswoverlay ...
"%cd%\.compiler\adb" push "%cd%\kswoverlay.apk" /storage/emulated/0
"%cd%\.compiler\adb" shell mv /storage/emulated/0/kswoverlay.apk /system/app
"%cd%\.compiler\adb" shell chmod 644 /system/app/kswoverlay.apk
timeout 3 >nul
goto :eof

:filesPX6
echo Pushing kswoverlay ...
"%cd%\.compiler\adb" push "%cd%\kswoverlay-px6.apk" /storage/emulated/0
"%cd%\.compiler\adb" shell mv /storage/emulated/0/kswoverlay-px6.apk /system/app
"%cd%\.compiler\adb" shell chmod 644 /system/app/kswoverlay-px6.apk
timeout 3 >nul
goto :eof

:: scripts

:installKSW625
call :pingloop
call :connecting
call :disableverity
call :pingloop
call :connecting
call :filesSD625
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
call :pingloop
call :connecting
call :enableKSW
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
pause
goto :menu

:updateKSW625
call :pingloop
call :connecting
call :filesSD625
call :enableKSW
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
pause
goto :menu

:installKSWPX6
call :pingloop
call :connecting
call :disableverity
call :pingloop
call :connecting
call :filesPX6
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
call :pingloop
call :connecting
call :enableKSW
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
pause
goto :menu

:updateKSWPX6
call :pingloop
call :connecting
call :filesPX6
call :enableKSW
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
pause
goto :menu

:enableKSWmanual
call :connecting
call :enableKSW
pause
goto :menu

:disableKSW
call :connecting
echo Disabling overlay...
"%cd%\.compiler\adb" shell cmd overlay disable ksw.overlay
echo.
echo ksw.overlay disabled - you may need to reboot device to take effect
pause
Goto :menu

:rebooting
echo Rebooting device...
start "" /min "%CD%\.compiler\adb.exe" reboot
echo Rebooting your tablet, now wait till it boots up again
pause
goto :menu

:end
pause
exit
