# Ubuntu kernel for GPD Pocket
This is my repository with ubuntu kernel for GPD Pocket. 

Kernel build with lot of patches from Hans De Goede. You can find his repository here:
[Hans De Goede Kernel Repository](https://github.com/jwrdegoede/linux-sunxi.git)

Many thanks for hard work to [Simone alias @stockmind](https://github.com/stockmind) and your perfect repo [gpd-pocket-ubuntu-respin](https://github.com/stockmind/gpd-pocket-ubuntu-respin).
This kernel is newest version than his repo and I use this repository with Ubuntu 16.04 on my own GPD Pocket.

# Know Bugs
Check [buglist in testing branch](https://github.com/petrmatula190/gpd-pocket-kernel/blob/petrmatula190-testing/know-bugs). I wrote something about every my released test build.

Do not use Ubuntu 16.04 and kernel 4.16+ with disabled DPTF (unlocked BIOS). 
Kernel fan driver not working with disabled DPTF and python fan script no longer working too, because kernel should change some security options for GPIO pins (used for set fan speed). Ubuntu 16.04 with enabled DPTF have total stucks and I cannot find reason (logs not writen while total stuck). 
Ubuntu 17.04+ do not have this issue and you can leave DPTF enabled and use gpdfan ekrnel driver wthout isues.

```
$ systemctl status gpdfand.service
● gpdfand.service - GPD Fan Daemon
   Loaded: loaded (/etc/systemd/system/gpdfand.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Čt 2018-03-08 18:32:57 CET; 5min ago
  Process: 1305 ExecStart=/usr/local/sbin/gpdfand --time=${TIME} --turbo=${TURBO} --min=${MIN} --med=${MED} --max=${MAX} (code=exited, status=1/FAILURE)
 Main PID: 1305 (code=exited, status=1/FAILURE)

bře 08 18:32:56 gpdpocket systemd[1]: Started GPD Fan Daemon.
bře 08 18:32:57 gpdpocket gpdfand[1305]: Traceback (most recent call last):
bře 08 18:32:57 gpdpocket gpdfand[1305]:   File "/usr/local/sbin/gpdfand", line 76, in <module>
bře 08 18:32:57 gpdpocket gpdfand[1305]:     set_fans(0,1)
bře 08 18:32:57 gpdpocket gpdfand[1305]:   File "/usr/local/sbin/gpdfand", line 46, in set_fans
bře 08 18:32:57 gpdpocket gpdfand[1305]:     gpio.write(unicode(a))
bře 08 18:32:57 gpdpocket gpdfand[1305]: IOError: [Errno 1] Operation not permitted
bře 08 18:32:57 gpdpocket systemd[1]: gpdfand.service: Main process exited, code=exited, status=1/FAILURE
bře 08 18:32:57 gpdpocket systemd[1]: gpdfand.service: Unit entered failed state.
bře 08 18:32:57 gpdpocket systemd[1]: gpdfand.service: Failed with result 'exit-code'.
```

# Install
```
git clone https://github.com/petrmatula190/gpd-pocket-kernel
cd gpd-pocket-kernel/
chmod +x install-kernel.sh build-kernel.sh
./install-kernel.sh
```

# Update
```
cd gpd-pocket-kernel/
git pull
./install-kernel.sh
```

# Build own kernel with my .config - Manual way

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

# Automatic build own kerne wth my script
If you want more automatic process, run `build.kernel.sh` and edit `.config` manually and conform build when yo will promt.
I created this script for me and there is for everybody. Version number will be extracted from `.config` file (3rd line and 3rd column). Script must be started from folder ./linux-sunxi and final product will be tar.gz file `gpd-pocket-kernel-$version-$builddate.tar.gz` in `./../linux-sunxi/`.


# Older kernel relases
If you want download and install my older kernel version, you can download from my [Google drive](https://drive.google.com/drive/folders/1XmwYXIRxsdo4GZti8woYtvhOI1pvXB9c). My script can install it automatically, if you put downloaded kernel archive into `/tmp` directory and run `install-kernel.sh`.

# Do you want be tester
I have [testing branch](https://github.com/petrmatula190/gpd-pocket-kernel/tree/petrmatula190-testing) and two testers on opposite sides of Eatch. Do you want be next? 
It can be little bit dangerous, but I have not time, knowlenge and HW for testing everything (BT and exotic HW for example). So, I will be hapy If you try new test build and report bugs on github (or you can add me on skype/facebook) let me message in [issues page](https://github.com/petrmatula190/gpd-pocket-kernel/issues).
