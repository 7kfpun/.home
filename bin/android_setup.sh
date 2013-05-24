#!/bin/sh
## Usage: Install android
##

android=adt-bundle-linux-x86_64-20130514

rm -rf ~/android
wget http://dl.google.com/android/adt/$android.zip -P /tmp/
unzip /tmp/$android.zip -d /tmp/
mv /tmp/$android ~/android


# 32bit shared libraries for Android
sudo apt-get install -y ia32-libs

