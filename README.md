# 自动化工具脚本

## 简介

本shell脚本是为了简化自己在工作中的一些不必要的操作而编写的自动化脚本，脚本运行不具有通用性；  
暂时包括自动备份、构建debian文件系统、编译树莓派内核、编译和烧录stm32mp157源码；

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

