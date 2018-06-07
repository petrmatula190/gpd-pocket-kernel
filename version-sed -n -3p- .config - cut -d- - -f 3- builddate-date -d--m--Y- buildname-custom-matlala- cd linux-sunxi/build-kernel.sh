#This script automatically build kernel, you must edit .config before run!
#!/bin/bash

version=$(sed -n '3p' .config | cut -d' ' -f 3)
builddate=$(date +%d-%m-%Y)
buildname="custom-matlala"
cd linux-sunxi/ # start folder
make -j `getconf _NPROCESSORS_ONLN` deb-pkg LOCALVERSION=-buildname=-$buildname-$builddate # build
cd .. 
mkdir kernel-$buildname-$version-$builddate
mv linux-*-$buildname-$builddate* ./kernel-custom-matlala-$version-$builddate
cd ./kernel-$buildname-$version-$builddate
tar -caf gpd-pocket-kernel-$version-$builddate.tar.gz linux-*-$buildname-$builddate*.deb
mv gpd-pocket-kernel-$version-$builddate.tar.gz ./../
cd ..
rm -rf kernel-$buildname-$version-$builddate
