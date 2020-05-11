#!/bin/sh

echo =========================================================
echo "  _  __              ___                 _             ";
echo " | |/ /_____      __/ _ \__   _____ _ __| | __ _ _   _ ";
echo " | ' // __\ \ /\ / / | | \ \ / / _ \ '__| |/ _\ | | | |";
echo " | . \\__ \\ V  V /| |_| |\ V /  __/ |  | | (_| | |_| |";
echo " |_|\_\___/ \_/\_/  \___/  \_/ \___|_|  |_|\__,_|\__, |";
echo "                                                 |___/ ";
echo " KswOverlay - written by Nicholas Chum (@nicholaschum) "
echo =========================================================

echo Compiling overlay...
./.compiler/aapt p -S resources/res-mtk -M .compiler/manifest/MTK/AndroidManifest.xml -I .compiler/framework-res-mtk.apk -F kswoverlay-mtk.apk -f

echo Signing overlay APK...
./.compiler/apksigner sign --ks .compiler/overlaysig.jks --ks-pass pass:nicholaschum --key-pass pass:nicholaschum kswoverlay-mtk.apk
