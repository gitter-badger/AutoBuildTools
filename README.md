
本shell脚本是为了简化自己在工作中的一些不必要的操作而编写的自动化脚本，脚本运行不具有通用性；
暂时包括自动备份、构建debian文件系统、编译树莓派内核、编译和烧录stm32mp157源码；

主菜单：

/==================================================\
|                  [ Main Menu ]                   |
|            ***** Please choose *****             |
|--------------------------------------------------|
|   [55]: Back up all data!                        |
|--------------------------------------------------|
|              ** Build ArmDebian **               |
|--------------------------------------------------|
|   101: buster          |   102: bullseye         |
|--------------------------------------------------|
|  ** STM32MP157 **                                |
|--------------------------------------------------|
|   1: STlinux 5.4       |   2: STlinux 5.10       |
|--------------------------------------------------|
|   9: Restore Factory Image                       |
|--------------------------------------------------|
|  ** RaspBerryPi **                               |
|--------------------------------------------------|
|   3: compile image     |   4: install image      |
|--------------------------------------------------|
|                                   Q/q: Quit!     |
\==================================================/

 Your choice:



1、备份文件脚本需要使用 windows 与 Ubuntu 文件共享，需要在 windows 文件系统里创建两个文件夹 (BackUp、Code)
并且设置成共享文件夹，指定用户可访问;
参考：https://www.cnblogs.com/smartjourneys/articles/7992298.html

2、备份脚本使用到备份软件 FileGee，需要在软件中建立相应的同步任务，可同步到百度网盘;


