# Ubuntu kernel for GPD Pocket
This is my repository with ubuntu kernel for GPD Pocket. 

Kernel build with lot of patches from Hans De Goede. You can find his repository here:
[Hans De Goede Kernel Repository](https://github.com/jwrdegoede/linux-sunxi.git)

Many thanks for hard work to [Simone alias Stockmind @stockmind](https://github.com/stockmind) and your perfect repo [gpd-pocket-ubuntu-respin](https://github.com/stockmind/gpd-pocket-ubuntu-respin).
This kernel is newest version and i use this repository with Ubuntu 16.04 on my own GPD Pocket.

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
sudo apt-get install build-essential git libncurses5-dev libssl-dev libelf-dev
git clone https://github.com/jwrdegoede/linux-sunxi.git
```
Copy and overwrite my .config to directory ./linux-sunxi

If you have already donwloaded the repository, you can update it with latest commits issuing:
```
git fetch origin
git reset --hard origin/master
```

And build kernel:
```
cd linux-sunxi/
make clean
make -j `getconf _NPROCESSORS_ONLN` deb-pkg LOCALVERSION=-custom-matlala-DD-MM-YYYY
```
After few minutes (or hour), copy generated .deb files to another direcroty (for exmaple /tmp/gpd-pocket-kernel) and install with
```
cd /tmp/gpd-pocket-kernel
sudo dpkg -i *.deb
sudo update-grub
```
