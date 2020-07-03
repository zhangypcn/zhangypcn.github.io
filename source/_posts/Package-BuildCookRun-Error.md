---
title: 过期蓝图是万恶之源
date: 2020-04-28 01:52:04
categories: Unreal Engine
copyright: true
tags:
	- UE4
	- Error
	- Package
---

打包时遇到莫名的问题需要单独排查，首先排查Game模式（Debug/Development）源码编译能否通过，其次检查内容文件，尤其是蓝图，**一些错误的蓝图文件即使项目中没有任何引用，也可以引起致命的错误！**

折腾到凌晨的教训，值得一记。



---