#This script automatically build kernel, you must edit .config before run!
#!/bin/bash

version=$(sed -n '3p' .config | cut -d' ' -f 3)
builddate=$(date +%d-%m-%Y)
buildname="custom-matlala"

cd linux-sunxi/ # start folder

#clean and update repo
echo "Clean old build and hard update Hans git repo. Wait some time..."
make clean
git fetch origin
git reset --hard origin/master
echo "Cloned. Please edit .config file manually."

#wait to update config manually
read -p "Are you sure you want to continue? <y/N> " prompt
if [[ $prompt =~ [yY](es)* ]]
then
  #promt yes, build
  make -j `getconf _NPROCESSORS_ONLN` deb-pkg LOCALVERSION=-$buildname=-$buildname-$builddate # build
  cd .. 
  mkdir kernel-$buildname-$version-$builddate
  mv linux-*-$buildname-$builddate* ./kernel-custom-matlala-$version-$builddate
  cd ./kernel-$buildname-$version-$builddate
  tar -caf gpd-pocket-kernel-$version-$builddate.tar.gz linux-*-$buildname-$builddate*.deb
  mv gpd-pocket-kernel-$version-$builddate.tar.gz ./../
  cd ..
  rm -rf kernel-$buildname-$version-$builddate
  echo "Build kernel comlete."
  echo "Generated file: gpd-pocket-kernel-$version-$builddate.tar.gz" 
else
  #promt no, cancel
  echo "Build kernel canceled."
  





