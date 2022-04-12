- [0. 说明](#0-说明)
- [1. 内核修改](#1-内核修改)
  - [1.1 mcp2515驱动移植](#11-mcp2515驱动移植)
  - [1.2 wifi驱动移植(TL8189FCB)](#12-wifi驱动移植tl8189fcb)
    - [1.2.1 概述](#121-概述)
    - [1.2.2 驱动源码下载](#122-驱动源码下载)
    - [1.2.3 驱动移植](#123-驱动移植)
    - [1.2.4 模块加载测试](#124-模块加载测试)
- [2. 软件安装](#2-软件安装)
  - [2.1 can 工具](#21-can-工具)
  - [2.2 wifi 工具](#22-wifi-工具)
- [3. 开机后操作](#3-开机后操作)
  - [3.1 can初始化](#31-can初始化)
  - [3.2 wifi自动连接](#32-wifi自动连接)

---

# 0. 说明

在 orangepi 官方编译脚本生成的 buster 系统之上修改,kernel Ver5.13.0

官网：<http://www.orangepi.cn/>

资源下载：<http://www.orangepi.cn/downloadresourcescn/>

![资源下载页](https://user-images.githubusercontent.com/26021085/155490550-e6313fc0-dd3f-400d-9d35-14f9ca777399.png)

#  1. 内核修改

##  1.1 mcp2515驱动移植

主要功能：spi转can

设备树修改：`arch\arm64\boot\dts\allwinner\sun50i-h616-orangepi-zero2.dts`
``` makefile
mcp2515_clock: mcp2515_clock {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency  = <12000000>;          //对应模块上晶振的频率，我的是12MHz的
	};

&spi1 {
    #address-cells = <1>;
    #size-cells = <0>;
    pinctrl-names = "default";
    // pinctrl-0 = <&spi1_pins &spi1_cs_pin>;
    pinctrl-0 = <&spi1_pins>;
    cs-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>;		/* PH9 */

    status = "okay";

    can: mcp2515@0 {
        compatible = "microchip,mcp2515";
        clocks = <&mcp2515_clock>; 				//使用刚刚自己写的时钟
        status = "okay";
        
        reg = <0>;
        spi-max-frequency = <5000000>;

        interrupt-parent = <&pio>;
        interrupts = <2  6  IRQ_TYPE_EDGE_FALLING>;			/* PC6 */
        
        vdd-supply = <&reg_vcc33_wifi>;
        xceiver-supply = <&reg_vcc33_wifi>;
    };

    spidev@1 {
        compatible = "spidev";
        status = "okay";
        reg = <1>;
        spi-max-frequency = <1000000>;
    };
};
```

内核配置修改：

![image](https://user-images.githubusercontent.com/26021085/155493684-0df86a91-d072-4ec2-9f3b-27d3a1b1c455.png)

![image](https://user-images.githubusercontent.com/26021085/155493871-830f2dba-0466-4bff-9f83-e8c7370e810e.png)

参考：

<https://blog.csdn.net/peixiuhui/article/details/72528512>

<https://blog.csdn.net/jklinux/article/details/78709793>

<https://blog.csdn.net/lbaihao/article/details/53193053>

<https://blog.csdn.net/a13698709128/article/details/104484467/>

## 1.2 wifi驱动移植(TL8189FCB)

### 1.2.1 概述

TL8189FCB 模组采用了 Realtek RTL8189FTV-VC-CG 芯片设计, 具有 802.11n 无线局域网(WLAN)网络和 SDIO 接口(兼容 SDIO 1.1/ 2.0)控制器。

引脚定义：

![TL8189FCB](https://user-images.githubusercontent.com/26021085/162897932-29ca1cf4-951e-412b-acb2-54fb59a1f09f.png)

注意：引脚电压保证稳定`3.3v`。

### 1.2.2 驱动源码下载

``` bash
git clone https://github.com/jwrdegoede/rtl8189ES_linux.git
cd rtl8189ES_linux
git checkout -B rtl8189fs origin/rtl8189fs
```

### 1.2.3 驱动移植

将源码拷贝到 `\drivers\net\wireless\`，`rtl8189ES_linux` 文件夹重命名为 `rtl8189fs`

修改文件 `\drivers\net\wireless\Makefile`，添加
```
obj-$(CONFIG_RTL8189FS) += rtl8189fs/
```

修改文件 `\drivers\net\wireless\Kconfig`，添加
```
source "drivers/net/wireless/rtl8189fs/Kconfig"
```

设备树修改：`arch\arm64\boot\dts\allwinner\sun50i-h616-orangepi-zero2.dts`
``` makefile
wifi_pwrseq: wifi-pwrseq {
		compatible = "mmc-pwrseq-simple";
		// clocks = <&rtc 1>;
		// clock-names = "osc32k-out";
		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
		post-power-on-delay-ms = <400>;
	};
    
&mmc1 {
	vmmc-supply = <&reg_dldo1>;
	vqmmc-supply = <&reg_dldo1>;
	mmc-pwrseq = <&wifi_pwrseq>;

	max-frequency = <400000>;
	// max-frequency = <120000000>;

	reset-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */

	bus-width = <4>;
	non-removable;
	keep-power-in-suspend;

	status = "okay";
};
```

内核配置上勾选 (M)rtl8189fs，编译生成模块。


关闭驱动打印调试信息
修改文件 `\drivers\net\wireless\rtl8189fs\include\autoconf.h`，屏蔽 `CONFIG_DEBUG` 宏

### 1.2.4 模块加载测试

系统开机，判断 `sdio-wifi` 是否识别

``` bash
cat /sys/bus/sdio/devices/mmc0:0001:1/uevent        //可查看SDIO设备ID
mount -t debugfs none /sys/kernel/debug
cat /sys/kernel/debug/mmcx/ios                      //可查看WIFI_sdio 相关信息
```

示例如下

![image](https://user-images.githubusercontent.com/26021085/162905658-4984744e-8e19-4551-a3e7-3c9d2e27b52c.png)


将编译好的 `8189fs.ko` 拷贝到文件系统，然后加载驱动模块

``` bash
sudo depmod             // 第一次加载驱动的时候需要运行此命令
sudo modprobe cfg80211  // 先加载 cfg80211.ko， IEEE 协议
sudo modprobe 8189fs    // RTL8189FTV 模块加载 8189fs.ko 模块
```

然后可以使用 `ifconfig -a` 查看到 `wlan0` 设备

参考：
[全志A40i移植 RTL8188FTV/RTL8188FU USB-WiFi](https://xiaohuisuper.blog.csdn.net/article/details/121113707?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2.pc_relevant_antiscanv2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2.pc_relevant_antiscanv2&utm_relevant_index=5)

[H5上rtl8189ftv wifi驱动移植](https://blog.csdn.net/jklinux/article/details/78737691)

[I.MX6 AW-NB177NF wifi HAL 调试修改](https://www.shuzhiduo.com/A/8Bz8R9ro5x/)

[Linux SD卡/SDIO驱动开发](https://blog.csdn.net/h_8410435/article/details/105427238)

#  2. 软件安装
##  2.1 can 工具

``` bash
sudo apt install can-utils iproute2
```

##  2.2 wifi 工具

``` bash
sudo apt install wireless-tools udhcpc
```

#  3. 开机后操作
##  3.1 can初始化

``` bash
sudo ip link set can0 type can bitrate 250000   # 设置波特率

sudo chmod 666 /sys/class/net/can0/tx_queue_len
sudo echo 1024 > /sys/class/net/can0/tx_queue_len   # 设定缓冲区大小

sudo ifconfig can0 up
```

## 3.2 wifi自动连接

