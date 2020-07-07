---
title: Visual Studio 2019 编译 UE4.24 源码不通过问题解决
date: 2020-07-06 22:46:13
categories: Unreal Engine
copyright: true
tags: 
	- UE4
	- Visual Studio 2019
	- 编译问题
---

# 错误1

* **找不到头文件typeinfo**

使用 Visual Studio 2019 编译 UE4.24源码时报错，PhysX库编译不通过，具体报错信息为：

```c++
"D:\UnrealEngine\Engine\Source\ThirdParty\PhysX3\PxShared\src\foundation\include\PsAllocator.h"：
typeinfo.h: No such file or directory
```

<!-- more -->

对于此类报错，Microsoft开发者回复是MSVC14.23版本移除了typeinfo.h，改用<typeinfo>即可，VS2019安装信息显示已安装MSVC14.26，显然MSVC4.23以后都有此问题。按其建议修改后，仍会有其他编译错误。而且修改源码的方式不太友好。

## 解决方案

* **修改引擎配置文件**

1. 使用VS2019的Installer，安装MSVC4.23版本以前的运行库，如MSVC14.22.27905。

2. 修改UE4源码的配置文件: ` "D:\UnrealEngine\Engine\Saved\UnrealBuildTool\BuildConfiguration.xml" `
   添加以下代码：

```xml
<WindowsPlatform>
	<CompilerVersion>14.22.27905</CompilerVersion>
</WindowsPlatform>
```

最后BuildConfiguration.xml如下：

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">
	<WindowsPlatform>
		<CompilerVersion>14.22.27905</CompilerVersion>
	</WindowsPlatform>
</Configuration>
```

3. Generate后编译即可。

# 错误2

* **error C4800**

C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\INCLUDE\comip.h(311): error C4800

## 解决方案

* **修改引擎源码**

cs文件： ` .\Engine\Source\Programs\UnrealBuildTool\Platform\Windows\VCToolChain.cs ` 

第514行之后加一句 ` Arguments.Add("/wd4800"); ` 

```c#
void AppendCLArguments_CPP(CppCompileEnvironment CompileEnvironment, List<string> Arguments)
{
	if (Target.WindowsPlatform.Compiler != WindowsCompiler.Clang)
	{
		// Explicitly compile the file as C++.
		Arguments.Add("/TP");
        Arguments.Add("/wd4800");
	}
	else
	    ...
```

最后Generate后编译即可。





---



参考链接

[UE4导入插件后编译无法通过，提示缺少typeinfo.h](https://blog.csdn.net/sajiazaici/article/details/102911466/)

[UE4源码编译错误处理，error MSB3075，error C4800](https://blog.csdn.net/weixin_43030629/article/details/104947160)



---

