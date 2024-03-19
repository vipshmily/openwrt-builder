# home

此固件用于我个人家中的主路由。

## 目标平台

x86_64

## 镜像配置

- squashfs 防止意外断电引发文件系统错误，路由器固件损坏
- efi 增加开机启动速度
- 64MB 内核分区，1024M 根目录分区

## 编译选项

- 使用 dnsmasq-full 替代 dnsmasq

## 内置软件

- block-mount 挂载分区
- cfdisk 世界上最好用的磁盘分区工具
- docker docker-compose dockerd docker支持
- git zsh 插件更新
- haveged `docker-compose` 需要 1000 以上的随机熵，我们用 `haveged` 来确保这一点
- htop 用于监控系统资源占用
- nano-full 更友好的文本编辑器
- unzip 常用的解压工具
- wget-ssl 我比较习惯的下载工具
- zoneinfo-all 全时区
- zsh
## Luci 配置

- luci-light 后端
- luci-theme-design 主题，以及其配置插件
- luci-proto-wireguard 回家用
- 简体中文支持

## Luci 插件

- luci-app-dockerman docker前端
- luci-app-mwan3 负载均衡，用于iptv
- luci-app-nut UPS工具
- luci-app-omcproxy omcproxy代理，用于iptv组播
- luci-app-passwall2 出国
- luci-app-udpxy iptv用
- luci-app-upnp upnp
- luci-app-wol WOL

## 其他

- dhcp 删除了 vendorid 支持，从而使得可以通过iptv验证。
