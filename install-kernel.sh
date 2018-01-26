#This script automatically download and install/update my kernel
#!/bin/bash

#gpd-pocket-kernel-4.15rc9-26-01-2018
URL_ID="1AfqTUe3vsdUq8CcLpLirrancsnlI2K-f"

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
FILE_COUNT="$(find /tmp/ -maxdepth 1 -type f -name 'gpd-pocket-kernel-*.tar.gz' | wc -l)"

cd /tmp

if [ -d "gpd-pocket-kernel" ]; then
	rm -rf /tmp/gpd-pocket-kernel
fi

mkdir -p /tmp/gpd-pocket-kernel

if [ $FILE_COUNT -eq 1 ]; then
	 echo "Manual downloaded kernel found..."	
	 mv gpd-pocket-kernel-*.tar.gz /tmp/gpd-pocket-kernel/gpd-pocket-kernel-files.tar.gz	
elif [ $FILE_COUNT -gt 1 ]; then
	echo "Manual downloaded kernel found, but more than one. Please leave only one in /tmp directory!"		 
else
	 echo "Downloading kernel files...."
	 curl -L https://drive.google.com/uc?id=$URL_ID -o "gpd-pocket-kernel-files.tar.gz"
	 
fi

cd /tmp/gpd-pocket-kernel

echo "Extracting kernel files..."
tar -xvzf  gpd-pocket-kernel-*.tar.gz 

echo "Installing new kernel..."
sudo dpkg -i *.deb

echo "Update grub..."
sudo update-grub

rm -rfd /tmp/gpd-pocket-kernel

cd $CURRENT_DIR
