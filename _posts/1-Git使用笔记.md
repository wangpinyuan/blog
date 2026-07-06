---
title: Git使用笔记
labels: 工具类
---

## 初始化
- git init
- git clone git@xxxxxxxxxxxx

## 上传
- git add xxx.txt 把文件添加到本地仓库
- git commit -m "描述信息" 提交到远程仓库

## 查看
- git status 查看仓库文件修改状态
- git diff xxx.txt 查看当前文件变动
- git log 查看近期提交日志
- git reset --hard commit_id 回滚到某版本
- git reflog 查看之前历史指令

## 修改了错误的文件
1. 并没有git add，git checkout -- fileName 取消工作区修改
2. 已经git add，git reset HEAD filename 把暂存区修改取消。如果需要，再git checkout 取消工作区修改

## 删除
- 本地删除，git也删除   git rm xxx.txt
- 本地误删，想从git恢复  git checkout xxx.txt

## 远程库
- git remote add origin git@server-name:path/repo-name.git 关联远程库
- git push -u origin master 第一次推送到远程库
- git push origin master 后续推送到远程库
- git clone git@server-name:path/repo-name.git 从远程库克隆

## 分支管理
- git branch 查看本地仓库所有分支信息
- git branch -r  查看本地仓库对应的远程仓库有哪些分支
- git branch -a 列出本地和远程仓库的所有分支（需要先git pull 才能查看最新

## 新建分支 比如我们新建dev分支
#### 第一种
1. git branch dev 在本地新建dev
2. git checkout dev 将本地分支切换到dev
3. git push --set-upstream origin dev 远程仓库有dev，将本地dev分支与远程仓库dev分支建立关联
#### 第二种
1. git checkout dev 自动创建本地分支dev
2. git push origin dev 远程仓库没有dev，此时自动新建

## 分支合并
#### 1 整体合并 比如将a合并到b
1. git checkout b 首先切换到b分支
3. git merge a 将a合并

#### 2 将a某次提交合并到b
1. git checkout b
2. git cherry-pick xxxxxx

## 删除分支
1. 删除本地dev分支 git branch -d dev

## git push
- git push -u origin master  添加-u后，会记录提交到远程分支的默认值，之后的提交只需git push便可提交到对应远程分支

## 忽略已经在版本控制并已提交过的文件
- git update-index --assume-unchanged src/pages/document.ejs
