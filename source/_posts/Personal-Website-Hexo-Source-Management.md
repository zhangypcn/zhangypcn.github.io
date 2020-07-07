---
title: 个人网站Hexo源码管理——便于换设备时更新博客
date: 2020-07-04 01:17:48
categories: Hexo
copyright: true
tags: 
	- Hexo
	- GitHub
---

# 写在前面

本篇记录了我在跟换主力机后，更新博客时发现需要从原来的电脑Copy博客源码，这种行为让我觉得有一丝丝复古，为了避免再次进行这种让人不快的操作，我将网站Hexo源码上传到了GitHub仓库管理，以下记录了操作的流程和细节。

<!-- more -->

# Hexo源码管理

1. 安装必要环境，如：Git、NodeJS。

> 如果使用的是新机器，注意在GitHub上添加该设备的SSH Key
>
> NodeJS尽量安装官网首页描述为“推荐给大多数用户”的版本，如：12.18.2LTS，不要安装描述为“最新功能”的版本，如“14.5.0”，否则安装hexo时可能出问题。

2. 在部署站点的GitHub仓库（yourgithubusername.github.io）新建分支，如：hexo，并将其设置为**默认分支**。

> 由于我此时已经更新了一段时间博客，仓库master分支的内容为public目录下的内容，故新建分支hexo的内容也为public目录

3. 本地创建文件夹，使用Git Bash克隆站点的GitHub远程仓库，这时会下载到public目录下的内容，此时删掉除 .git 文件夹以外的所有文件（如果还未更新部署博客忽略此步骤），将旧电脑的Hexo源码，除 .git 和 .deploy_git 文件夹的所有文件复制进来。并且注意删除themes目录使用的网站主题的.git文件，否则影响上传代码，有需要备份即可。
4. 依次执行以下指令

```shell
git add .
git commit -m"添加个人网站源码"
git push origin hexo
```

> 执行 ` git commit ` 前先配置好git全局邮箱和用户名
>
> ```shell
> git config --global user.name "yourgithubname"
> git config --global user.email "yourgithubemail"
> ```
>
> 上传源码后发现相较于本地的文件，文件夹node_modules、public、文件db.json并未上传至远程仓库，这些文件在执行hexo g -d 指令后会自动生成。

5. 最后确认站点配置文件 ` _config.yml ` 的**deploy**字段的branch设置为master，这样保证了执行 ` hexo g -d ` 时将博客部署至GitHub仓库的主分支上，后续只需使用Git命令手动更新hexo分支即可。





---



**参考链接**

[使用hexo，如果换了电脑怎么更新博客？ - skycrown的回答 - 知乎](https://www.zhihu.com/question/21193762/answer/103097754)



---

