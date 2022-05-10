# 目录

# 1. git 下载安装脚本

``` bash
git clone https://github.com/th33xitus/kiauh.git
```

> 运行环境：  
> 基于 `debian` 系的 `Linux` 操作系统， 如 `debian10(buster)`；  
> 不能以 `root` 用户登录；  

# 2. 执行脚本

> 切换到用户主目录

``` bash
cd ~
./kiauh/kiauh.sh
```

选择 `1` 安装，然后分别选择安装以下内容：

![image](https://user-images.githubusercontent.com/26021085/165011078-8f491940-5ce2-486d-9dd3-504d64546b8f.png)

安装过程中需要获取 `root` 权限，有选择的话按默认选择就行；  
在安装 `klipper` 时，有要输入安装数目的话，输入 `1` 即可。  
以上项目安装完成后，回到脚本主页，保证所选项目都是 `Install` 状态。  

![image](https://user-images.githubusercontent.com/26021085/165014995-1c6a10f4-0428-490d-b003-0243fe2324a8.png)

正常情况下，显示屏会显示 `klipper` 主界面；浏览器访问 `IP`，会进入 `fluidd` 主页

![image](https://user-images.githubusercontent.com/26021085/165012239-3c9b5917-f503-4ca1-be42-982107827430.png)

# 3. 异常情况解决

一般来说，保证安装过程中网络通畅，成功安装 `klipper`、`moonraker`、`fluidd` 是没有问题的，出现安装失败，运行 `kiauh` 脚本卸载对应模块，重新安装即可。

对于 `klipperscreen`，若显示屏没有出现 `klipper` 界面，可以运行查看 `klipperscreen` 服务状态

``` bash
journalctl -xe -u KlipperScreen.service
```

## 3.1 出现 Permission denied 错误

> err: xf86OpenConsole: Cannot open virtual console 2 (Permission denied)

修改 `/etc/X11/Xwrapper.config`

``` bash
allowed_users=anybody
needs_root_rights=yes
```

## 3.2 安装 libgl1-mesa-dri

``` bash
sudo apt install libgl1-mesa-dri
```

## 3.3 klipperscreen 重新安装

可以尝试以下安装方法

1. 修改 `~/kiauh/scripts/install_klipperscreen.sh` 文件

``` text
cd ${HOME} && git clone $KLIPPERSCREEN_REPO
```
替换为：
``` text
cd ${HOME} && cp -r ${GITHUB_SRC}/KlipperScreen .
```

2. 新建文件夹

``` bash
mkdir ~/kiauh/github_src
```

3. 下载源码

``` bash
cd ~/kiauh/github_src
git clone https://github.com/jordanruthe/KlipperScreen.git
```

4. 修改 `~/kiauh/github_src/KlipperScreen/scripts/KlipperScreen-install.sh` 文件

``` text
FBTURBO="xserver-xorg-video-fbturbo"
```
替换为：
``` text
FBTURBO="xserver-xorg"
```

5. 添加 `~/kiauh/kiauh.sh` 文件

添加以下内容
``` text
### set important directories
# Code cached from Github
GITHUB_SRC=${SRCDIR}/kiauh/github_src
```

6. 运行 `kiauh` 脚本，卸载 `KlipperScreen`，重新安装

---

参考：<https://user-images.githubusercontent.com/26021085/167590452-d8d5d043-f6f8-4f78-8905-c4a38b4441e0.png>