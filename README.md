# OpenWrt Builder

懒人版编译 OpenWrt 系统。

此项目提供了两种编译方案

- 使用 github actions 自动化
- 使用 build.sh 手动运行编译

## github actions

此方案与其他云编译方案类似

## build.sh

此方案提供了一个简单的脚本，运行此脚本将根据提供的配置自动拉去源码并进行编译，如果没有提供编译配置，将自动进入 make menuconfig 界面，同时你也可以提供 seed.config 文件，在此文件基础上修改生成新的编译配置。

此方案提供了一个简单的办法，使得重复运行不会重新拉取源码，从而加速第二次编译，方便前期编译时反复修改配置。

## 致谢

❤️感谢 [P3TERX](https://github.com/P3TERX) 开源的 [Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt) 仓库，通过此仓库，我学习到了很多设计 github actions 的思路。

❤️感谢 [OpenWrt Project](https://openwrt.org/) 的贡献者们，以及本仓库中使用到的其他软件的作者们，他们开发并维护的 OpenWrt 系统及其插件提供了安全、稳定、高性能、可扩展的路由器固件。

❤️感谢 [恩山无线论坛](https://www.right.com.cn/forum/forum.php)的 dan123 同学在 [这个帖子](https://www.right.com.cn/forum/thread-5014665-1-1.html) 里贡献的 convert.sh 脚本，此脚本可以将原有lede插件的简体中文语言支持转化为对19.07及21.02的支持。

❤️感谢 [moewah的这篇文章](https://www.moewah.com/archives/4003.html) 提供的精简config文件的思路。

## License

[MIT](https://github.com/VergilGao/openwrt-builder/blob/master/LICENSE) © VergilGao
