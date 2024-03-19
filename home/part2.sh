#!/bin/bash

# Replace the official source package
./scripts/feeds install -p vergilgao golang xray-core v2ray-geodata sing-box

# replace default theme to argon
rm -rf feeds/luci/themes/luci-theme-design/
sed -i 's/luci-theme-bootstrap/luci-theme-design/' feeds/luci/collections/luci*/Makefile

# Modify DHCP client for iptv
sed -i 's/\${vendorid:+-V "$vendorid"}/-V \"\"/g' package/network/config/netifd/files/lib/netifd/proto/dhcp.sh
