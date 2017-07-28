setup not currently working as of 7/28/2017
# Raspberry Pi Zero W Headless Setup

This document outlines the process behind setting up a Raspberry Pi Zero W for headless starting. The Pi Zero does not have a wired ethernet port connection, so wifi has to be preconfigured in order to ssh into the machine. This setup uses windows as a host machine to flash the micro sd card and preconfigure ssh/wifi

#### Process with raspbian desktop (Note: [raspbian lite](https://www.raspberrypi.org/forums/viewtopic.php?p=990172))
1. Download [raspbian](https://www.raspberrypi.org/downloads/raspbian/) and unzip the image file. 
2. Use [etcher](https://etcher.io/) to flash the micro sd card with raspbian.
3. Unmount the sd card and remount. The remounted sd card should show as a bootable drive 
4. Add a text file in /boot named ssh with no file extensions 
5. Add a text file in /boot named wpa_supplicant.conf for wifi configuration on boot, see below to configure this file 
6. Start your raspberry pi zero with the newly flashed and configured sd card 
7. SSH into the new machine, `ssh pi@<ip-address>` pi:raspberry(username:password)
8. Change your unencrypted psk using the command `wpa_passphrase [ssid] [passphrase]`
9. Paste new encyrpted psk into `wpa_supplicant.conf` in /etc/wpa_supplicant/

#### wpa_supplicant.conf example setup
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
   ssid="<your ssid>"
   psk="<your password>"
}
```
