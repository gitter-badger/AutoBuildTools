
---------------- Rpi_expand_rootfs.sh --------------
 
树莓派磁盘空间扩展脚本使用

将 Rpi_expand_rootfs.sh 脚本放入 home 目录;

然后在开机自启动脚本里（一般是 ~/.bashrc 文件）添加以下 5 行内容：

cd ~
chmod +x resize2fs.sh
./resize2fs.sh
chmod +x Rpi_expand_rootfs.sh
./Rpi_expand_rootfs.sh


------------------- GPIO_test.sh ------------------

自动化测试树莓派 40pin 外接输出引脚; 定时让所有 IO 自动输出高低电平;





