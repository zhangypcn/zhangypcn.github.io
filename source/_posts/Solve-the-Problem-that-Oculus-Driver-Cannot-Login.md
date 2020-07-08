---
title: 解决Oculus驱动无法登录问题
date: 2020-07-08 10:24:10
categories: Oculus
copyright: true
tags: 
	- Oculus
	- hosts
---

# 问题

Oculus驱动在科学上网后仍无法登录，可以尝试通过更改hosts文件解决。

<!--more-->

# 解决

在hosts文件尾（ ` C:\Windows\System32\drivers\etc ` 目录下）添加以下内容

```shell
157.240.11.49 graph.oculus.com
157.240.11.49 www2.oculus.com
157.240.8.49 scontent.oculuscdn.com
157.240.8.49 securecdn.oculus.com
```

