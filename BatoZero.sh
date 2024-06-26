#!/bin/sh

# Detect Architechture
arch=""
case $(uname -m) in
    x86_64) arch="x86_64" ;;
    arm)    arch="arm" ;;
esac

#Display Architechture
echo System Arch: $arch

# Download Zerotier
if [ $arch = "x86_64" ]; then
 echo x86_64 Detected, Downloading
 curl -LJO https://github.com/Jhaiywroumne/BatoZero/releases/download/Latest/zerotier-one-x86_64.tar.gz
elif [ $arch = "arm" ]; then
 echo arm Detected, Downloading
 curl -LJO https://github.com/Jhaiywroumne/BatoZero/releases/download/Latest/zerotier-one-aarch64.tar.gz
else
 echo Unsupported system architecture
 exit 1 # terminate and indicate error
fi

# Unpack downloaded archive
mkdir ~/bin
if [ $arch = "x86_64" ]; then
 echo Extracting x86_64 Binaries
 tar -xzf zerotier-one-x86_64.tar.gz bin/zerotier-one -C ./bin
elif [ $arch = "arm" ]; then
 echo Extracting arm Binaries
 tar -xzf zerotier-one-aarch64.tar.gz bin/zerotier-one -C ./bin
else
 echo Unsupported system architecture
 exit 1 # terminate and indicate error
fi

# Install to root bin directory
install bin/* /usr/bin

# Cleanup after installation
if [ $arch = "x86_64" ]; then
 echo Cleaning up x86_64 installation
 rm zerotier-one-x86_64.tar.gz
elif [ $arch = "arm" ]; then
 echo Cleaning up arm installation
 rm zerotier-one-aarch64.tar.gz
else
 echo Unsupported system architecture
 exit 1 # terminate and indicate error
fi

# Setup Startup File
curl -LJO https://raw.githubusercontent.com/Jhaiywroumne/BatoZero/main/Zerotier
mv Zerotier /userdata/system/services/

# Cleanup script
rm BatoZero.sh
