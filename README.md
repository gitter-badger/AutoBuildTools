# 自动化脚本

## 简介

本shell脚本是为了简化本人在工作中遇到的一些不必要的操作而编写的自动化脚本，脚本运行`不具有`通用性；  
`scripts`文件夹内是常用小工具脚本，`WorkBuild/_others_`文件夹内是工作需要的脚本，具体内容可查看相应 Readme.md 文件。

主程序

    AutoBuildTools\WorkBuild\AutoBuildTool

> 功能包含
> * 自动备份 (`部分指定文件`)
> * 构建debian文件系统
> * 编译树莓派内核源码
> * 编译和烧录stm32mp157源码
> * 编译香橙派 (`H616`)


## 安装依赖

``` bash
sudo apt install dialog
```

## 主菜单

![MENU](https://user-images.githubusercontent.com/26021085/151098380-1b97f181-abfd-4e65-9a04-d13d3632cc74.png)

## 文件树结构

### 1、STM32MP157

![image](https://user-images.githubusercontent.com/26021085/155838185-4cfd4ff7-d9b6-4265-9f99-afdac42f1fb7.png)

### 2、raspberrypi

![image](https://user-images.githubusercontent.com/26021085/155838323-c7c1114a-18ed-4611-bd09-3c07e1d2f458.png)

## 注意事项

### 1、共享文件

备份文件脚本需要使用 windows 与 Ubuntu 文件共享，需要在 windows 文件系统里创建两个文件夹 (BackUp、Code)
并且设置成共享文件夹，指定用户可访问;

参考：<https://www.cnblogs.com/smartjourneys/articles/7992298.html>

### 2、FileGee 软件

备份脚本使用到备份软件 FileGee，需要在软件中建立相应的同步任务，可同步到百度网盘;

软件介绍

    待添加;

