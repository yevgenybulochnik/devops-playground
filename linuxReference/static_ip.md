# Static IP in Ubuntu Xenial 

Navigate to /etc/network, the interfaces file contains current network setup 

#### Example network configuration file 

```
auto eth0
iface eth0 inet dhcp
```

#### Change to Static by 

* change dhcp to static 
* add static ip address 
* add netmask 
* add gateway ie router ip address 
* add dns-nameserver for dns resolution, can be router ip 

#### Example static ip setup 

```
auto eth0
iface eth0 inet static 
address 192.168.2.21
netmask 255.255.255.0
gateway 192.168.2.1
dns-nameservers 192.168.2.1
```
