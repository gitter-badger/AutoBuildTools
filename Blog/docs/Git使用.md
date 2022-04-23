git 使用
Git 官网：https://github.com/
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
一、 配置 Git
在本地创建 ssh key；
$ ssh-keygen -t rsa -C "your_email@youremail.com"

your_email@youremail.com 是在 github上注册的邮箱，之后会要求确认路径和输入密码，我们这使用默认的一路回车就行 (不设置密码)。成功的话会在用户主目录下生成 .ssh 文件夹，进入后打开 id_rsa.pub 文件，复制里面的内容。
回到 github 网站，登录账户，进入 Account Settings（账户配置），左边选择 SSH Keys，点击 New SSH Key；title 随便填，然后粘贴你电脑上生成的 key。
                           


在 git 终端下输入以下指令
$ ssh -T git@github.com

出现 You've successfully authenticated, but GitHub does not provide shell access. 说明配置成功。
git 终端配置 username 和 email，因为 github 每次 commit 都会以此作为记录。
$ git config --global user.name "your name" 
$ git config --global user.email "your_email@youremail.com"


在新建仓库或者 push 代码的时候可能会出现以下错误
                           
原因按提示说的是从 2021.08.13 日起，原来的密码凭证要变更为个人访问令牌，就是personal access token

生成个人访问令牌：
在 Account Settings（账户配置），左边选择 Developer settings，然后可以看到生成令牌的选项。
                           
需要设置token的有效期，访问权限等，
选择要授予此令牌 token 的范围或权限。
要使用token从命令行访问仓库，请选择 repo。
要使用token从命令行删除仓库，请选择 delete_repo
其他根据需要进行勾选
完成后点击生成，会得到一串序列码，复制到原来需要输入密码的地方就行了。
                           
记得把你的token保存下来，因为你再次刷新网页的时候，你已经没有办法看到它了。


另外，也可以 把 token 直接添加远程仓库链接中，这样就可以避免同一个仓库每次提交代码都要输入token了：

git remote set-url origin https://<your_token>@github.com/<USERNAME>/<REPO>.git

<your_token>：换成你自己得到的 token
<USERNAME>：是你自己 github 的用户名
<REPO>：是你的仓库名称
例如：

git remote set-url origin https://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@github.com/hsl416604093/AutoBuildTools.git/





版本回退：
HEAD 指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令

git reset --hard commit_id

穿梭前，用

git log

可以查看提交历史，以便确定要回退到哪个版本。
要重返未来，用

git reflog

查看命令历史，以便确定要回到未来的哪个版本。


查看分支：

git branch

创建分支：

git branch <name>

切换分支：

git checkout <name>
或
git switch <name>

创建+切换分支：

git checkout -b <name>
或
git switch -c <name>



合并某分支到当前分支：

git merge <name>

删除分支：

git branch -d <name>



通常，合并分支时，如果可能，Git会用 Fast forward 模式，但这种模式下，删除分支后，会丢掉分支信息。如果要强制禁用 Fast forward 模式，Git就会在merge时生成一个新的 commit，这样，从分支历史上就可以看出分支信息。
例如：

git merge --no-ff -m "merge with no-ff" dev


多人协作的工作模式通常是这样：
首先，可以试图用

git push origin <branch-name>

推送自己的修改；
如果推送失败，则因为远程分支比你的本地更新，需要先用

git pull

1. 试图合并；
2. 如果合并有冲突，则解决冲突，并在本地提交；
没有冲突或者解决掉冲突后，再用

git push origin <branch-name>

推送就能成功！
如果

git pull

提示

no tracking information

，则说明本地分支和远程分支的链接关系没有创建，用命令

git branch --set-upstream-to <branch-name> origin/<branch-name>

这就是多人协作的工作模式，一旦熟悉了，就非常简单。


小结
查看远程库信息

git remote -v

本地新建的分支如果不推送到远程，对其他人就是不可见的；
从本地推送分支，使用

git push origin branch-name

，如果推送失败，先用

git pull

抓取远程的新提交；
在本地创建和远程分支对应的分支，5 使用

git checkout -b branch-name origin/branch-name

，本地和远程分支的名称最好一致；
建立本地分支和远程分支的关联，使用

git branch --set-upstream branch-name origin/branch-name

；
从远程抓取分支，使用

git pull

，如果有冲突，要先处理冲突。
--------------------------------






我现在在dev20181018分支上，想删除dev20181018分支
　　1 先切换到别的分支: git checkout dev20180927
　　2 删除本地分支： git branch -d dev20181018
　　3 如果删除不了可以强制删除，git branch -D dev20181018
　　4 有必要的情况下，删除远程分支(慎用)：git push origin --delete dev20181018
　　5 在从公用的仓库fetch代码：git fetch origin dev20181018:dev20181018
　　6 然后切换分支即可：git checkout dev20181018


Git常用操作命令收集：
1) 远程仓库相关命令
检出仓库：$ git clone git://github.com/jquery/jquery.git
查看远程仓库：$ git remote -v
添加远程仓库：$ git remote add [name] [url]
删除远程仓库：$ git remote rm [name]
修改远程仓库：$ git remote set-url --push[name][newUrl]
拉取远程仓库：$ git pull [remoteName] [localBranchName]
推送远程仓库：$ git push [remoteName] [localBranchName]
 
2）分支(branch)操作相关命令
查看本地分支：$ git branch
查看远程分支：$ git branch -r
创建本地分支：$ git branch [name] ----注意新分支创建后不会自动切换为当前分支
切换分支：$ git checkout [name]
创建新分支并立即切换到新分支：$ git checkout -b [name]
删除分支：$ git branch -d [name] ---- -d选项只能删除已经参与了合并的分支，对于未有合并的分支是无法删除的。如果想强制删除一个分支，可以使用-D选项
合并分支：$ git merge [name] ----将名称为[name]的分支与当前分支合并
创建远程分支(本地分支push到远程)：$ git push origin [name]
删除远程分支：$ git push origin :heads/[name]
我从master分支创建了一个issue5560分支，做了一些修改后，使用git push origin master提交，但是显示的结果却是'Everything up-to-date'，发生问题的原因是git push origin master 在没有track远程分支的本地分支中默认提交的master分支，因为master分支默认指向了origin master 分支，这里要使用git push origin issue5560：master 就可以把issue5560推送到远程的master分支了。
    如果想把本地的某个分支test提交到远程仓库，并作为远程仓库的master分支，或者作为另外一个名叫test的分支，那么可以这么做。


$ git push origin test:master         // 提交本地test分支作为远程的master分支 //好像只写这一句，远程的github就会自动创建一个test分支
$ git push origin test:test              // 提交本地test分支作为远程的test分支


如果想删除远程的分支呢？类似于上面，如果:左边的分支为空，那么将删除:右边的远程的分支。


$ git push origin :test              // 刚提交到远程的test将被删除，但是本地还会保存的，不用担心
3）版本(tag)操作相关命令
查看版本：$ git tag
创建版本：$ git tag [name]
删除版本：$ git tag -d [name]
查看远程版本：$ git tag -r
创建远程版本(本地版本push到远程)：$ git push origin [name]
删除远程版本：$ git push origin :refs/tags/[name]
 
4) 子模块(submodule)相关操作命令
添加子模块：$ git submodule add [url] [path]
如：$ git submodule add git://github.com/soberh/ui-libs.git src/main/webapp/ui-libs
初始化子模块：$ git submodule init ----只在首次检出仓库时运行一次就行
更新子模块：$ git submodule update ----每次更新或切换分支后都需要运行一下
删除子模块：（分4步走哦）
1)$ git rm --cached [path]
2) 编辑“.gitmodules”文件，将子模块的相关配置节点删除掉
3) 编辑“.git/config”文件，将子模块的相关配置节点删除掉
4) 手动删除子模块残留的目录
 
5）忽略一些文件、文件夹不提交
在仓库根目录下创建名称为“.gitignore”的文件，写入不需要的文件夹名或文件，每个元素占一行即可，如
target
bin
● .db
 
 
git操作-删除文件
日期:2012-05-20 来源: bg090721 分享至:
 
git删除文件
rm add2.txt
git rm add2.txt
git commit -m "rm test"
git push web


========================================================
git init
git remote add origin https://github.com/Msq001/marlin2.0-biqu.git  //连接到远程仓库
git@Msq001.github.com:Msq001/xx.git
git add README.md             //添加文件
git commit -m "first commit"  //提交申请
git push -u origin master     //上传本地文件到github仓库 注意: push前 必须要 git add 和 git commit




git clone git@Msq001.github.com:Msq001/xx.git //将github仓库下载到本地
git branch -r //查看远程仓库分支
git branch -a //查看所有分支
git branch [branch name] //本地新建分支
git checkout [branch name] //切换到新分支
git checkout -b [branch name] //创建并且切换到新分支
git push origin [branch name] //将新分支推送到github仓库
git push origin :[branch name] //删除远程分支 注意:Default的分支无法删除, 在Setting中修改Default分支，再进行删除
git branch -d [branch name]    //删除本地分支




//删除仓库中的某个文件夹
git pull origin master  //将远程仓库中的项目拉到本地
dir                     //显示所有文件夹
git rm -r --cached target //删除target文件夹
git commit -m 'deleted target folder' //提交删除请求
git push -u origin master //将本次提交更新到github仓库




git fetch origin   //把远程仓库更新到本地 .git文件夹、但是没有修改本地仓库文件


git update-index --assume-unchanged FILENAME       忽略路径+文件名
git update-index --no-assume-unchanged FILENAME    取消忽略  


//在本地回退版本


git reset --hard HEAD^^         //^^表示回到上上个版本。


git push origin HEAD --force


//删除release版本
git tag -d [tag];  
git push origin :[tag] 


// 从同步上游的更新
git remote add upstream [upstream_url]  // https://github.com/Msq001/marlin2.0-biqu.git
git fetch upstream
git checkout master
git fetch upstream
git merge upstream/master  // git reset --hard upstream/master
git push origin master
git commit --amend


// 合并别人的 Pull request
git checkout -b dev master
git pull git://github.com/xxx/BIGTREETECH-TouchScreenFirmware.git dev
  // git checkout master
  // git merge --squash dev
  // git merge --no-ff dev
  // git rebase -i HEAD~2  // git add * / git rebase --continue
git checkout dev
git rebase -i master
git checkout master
git merge dev  // git merge --no-ff dev
git push origin master


https://github.com/Msq001/Marlin/compare/bugfix-2.0.x...MarlinFirmware:bugfix-2.0.x?expand=1


build_flags = -fmax-errors=5 -g -D__MARLIN_FIRMWARE__
  -Wl,-Map,mapfile.map
  
  
SFC/Scannow  // 解决右键文件夹卡死问题





git ssh连接超时问题

在~/.ssh/config文件中增加以下内容，没有就创建一个文件

``` text
Host github.com
  Hostname ssh.github.com
  Port 443
```

