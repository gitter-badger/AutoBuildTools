<!-- vscode-markdown-toc -->
* 1. [内核修改](#)
	* 1.1. [1、mcp2515 驱动移植](#mcp2515)
* 2. [软件安装](#-1)
	* 2.1. [1、can 工具](#can)
* 3. [开机后操作](#-1)
	* 3.1. [1、can初始化](#can-1)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

# H616 文件系统修改记录



在 orangepi 官方编译脚本生成的 buster 系统之上修改,kernel Ver5.13.0

官网：<http://www.orangepi.cn/>

资源下载：<http://www.orangepi.cn/downloadresourcescn/>

![资源下载页](https://user-images.githubusercontent.com/26021085/155490550-e6313fc0-dd3f-400d-9d35-14f9ca777399.png)

##  1. <a name=''></a>内核修改
###  1.1. <a name='mcp2515'></a>1、mcp2515 驱动移植
主要功能：spi转can

设备树修改：arch\arm64\boot\dts\allwinner\sun50i-h616-orangepi-zero2.dts
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

##  2. <a name='-1'></a>软件安装
###  2.1. <a name='can'></a>1、can 工具
``` bash
sudo apt install can-utils iproute2
```

##  3. <a name='-1'></a>开机后操作
###  3.1. <a name='can-1'></a>1、can初始化
``` bash
sudo ip link set can0 type can bitrate 250000   # 设置波特率

sudo chmod 666 /sys/class/net/can0/tx_queue_len
sudo echo 1024 > /sys/class/net/can0/tx_queue_len   # 设定缓冲区大小

sudo ifconfig can0 up
```