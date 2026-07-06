---
title: CentOS下搭建git服务器
labels: 工具类
---

###踩了几个坑
- Linux权限
- SSH


##1
安装git
```yum install git```
查看版本号
```git --version```
##2
新建用户 gituser
设置密码 123
```
adduser gituser
passwd gituser 
```
##3
配置SSH密钥
```
cd
mkdir .ssh
ssh-keygen -t rsa
cd .ssh
新建authorized_keys 将公钥追加进去
cat id_rsa.pub >> ~/.ssh/authorized_keys
```
##4
创建仓库  project.git 在 home/gituser/
```
cd /home/gituser
su gituser   这一步重要
mkdir project.git
cd project.git
git --bare init
```
git仓库已经在虚拟机搭好了
##5
本地clone
```
在desktop打开git bash
mkdir test
cd test
git init
git clone gituser@192.168.75.129:/home/gituser/project.git
新建a.txt
touch a.txt
git add .
git commit -m "this is a test"
git push origin master
将a.txt push上去
```
至此 虚拟机内外就跑通了。
