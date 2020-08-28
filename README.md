# KswOverlay by @nicholaschum

This is a tool that automatically creates an overlay for your Ksw-based tablet.
Available to be used on Mac, Windows and Linux.

## Disclaimer
You MUST have JRE and JDK installed, link below:

JDK: [https://www.oracle.com/java/technologies/javase-jdk14-downloads.html](https://www.oracle.com/java/technologies/javase-jdk14-downloads.html)

JRE: [https://www.java.com/en/download/](https://www.java.com/en/download/)


# Download
On the top right corner of this GitHub page, click on Clone or Download, and then click Download ZIP. Then extract that anywhere.


# Theming Instructions
If you never themed before, these are called overlays. They get "overlaid" on top of your existing application and when the app calls for these resources, 
they take from the overlay first, then the base app.

What you have to do is to take the resources from [https://github.com/KswCarProject/KswPLauncher/tree/147/resources/res](this) link and edit those pictures. 
If you're editing in a folder named `drawable-hdpi-v4`, make sure that the folder in `resources/res` has that folder and named correctly, with the file. 

Do not put in unedited files because bloating up the overlay is not ideal.

Once you're done, follow these next steps to compile.


# Windows Instructions
To use this on Windows, make sure Java is installed and then you are able to make changes to the `resources/res/` folder for image and text changes.

When you are done, click on `compile-windows.bat` and it will automatically compile and sign an overlay APK for you!

To install, run `kswoverlay-installer_windows.bat` and follow instructions.


# Mac Instructions
To use this on Mac, make sure Java is installed and then you are able to make changes to the `resources/res/` folder for image and text changes.

When you are done, click on `compile-mac.command` and it will automatically compile and sign an overlay APK for you!

To install, run `kswoverlay-installer_mac.command` and follow instructions.

# Linux Instructions
To use this on Linux, make sure Java is installed and then you are able to make changes to the `resources/res/` folder for image and text changes.

When you are done, in the folder housing `compile-linux.sh` you will need to open a Terminal window and type `chmod +x compile-linux.sh`, then you can type `./compile-linux.sh` and it will automatically compile and sign an overlay APK for you!

To install, enter `chmod +x kswoverlay-installer_linux.sh` then run `./kswoverlay-installer_linux.sh`.