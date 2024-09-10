#!/bin/bash

# Replace the official source package
#./scripts/feeds install -p vergilgao golang xray-core v2ray-geodata sing-box

# replace default theme to argon
rm -rf feeds/luci/themes/luci-theme-design/
sed -i 's/luci-theme-bootstrap/luci-theme-design/' feeds/luci/collections/luci*/Makefile

# Modify DHCP client for iptv
#sed -i 's/\${vendorid:+-V "$vendorid"}/-V \"\"/g' package/network/config/netifd/files/lib/netifd/proto/dhcp.sh

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 默认开启 wifi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 添加/删除/更新软件包
git clone -b v5 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang