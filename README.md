# Ubuntu kernel for GPD Pocket
This is my repository with ubuntu kernel for GPD Pocket. 

Kernel build with lot of patches from Hans De Goede. You can find his repository here:
[Hans De Goede Kernel Repository](https://github.com/jwrdegoede/linux-sunxi.git)

Many thanks for hard work to [Simone alias @stockmind](https://github.com/stockmind) and your perfect repo [gpd-pocket-ubuntu-respin](https://github.com/stockmind/gpd-pocket-ubuntu-respin).
This kernel is newest version than his repo and I use this repository with Ubuntu 16.04 on my own GPD Pocket.

# Install
```
git clone https://github.com/petrmatula190/gpd-pocket-kernel
cd gpd-pocket-kernel/
chmod +x install-kernel.sh
./install-kernel.sh
```

# Update
```
cd gpd-pocket-kernel/
git pull
./install-kernel.sh
```

# Build own kernel with my .config

You must have free around 5-10GiB space on disk for download and build kernel. Sources files have around 2.5GiB.

Fisrt, install tools and clone Hans repo
```
sudo apt-get install build-essential git libncurses5-dev libssl-dev libelf-dev bison flex
git clone https://github.com/jwrdegoede/linux-sunxi.git
```
Copy and overwrite my `.config` to directory ./linux-sunxi

If you have already donwloaded the repository, you can update it with latest commits issuing:
```
make clean
git fetch origin
git reset --hard origin/master
```

And build kernel:
```
cd linux-sunxi/
make clean
make -j `getconf _NPROCESSORS_ONLN` deb-pkg LOCALVERSION=-custom-matlala-DD-MM-YYYY
```
After few minutes (or hour, depend on HW), compress all generated .deb files into a tar.gz archive with name "gpd-pocket-kernel-files.tar.gz", put it into `/tmp` directory and run `install-kernel.sh`.
```
cd /tmp/gpd-pocket-kernel
sudo dpkg -i *.deb
sudo update-grub
```

# Older kernel relases
If you want download and install my older kernel version, you can download from my [Google drive](https://drive.google.com/drive/folders/1XmwYXIRxsdo4GZti8woYtvhOI1pvXB9c). My script can install it automatically, if you put downloaded kernel archive into `/tmp` directory and run `install-kernel.sh`.
