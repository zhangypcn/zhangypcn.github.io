---
title: UE4 构建解析——烘培、打包、部署、运行
date: 2020-04-28 02:13:06
categories: Unreal Engine
copyright: true
tags:
	- UE4
	- Package
	- BuildCookRun
	- UAT
---

从项目启动器启动配置文件，验证描述文件设置后，首先执行 Launching UAT... ，**UAT** 是UE4在封装过程所使用的自动化工具（Unreal Automation Tool），用于通过各种实用程序脚本来处理 UE4 项目。对于封装过程，UAT使用特定的命令 **BuildCookRun** 来打包项目。

<!-- more -->

在启动 UAT 之后经历了编译、烘培、部署、启动、清理几个阶段，这实际上也是中 BuildCookRun 命令的组成部分，具体封装流程为**构建（Build）、转化（Cook）、暂存（Stage）、打包（Package）、部署（deploy）、运行（Run）**。

* 构建（Build）：该阶段将为所选择的平台编译重组文件。
* 转化（Cook）：该阶段通过在特殊模式下执行编辑器来转化内容。
* 暂存（Stage）：该阶段将重新文件和内容复制到暂存区，它是开发目录之外的独立目录。
* 打包（Package）：该阶段将项目打包成平台原生的发行格式。
* 部署（Deploy）：该阶段将部署版本部署到目标设备。
* 运行（Run）：该阶段在目标平台上启动已封装的项目。

所以，在打包过程中遇到问题，就可以在按以上不同的阶段去分类，从而有目标的解决。

一般情况下，若由于程序的原因打包失败，可以在VS解决方案**Game模式**下（Debug或Development）调试运行来定位问题。

有一些情况下，工程内容中一些**有问题的蓝图文件**没有删除，即使没有引用，也可以引起致命的错误。



---

**参考文档**

[docs.UnrealEngine: 构建操作：烘焙，打包，部署与运行](https://docs.unrealengine.com/zh-CN/Engine/Deployment/BuildOperations/index.html)

---