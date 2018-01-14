#This script automatically download and install/update my kernel
#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

mkdir -p /tmp/gpd-pocket-kernel
cd /tmp/gpd-pocket-kernel

echo "Downloading kernel files...."
wget https://drive.google.com/file/d/1pUfjuMrWykNXGAey3YrT_xqlWJ0GYMD3/view?usp=drivesdk

echo "Extracting kernel files..."
tar -xvzf  gpd-pocket-kernel-*.tar.gz 

echo "Installing new kernel..."
sudo dpkg -i *.deb

echo "Update grub..."
sudo update-grub

rm *.deb gpd-pocket-kernel-*.tar.gz 
rm -rfd /tmp/gpd-pocket-kernel

cd $CURRENT_DIR
