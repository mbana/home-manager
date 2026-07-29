# `OPENWRT`

### `uboot`

```
MT7988> printenv

setenv bootconf_extra mt7988a-bananapi-bpi-r4-pro-4e-sfp
setenv bootargs 'console=ttyS0,115200n1 pci=pcie_bus_perf root=/dev/fit0 rootwait ipv6.disable=1'
saveenv
```

### Router config

```sh
uci set network.wan.device='br-wan'
uci set network.wan.proto='static'
uci set network.wan.ipaddr='178.255.93.241'
uci set network.wan.netmask='255.255.255.254'
uci set network.wan.gateway='178.255.93.240'
uci set network.wan.dns='1.1.1.1 8.8.8.8 188.215.74.252'
uci commit
```

### Access XGS-PON stick

```sh
ip -c link show
ethtool eth1
ip -c address show
ip address flush dev br-wan
ip route flush dev br-wan
ip address add 192.168.11.2/24 dev br-wan
ip -c address show dev br-wan
```

### Kernel args

```
 noresume reboot=k panic=1 nomodule nomodules

setenv bootargs_debug 'printk.console_no_auto_verbose ignore_loglevel loglevel=7 sysrq_always_enabled=1 initcall_debug ignore_loglevel loglevel=7 log_buf_len=10M print_fatal_signals=1 earlyprintk debug verbose=1 ipv6.disable=1'

setenv bootargs_debug 'ignore_loglevel loglevel=7 sysrq_always_enabled=1 initcall_debug log_buf_len=10M print-fatal-signals=1 ipv6.disable=1'

setenv bootdelay 8
setenv bootargs 'ttyS0,115200n1 root=/dev/fit0 rootwait verbose debug ignore_loglevel log_buf_len=10M nokaslr printk.devkmsg=on silent_boot.mode=nonsilent sysrq_always_enabled=1 initcall_debug  ipv6.disable=1'
saveenv
reset



stop_on_panic watchdog.stop_on_reboot=0 softdog.soft_panic=1 ipv6.disable=1' $bootargs_debug'




saveenv

reset

pci=off

 initcall_blacklist=simpledrm_platform_driver_init
```

### resize disk

From <https://forum.banana-pi.org/t/bpi-r4-how-to-resize-overlay-of-emmc/18078/5?u=mbana> and <https://forum.openwrt.org/t/bananapi-bpi-r4-resize-emmc-to-use-full-8gb/244818>:


> Boot from nand
> Install cfdisk
> cfdisk /dev/mmcblk0
> resize free space
> reboot from emmc
> flash sysupgrade


root@OpenWrt:~# umount /dev/fitrw
root@OpenWrt:~# firstboot -y
/dev/fitrw is not mounted
/dev/fitrw will be erased on next mount


