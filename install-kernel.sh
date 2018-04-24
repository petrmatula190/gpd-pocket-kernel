#This script automatically download and install/update my kernel
#!/bin/bash

#gpd-pocket-kernel-4.16rc6-29-03-2018
URL_ID="1KhAILN5e-hPhqVlPZZqRNfwiK-e36EGI"

#remove afected kernel releases - broken charging only on 5V/3A
echo "Remove my kernel with broken charging, please reboot if script remove something..."
sudo apt-get purge linux-*custom-matlala-16-04-2018*


CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
FILE_COUNT="$(find /tmp/ -maxdepth 1 -type f -name 'gpd-pocket-kernel-*.tar.gz' | wc -l)"

cd /tmp

if [ -d "gpd-pocket-kernel" ]; then
	rm -rf /tmp/gpd-pocket-kernel
fi

if [ ! $FILE_COUNT -gt 1 ]; then
	
	mkdir -p /tmp/gpd-pocket-kernel

	if [ $FILE_COUNT -eq 1 ]; then
		 echo "Manual downloaded kernel found..."
		 mv gpd-pocket-kernel-*.tar.gz /tmp/gpd-pocket-kernel/gpd-pocket-kernel-files.tar.gz
		 cd /tmp/gpd-pocket-kernel	 	 
	else
		 echo "Downloading kernel files...."
		 cd /tmp/gpd-pocket-kernel
		 curl -L https://drive.google.com/uc?id=$URL_ID -o "gpd-pocket-kernel-files.tar.gz"
	fi

	echo "Extracting kernel files..."
	tar -xvzf  gpd-pocket-kernel-*.tar.gz 

	echo "Installing new kernel..."
	sudo dpkg -i *.deb

	echo "Update grub..."
	sudo update-grub

	rm -rfd /tmp/gpd-pocket-kernel
	
else
	echo "Manual downloaded kernel found, but more than one. Please leave only one in /tmp directory!"
fi

cd $CURRENT_DIR
