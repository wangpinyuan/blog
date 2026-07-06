---
title: shell
labels: 工具类
---

# 常用指令
* *匹配任意长度 
* ? 匹配一个字符
* [] 匹配[1a]  1 or a
* pwd
* cd
* ls   (-a显示隐藏文件) (-l查看属性) ( -F 显示文件类型)
(目录--蓝色)(普通文件--黑色)(草绿色--可执行)(淡蓝色--链接)
* cat 查看文件内容 (-n 行号)
* more （和cat一样，可翻页）
- less (和more一样，/ 查找)
* head  tail  阅读文件的开头结尾（-n 指定行数）
* grep 查找文件内容
- find /user/www/ -name zip -print
- locate 搜索
- who 查看登陆的人
- uname (-a 系统所有信息 -r 只显示内核信息)
- mkdir 新建文件夹（-p 直接创建父子目录)
- touch xxx 新建文件 xxx
- mv hello /bin 
```
echo "hello" > hello
cat hello
``` 
- mv可以在移动文件和目录时对其重命名（-i 命名冲突时提示，不然直接覆盖  -b 命名冲突时+~区分）
- cp hello /bin复制（-i -b    （-r 连带子目录）
- rm (-r 删除子目录 -f 不用确认 )
- chown wpy:wpygroup /www/hello 改变文件所有权 （-R 改变路径下所有文件） 属主：属组   文件名   改变文件所有权
- chmod 711 /www/hello  改变文件的权限 u（属主） g（属组） o（其他人） a（所有人） r（4） w（2） x（1）
- ln -s hello hi ( 建立软链接0， “别名” ， 互不影响)
- ln hello hi (硬链接 ， 影响)
-  \> 输出重定向
- \>> 不覆盖
- | 管道将一条命令的输出连接到另一条命令的输入



# 打包压缩
- gzip (-d  解压)  xxx.tar (-l 查看压缩效果   -tv 检查完整性)
- bzip 同上
- tar （-c （-x  解压）创建归档文件 -v 显示执行过程 -f 在指定归档文件名 -z 压缩） shell.tar(.gz)   shell/
将shell目录下的文件打包成shell.tar

# 用户和权限
- useradd  （-g abcs 属于组 -s /bin/bash 指定shell） abc (-M 不创建用户目录)
- passwd abc
- userdel （-r）
- usermod
(-d 修改用户主目录)
(-e 修改账号有效期 MM/DD/YY)
(-g 修改所属组)
(-l 修改账号名)
(-s 修改所用shell)
- su
- sudo
- /etc/passwd 文件

```
user:x:500:500:User:/home/user:/bin/bash
elasticsearch:x:496:493:elasticsearch user:/home/elasticsearch:/sbin/nologin
www:x:501:501::/home/www:/bin/bash
logstash:x:495:492:logstash:/usr/share/logstash:/sbin/nologin
redis:x:494:491:Redis Server:/var/lib/redis:/sbin/nologin
gitosis:x:493:489:git repository hosting:/var/lib/gitosis:/bin/sh
gituser:x:502:502::/home/gituser:/bin/bash

登录名-口令占位符-UID-GID-私人信息-用户主目录-shell
```
# 远程登陆
- OpenSSH 是常用的SSH服务器软件
- VNC用于图形化远程登录
- SSH 意为“安全的shell”，执行
```
ssh -l wpy 196.128.75.130
exit
默认开在22端口，可以-p改
ssh -l wpy -p 222 196.128.75.130
```
- SSH 密钥
```
ssh-keygen -t rsa 生成rsa密钥
id_rsa 私钥
id_rsa_pub 公钥
复制公钥到远程主机，重命名
/.ssh/authorized_keys
```
