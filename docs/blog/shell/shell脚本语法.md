# 1. 前言

Shell 既是一种命令语言，又是一种程序设计语言。

Shell 是指一种应用程序，这个应用程序提供了一个界面，用户通过这个界面访问操作系统内核的服务。

Shell 编程跟 JavaScript、php 编程一样，只要有一个能编写代码的文本编辑器和一个能解释执行的脚本解释器就可以了。

由于易用和免费，Bash 在日常工作中被广泛使用。同时，Bash 也是大多数Linux 系统默认的 Shell。在一般情况下，人们并不区分 Bourne Shell 和 Bourne Again Shell，所以，像 #!/bin/sh，它同样也可以改为 `#!/bin/bash`。

`#!` 告诉系统其后路径所指定的程序即是解释此脚本文件的 `Shell` 程序。

1、打开文本编辑器(可以使用 vi/vim 命令来创建文件)，新建一个文件 test.sh，扩展名为 sh（sh代表shell），扩展名并不影响脚本执行，如果你用 php 写 shell 脚本，扩展名就用 php 好了。

``` bash

#!/bin/bash
echo "Hello World !"
```

`#!` 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell。

echo 命令用于向窗口输出文本。

2、运行 shell 脚本有两种方法：

a）作为可执行程序

将上面的代码保存为 test.sh，并 cd 到相应目录

``` bash
chmod +x ./test.sh  #使脚本具有执行权限
./test.sh  #执行脚本
```

b）作为解释器参数

直接运行解释器，其参数就是 `shell` 脚本的文件名，如：

``` bash
/bin/sh test.sh
/bin/php test.php
#这种方式运行的脚本，不需要在第一行指定解释器信息，写了也没用。
```

# 2. Shell 变量

定义变量时，变量名不加 $ 符号 (PHP语音中变量需要)，如：

``` bash

your_name="lodge"
```

注意：变量名和等号 (=) 之间不能有空格，并且变量命名有只能使用英文字母、数字、下划线，不能以数字开头，不能有空格。

使用一个定义过的变量，只要在变量名前面加美元符号即可，如：

``` bash
your_name="lodge"
echo $your_name
your_name="Soume"        # 已定义的变量可以重新赋值;
echo ${your_name}        # 推荐使用这种形式，加上大括号;
 
# 使用 unset 命令可以删除变量
unset your_name
echo ${your_name}        # 不会有任何输出;
```

字符串是 shell 中最常用的数据类型，字符串可以使用单引号也可以使用双引号：

``` bash
# 单引号字符串
str='this is a string'
 
# 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
# 单引号字符串中不能出现单独一个的单引号（对单引号使用转义符后也不行）,但可成对出现,作为字符串拼接使用;
 
# 双引号字符串
your_name='lodge'
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str
 
# 输出结果为：
Hello, I know you are "lodge"! 
 
# 双引号里可以有变量，可以出现转义字符;
```

# 3. Shell 参数

参数处理 |	含义
:--- | :---
$0	 |  当前脚本文件名
$n    |	传递给脚本或函数的参数，n 代表第 n 个参数。如，第一个参数是 $1。
$#    |	传递到脚本的参数个数
$*    |	以一个单字符串显示所有向脚本传递的参数。  如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
\$$    |	脚本运行的当前进程ID号
$!    |	后台运行的最后一个进程的ID号
$@    |	与$*相同，但是使用时加引号，并在引号中返回每个参数。  如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$-    |	显示Shell使用的当前选项，与 set 命令功能相同。
$?    |	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。


$* 与 $@ 区别：

相同点：都是引用所有参数。
不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，，则 " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）。

``` bash
#!/bin/bash
 
echo "Shell 参数";
echo "第一个参数为：$1";
echo "参数个数为：$#";
echo "传递的参数作为一个字符串显示：$*";
 
echo "-- \$* ---"
for i in "$*"; do
    echo $i
done
 
echo "-- \$@ ---"
for i in "$@"; do
    echo $i
done
```

运行结果：

``` bash
$ ./test.sh 1 2 3
Shell 参数
第一个参数为：1
参数个数为：3
传递的参数作为一个字符串显示：1 2 3
-- $* ---
1 2 3
-- $@ ---
1
2
3
 
```

# 4. 转义字符

![bf84994705e90d30a15f83892ae92595](https://user-images.githubusercontent.com/26021085/165073060-399d8f4b-b184-4594-a7be-3c5994badaf1.png)

可以使用 echo 命令的 -e 选项启用转义， -E 选项禁止转义，默认也是不转义的；使用 -n 选项可以禁止插入换行符。

# 5. 命令替换
    命令替换是指Shell可以先执行命令，将输出结果暂时保存，在适当的地方输出。

# 6. 变量替换
    变量替换可以根据变量的状态（是否为空、是否定义等）来改变它的值

![dded5e01cf061e0eb8e78dd74f76a06c](https://user-images.githubusercontent.com/26021085/165073210-480ff5b4-e604-4c07-bebc-38d73a3fd743.png)

# 7. shell运算符

## 7.1 算术运算符

运算符  |	说明  |	举例
:--: | :--: | :--:
\+	  | 加法  |	`expr $a + $b` 结果为 30。
\-   |	减法  |	`expr $a - $b` 结果为 -10。
\*	  | 乘法  |	`expr $a \* $b` 结果为  200。
/	  | 除法  |	`expr $b / $a` 结果为 2。
%	  | 取余  |	`expr $b % $a` 结果为 0。
=	  | 赋值  |	a=$b 将把变量 b 的值赋给 a。
==	| 比较两个数字，相等则返回 true |	[ $a == $b ] 返回 false。
!=	| 比较两个数字，不相等则返回 true |	[ $a != $b ] 返回 true。

注意：表达式和运算符之间要有括号要放在方括号之间，并且要有空格；乘号 (*) 前面要加反斜杠 (\) 才能实现乘法运算 (Mac 中不需要) ；完整表达式要被 ` ` 包含，注意是反引号，Esc键下面。

例如：[$a==$b] 是错误的，必须写成 [ $a == $b ]。

## 7.2 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

假定变量 a 为 10，变量 b 为 20：

运算符  |	说明   |	举例
:--: | :--: | :--:
-eq	| 检测两个数是否相等，相等返回 true |	[ $a -eq $b ] 返回 false。
-ne	| 检测两个数是否不相等，不相等返回 true |	[ $a -ne $b ] 返回 true。
-gt	| 检测左边的数是否大于右边的，如果是，则返回 true |	[ $a -gt $b ] 返回 false。
-lt	| 检测左边的数是否小于右边的，如果是，则返回 true |	[ $a -lt $b ] 返回 true。
-ge	| 检测左边的数是否大于等于右边的，如果是，则返回 true |	[ $a -ge $b ] 返回 false。
-le	| 检测左边的数是否小于等于右边的，如果是，则返回 true |	[ $a -le $b ] 返回 true。

## 7.3 布尔、逻辑运算符

假定变量 a 为 10，变量 b 为 20：

运算符	| 说明  |	举例
:--: | :--: | :--:
! |	非运算，表达式为 true 则返回 false，否则返回 true |	[ ! false ] 返回 true。
-o  |	或运算，有一个表达式为 true 则返回 true |	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
-a  |	与运算，两个表达式都为 true 才返回 true |	[ $a -lt 20 -a $b -gt 100 ] 返回 false。
&&  |	逻辑的 AND  |	[[ $a -lt 100 && $b -gt 100 ]] 返回 false
\|\|  |	逻辑的 OR	  | [[ $a -lt 100 || $b -gt 100 ]] 返回 true

## 7.4 字符串运算符

假定变量 a 为 "abc"，变量 b 为 "efg"

运算符	| 说明	| 举例
:--: | :--: | :--:
=	  | 检测两个字符串是否相等，相等返回 true |	[ $a = $b ] 返回 false。
!=	| 检测两个字符串是否不相等，不相等返回 true |	[ $a != $b ] 返回 true。
-z	| 检测字符串长度是否为0，为0返回 true |	[ -z $a ] 返回 false。
-n	| 检测字符串长度是否不为 0，不为 0 返回 true  |	[ -n "$a" ] 返回 true。
$	  | 检测字符串是否为空，不为空返回 true |	[ $a ] 返回 true。

## 7.5 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。
例：变量 file 表示文件（file="/var/www/runoob/test.sh"），它的大小为 100 字节，具有 rwx 权限。

操作符	| 说明 |	举例
:--: | :-- | :--:
-b file	| 检测文件是否是块设备文件，是，返回 true |	[ -b $file ] 返回 false。
-c file	| 检测文件是否是字符设备文件，是，返回 true |	[ -c $file ] 返回 false。
-d file	| 检测文件是否是目录，是，返回 true |	[ -d $file ] 返回 false。
-f file	| 检测文件是否是普通文件 (不是目录、设备文件)，是，返回 true  | [ -f $file ] 返回 true。
-g file	| 检测文件是否设置了 SGID 位，是，返回 true |	[ -g $file ] 返回 false。
-k file	| 检测文件是否设置了粘着位(Sticky Bit)，是，返回 true |	[ -k $file ] 返回 false。
-p file	| 检测文件是否是有名管道，是，返回 true |	[ -p $file ] 返回 false。
-u file	| 检测文件是否设置了 SUID 位，是，返回 true |	[ -u $file ] 返回 false。
-r file	| 检测文件是否可读，是，返回 true |	[ -r $file ] 返回 true。
-w file	| 检测文件是否可写，是，返回 true |	[ -w $file ] 返回 true。
-x file	| 检测文件是否可执行，是，返回 true |	[ -x $file ] 返回 true。
-s file	| 检测文件是否为空（文件大小是否大于0），非空，返回 true  |	[ -s $file ] 返回 true。
-e file	| 检测文件（包括目录）是否存在，是，返回 true |	[ -e $file ] 返回 true。

# 8. printf 命令的语法

``` bash
printf  format-string  [arguments...]
``` 

format-string 为格式控制字符串，arguments 为参数列表。

这里仅说明与C语言 printf() 函数的不同：

* printf 命令不用加括号
* format-string 可以没有引号，但最好加上，单引号双引号均可。
* 参数多于格式控制符(%)时，format-string 可以重用，可以将所有参数都转换。
* arguments 使用空格分隔，不用逗号。

# 9. 输入输出重定向

命令 |	说明
:--: | :--
command > file	| 将输出重定向到 file。
command < file	| 将输入重定向到 file。
command >> file	| 将输出以追加的方式重定向到 file。
n > file	  | 将文件描述符为 n 的文件重定向到 file。
n >> file	  | 将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m	    | 将输出文件 m 和 n 合并。
n <& m	    | 将输入文件 m 和 n 合并。
<< tag	    | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。
