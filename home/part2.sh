#!/bin/bash

# Replace the official source package
#./scripts/feeds install -p vergilgao golang xray-core v2ray-geodata sing-box

# replace default theme to argon
rm -rf feeds/luci/themes/luci-theme-design/
sed -i 's/luci-theme-bootstrap/luci-theme-design/' feeds/luci/collections/luci*/Makefile

# Modify DHCP client for iptv
#sed -i 's/\${vendorid:+-V "$vendorid"}/-V \"\"/g' package/network/config/netifd/files/lib/netifd/proto/dhcp.sh

# Modify default IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# 默认开启 wifi
#sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Modify ubi the partition size to max 118.5M
#sed -i 's/0x6e00000/0x7680000/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-nokia-ea0326gmp.dts

# 修正连接数
#sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65536' package/base-files/files/etc/sysctl.conf

# 替换编译目录文件
cp -f $GITHUB_WORKSPACE/config/immortalwrt-immortalwrt-mt798x/mt7981-nokia-ea0326gmp.dts $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/dts/mt7981-nokia-ea0326gmp.dts

# 自定义添加/删除/更新软件包
#rm -rf package/istore/luci-app-quickstart
#rm -rf package/istore/luci-app-store
#rm -rf package/istore/quickstart
git clone https://github.com/kenzok8/small-package.git package/small-package

rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

rm -rf feeds/luci/applications/luci-app-adbyby-plus
rm -rf feeds/net/applications/luci-app-adbyby-plus
git clone https://github.com/coolsnowwolf/luci.git package/luci-app-adbyby-plus
#git clone --depth=1 -b main https://github.com/kongfl888/luci-app-adbyby-plus-lite.git package/luci-app-adbyby-plus

rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/small-package/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/luci-app-openclash/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash package/luci-app-openclash/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1680MHz" ;;/}' package/emortal/autocore/files/cpuinfo