# `OPENWRT`

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