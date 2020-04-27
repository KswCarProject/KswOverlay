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

echo You must have Java installed on your computer (JDK and JRE)
echo If you do not have it installed, please install it before
echo running this program.

pause

echo Compiling overlay...
"%cd%\.compiler\aapt.exe" p -S "%cd%\resources\res" -M "%cd%\.compiler\manifest\QC\AndroidManifest.xml" -I "%cd%\.compiler\framework-res.apk" -F kswoverlay.apk -f

echo Signing overlay APK...
"%cd%\.compiler\apksigner.bat" sign --ks "%cd%\.compiler\overlaysig.jks" --ks-pass pass:nicholaschum --key-pass pass:nicholaschum kswoverlay.apk