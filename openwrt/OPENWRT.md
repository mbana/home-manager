# `OPENWRT`

### `uboot`

```
MT7988> printenv
...
setenv bootconf_extra mt7988a-bananapi-bpi-r4-pro-4e-sfp
setenv bootargs 'console=ttyS0,115200n1 pci=pcie_bus_perf root=/dev/fit0 rootwait ipv6.disable=1'
saveenv
```

```
setenv bootargs_debug 'earlyprintk log_buf_len=16M print_fatal_signals=1 ignore_log_level loglevel=7 ubi.block=0,firmware reboot=k panic=1 verbose debug'

setenv bootargs 'console=ttyS0,115200n1 earlycon=uart8250,mmio32,0x11000000 pci=pcie_bus_perf root=/dev/fit0 rootwait ipv6.disable=1 nokaslr printk.always_kmsg_dump=Y mitigations=off earlyprintk log_buf_len=16M print_fatal_signals=1 ignore_log_level loglevel=7 ubi.block=0,firmware reboot=k panic=1 verbose debug'
saveenv
boot
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
service network restart
mv /etc/flowtable.conf /etc/flowtable.conf.bak # Permanent fix (survives reboot)
nft delete table inet filter # Apply immediately without reboot
echo 1 > /sys/bus/pci/devices/0003:01:00.0/remove
echo 1 > /sys/bus/pci/rescan
```

### Access XGS-PON stick

```sh
ip -c link show
ethtool eth1
ip -c address show
sudo ip address flush dev eth1
sudo ip route flush dev eth1
sudo ip address add 192.168.11.2/24 dev eth1
ip -c address show dev eth0
ssh root@192.168.11.1 "fw_setenv 8311_gpon_sn 'ADTN250966CD' && reboot"
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


pci=off

 initcall_blacklist=simpledrm_platform_driver_init

Command line: watchdog.stop_on_reboot=0 softdog.soft_panic=1 pmic_pon_log.smpl_panic=1 sec-auth-ds28e31.slavepcb=6 sec_vibrator_inputff_module.vib_le_est=0 common_muic.muic_param_pdic_info=1 common_muic.muic_param_pmic_info=3 common_muic.muic_param_afc_mode=0x30 pdic_notifier_module.pdic_param_lpcharge=0 nfc_nxp_sec.nfc_param_lpcharge=0 nfc_slsi_sec.nfc_param_lpcharge=0 sec-battery.charging_mode=0x3030 sec-battery.sales_code=EUX sb-mfc.wireless_ic=0x59101220 cps4059_charger.wireless_ic=0x59101220 cps4059_charger.carrierid=EUX s2miw06_charger.wireless_ic=0x59101220 s2miw06_charger.carrierid=EUX msm_rtb.enable=0 sec_qc_debug.cp_debug_level=0x55FF stwlc89_charger.carrierid=EUX usb_notify_layer.usb_restrict=0 sec_pon_alarm.rtcalarm=0 sec_pon_alarm.lpcharge=0 hdm.status=NONE sec_qc_hw_param.dram_info=010A0016G sec_qc_hw_param.revision=16 frpc-adsprpc.signoff=0x7277 sec_debug.debug_level=0x4f4c sec_debug.enable=0 sec_debug.enable_user=0 sec_debug.force_upload=0x0 sec_debug.ap_serial=0x0000046A71069596 sec_debug.ddr_serial=SHIP sec_debug.dump_sink=0x0 sec_debug.reboot_multicmd=0x1 sec_qc_user_reset.boot_recovery=0 kg_drv.fuse_bit=00 kg_drv.ap_serial=AAAA0000000000000000046A71069596 kg_drv.enable=0 console=ttynull stack_depot_disable=on cgroup_disable=pressure kasan.stacktrace=off kvm-arm.mode=protected bootconfig android_arch_task_struct_size=512 loglevel=6 log_buf_len=512K cpufreq.default_governor=performance sysctl.kernel.sched_pelt_multiplier=4 no-steal-acc kpti=0 swiotlb=0 loop.max_part=7 irqaffinity=0-1 fw_devlink.strict=1 pcie_ports=compat pci-msm-drv.pcie_sm_regs=0x1D07000,0x1040,0x1048,0x3000,0x1 kasan=off rcupdate.rcu_expedited=1 rcu_nocbs=0-7 cgroup_disable=pressure printk.console_no_auto_verbose=1 sysctl.kernel.panic_on_rcu_stall=1 disable_dma32=on restrict_cma_redirect=true memblock_memsize=procfs fault_around_bytes=32768 kswapd_cpumask=0x3f kcompactd_cpumask=0x3f raise_min_free_kbytes=false cgroup.memory=nokmem,nosocket disable_pcp_high_max video=vfb:640x400,bpp=32,memsize=3072000 printk.devkmsg=on firmware_class.path=/vendor/firmware_mnt/image bootconfig loop.max_part=7  msm_drm.dsi_display0=M3_S6E3HAG_AMB689LT01_VHM: msm_drm.lcd_id=019987 sec_common_fn.lcd_id=019987 msm_drm.cell_id=EC0A1510051A1F0BF30C8E rootwait ro init=/init silent_boot.mode=nonsilent console=null stop_on_panic nokaslr nowatchdog sapa=0

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

## Virgin Media

03457 740 740
