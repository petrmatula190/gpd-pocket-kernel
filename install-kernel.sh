#This script automatically download and install/update my kernel
#!/bin/bash

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

mkdir -p /tmp/gpd-pocket-kernel
cd /tmp/gpd-pocket-kernel

if [ ! -f "gpd-pocket-kernel-files.tar.gz" ]; then
	 echo "Downloading kernel files...."
	 curl -L https://drive.google.com/uc?id=13spiPSa5057JIcGoC811xyH25v7Cd4K3 -o "gpd-pocket-kernel-files.tar.gz"
fi

echo "Extracting kernel files..."
tar -xvzf  gpd-pocket-kernel-*.tar.gz 

echo "Installing new kernel..."
sudo dpkg -i *.deb

echo "Update grub..."
sudo update-grub

rm *.deb gpd-pocket-kernel-files.tar.gz 
rm -rfd /tmp/gpd-pocket-kernel

cd $CURRENT_DIR
