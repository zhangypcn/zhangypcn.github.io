---
title: PixelStreaming 局域网及公有云部署全流程记录
date: 2020-04-10 00:46:49
categories: Unreal Engine
copyright: true
tags: 
	- UE4
	- PixelStreaming
	- 云渲染
---

# 写在前面

本篇是关于PixelStreaming开发和部署全流程的记录，从开发者角度分析探讨像素流送技术以及部署过程中遇到的问题，希望能为其他开发者带来帮助或者解决实际问题，偶尔也会有补充和更新，希望同样关注PixelStreaming技术的朋友与我交流。

<!-- more -->

# 概述

PixelStreaming自UnrealEngine4.21版本开始提供测试，能够向Web浏览器发送高质量的可视化内容，让移动设备和轻量级Web浏览器能够轻松浏览工作站品质的3D图形。用户通过链接即可访问，并且提供了多人同时访问或单人独立访问的自由部署方案，将像素流送项目部署在云平台服务器上，在高性能、高负载的云计算平台以及高速率、低延迟的5G技术的支持下，实现多人、异地、多终端的远程协同。

PixelStreaming技术可以为汽车制造商以及经销商提供一种通用的线上展厅解决方案，为汽车客户带来方便快捷的高质量汽车交互体验。以此解决方案为思路，可拓展至工业产品研发过程中，对工业数据进行3D可视化，创建交互式内容，以进行不同角色的设计人员在异地辅助决策，缩短产品设计和评审时间，从而减少产品研发过程中的资金及时间成本，显著提高工作效率。另外在智慧城市、智慧交通、数字地产等行业，PixelStreaming也有很大的用武之地。

# 工作原理

## UE4.24以前版本

UE4.24版本之前，PixelStreaming通过配置PixelStreaming插件、WebRTC代理服务器、Signaling和Web服务器来工作。

**PixelStreaming插件**：负责视频编码，将视频与音频压缩到媒体流中，并发送到WebRTC代理服务器。

**WebRTC代理服务器**：负责将像素流送插件产生的媒体流通过直接的点对点连接转发给查看者。

**Signaling和Web服务器**：负责在查看者和WebRTC代理服务器之间建立连接，为查看者提供播放媒体流内容的HTML和JavaScript环境。

![PixelStreamingFramework](PixelStreamingFramework.jpg "4.21 PixelStreaming原理") 

## UE4.24之后版本

UE4.24版本开始，PixelStreaming不需要启动WebRTC代理服务器，其工作流程变为了由Signaling和Web服务器充当桥梁，连接UE4应用和Web浏览器。

![PixelStreaming4.24](PixelStreaming4.24.jpg "4.24 PixelStreaming原理")

# 局域网部署

## 单个实例配置

* **UE4.24以前版本：**

1. 运行WebRTC代理服务器

   **目录：** ` \Engine\Source\Programs\PixelStreaming\WebRTCProxy\bin\Start_WebRTCProxy.bat `

2. 运行SignallingWeb服务器

   **目录：** ` \Engine\Source\Programs\PixelStreaming\WebServers\SignallingWebServer\run.bat `

   **启动参数：** `  --publicIp 127.0.0.1（此IP为客户端访问地址，可根据情况修改，如局域网IP：--publicIp 192.xx.xx.3） `

3. 运行应用程序实例

   **目录：** ` WindowsNoEditor/PixelStreamingDemo.exe `

   **启动参数：** ` -AudioMixer -PixelStreamingPort=8124 -RenderOffScreen `

4. 客户端使用支持WebRTC协议的浏览器（Google Chrome、Mozilla Firefox、Apple Safari）访问网页链接

   http://127.0.0.1 (此IP为启动SignallingWebServer时设置的publicIp值)

* **UE4.24之后版本：**

1. 运行SignallingWeb服务器

   **目录：** ` \Engine\Source\Programs\PixelStreaming\WebServers\SignallingWebServer\run.bat `

2. 运行应用程序实例（PixelStreamingIP为客户端访问地址，可根据情况修改，如局域网IP：-PixelStreamingIP=192.xx.xx.3）

   **目录：** ` /WindowsNoEditor/PixelStreamingDemo.exe `

   **启动参数：** `-PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8888 -AudioMixer -RenderOffScreen `

3. 客户端使用支持WebRTC协议的浏览器（Google Chrome、Mozilla Firefox、Apple Safari）访问网页链接

   http://127.0.0.1 (此IP为运行应用程序实例时设置的PixelStreamingIP)

**相关参数说明：**

** 待更新 **

## 多个实例配置

* **UE4.24之后版本：**

1. 启动Matchmaker / run.bat

   **启动参数**（默认为90/9999，启动时可不加参数）： ` --httpPort 90 --matchmakerPort 9999 `

2. 启动SignallingWebServer / run.bat

   **启动参数**（streamerPort=8888为默认）：

   **[服务器1]** ` --UseMatchmaker true --matchmakerAddress 127.0.0.1 --matchmakerPort 9999 --publicIp 127.0.0.1 --httpPort 80 --streamerPort = 8888 `

   **[服务器2]** ` --UseMatchmaker true --matchmakerAddress 127.0.0.1 --matchmakerPort 9999 --publicIp 127.0.0.1 --httpPort 81 --streamerPort = 8887 `

3. 启动PixelStreaming.exe应用程序实例

   **启动参数：**

   **[实例1]** ` -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8888 -AudioMixer -RenderOffScreen `

   **[实例2]** ` -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8887 -AudioMixer -RenderOffScreen `

4. 客户端使用支持WebRTC协议的浏览器（Google Chrome、Mozilla Firefox、Apple Safari）**直接浏览** http://127.0.0.1:90 ，Matchmaker将自动分配端口，从而单独浏览实例。或者**分别访问**网页链接：

   **[网址1]** [http://127.0.0.1:80](http://127.0.0.1/MakeReal3DCloud.htm)

   **[网址2]** http://127.0.0.1:81

   即可多人浏览单独的PixelStreaming应用程序实例。

# 公有云部署

## 云服务器环境配置

>  以华为云为例，其他云平台情况大致相同，腾讯云、阿里云可以直接运行像素流送实例，可省略部分步骤。

* **云服务器系统信息：**
  DirectX版本: DirectX 11
  CPU: Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz (16 CPUs), ~2.3GHz
  GPU: NVIDIA Tesla M60 

* 防火墙设置

  默认防火墙设置可能会禁止像素流所用到的端口的通信。**快速测试时，**在控制面板 >> 防火墙设置中先关闭防火墙。**正式使用时，**应该在高级防火墙设置中，创建相应的规则，将需要使用的协议或者端口打开，也可以将像素流应用及其他相关应用都加入到白名单中去。

  <img src="Firewall.jpg" alt="防火墙设置" style="zoom:40%;" />

* 安装.NET Framework3.5

  cmd命令行 >> 输入servermanager >> 回车 >> 选择管理>>添加角色和功能 >> Next >> 功能 >> 选择.NET Framework3.5 >> 点击安装

  <img src="NETFramework3.5.jpg" alt="NET Framework3.5安装" style="zoom:30%;" />

* 启动声音服务

  cmd命令行 >> services.msc >> 将Windows Audio以及Windows Audio Endpoint Builder服务启动

  <img src="AudioService.jpg" alt="启动声音服务" style="zoom:40%;" />

* 设置远程桌面链接远程音频

  <img src="RemoteAudio.jpg" alt="远程音频" style="zoom:40%;" />

* 关闭IE的安全配置

  Windows Server 默认设置是不允许从浏览器下载内容的，所以要通过浏览器下载任何软件，你需要先在ServerManager里关闭IE Enhanced Security Configuration。当然安全起见，当下载完需要的软件后，还是建议重新启用以增强系统的安全性。

  <img src="IEConfig.jpg" alt="IE安全配置" style="zoom:30%;" />

## PixelStreaming环境配置

### 必要环境配置

1. 安装Node.js
2. 安装Unreal Engine4.24

### vGPU驱动

> **云服务器运行Unreal Engine4.24 PixelStreaming实例必须安装vGPU/GRID驱动**
> **其他云平台默认预装了vGPU/GRID最新驱动，无需后续步骤。**
> **后续步骤为华为云服务器上GRID/vGPU驱动的安装步骤，安装此驱动是为了解决云服务器运行Unreal Engine4.24 PixelStreaming应用程序实例时，有NvEnc的相关报错。运行4.21版本的像素流送应用程序实例无此问题。**

<img src="NvEncError.jpg" alt="NvEnc Error" style="zoom:60%;" />

1. 安装华为云提供的NVIDIA驱动

   华为云Window公共镜像中有该驱动的安装文件，文件目录C:\NVIDIA\369.71，点击Setup.exe安装即可。**此步骤是为了先安装，后更新。直接安装来自NVIDIA License Dashboard下载的GRID/vGPU最新驱动，会安装失败。**

   <img src="vGPU369.jpg" alt="华为云提供的vGPU驱动版本安装" style="zoom:50%;" />

* **步骤a、b是我最开始安装vGPU/GRID最新驱动的步骤记录，这些步骤其实是不需要的，通过 [NVIDIA官网驱动程序下载入口](https://www.nvidia.cn/Download/index.aspx?lang=cn) 获取到的GRID最新驱动软件包就可以（未测试）**

* **重要说明：** N卡的图形功能不需要License，仅计算功能需要License，PixelStreaming只用到视频编码，不需要计算功能，所以没必要配置License。在这之前我并不知道这一点，所以去申请了License，进而配置License服务器，走了一些弯路。虽然对于PixelStreaming来说不需要，不过关于获取vGPU/GRID驱动 License、安装License Server、配置License等详细步骤以及问题解决我将会在另一篇文章说明，提供给有需要的朋友参考。

  > a. 申请GRID/vGPU驱动License
  >
  > 有申请License的步骤是因为，我只知道这一种获取最新的驱动软件包的方式，就是通过申请License的方式获得NVIDIA邮件提供的链接，进入License Dashboard下载。
  >
  > [NVIDIA官网申请GRID驱动的免费License](https://enterpriseproductregistration.nvidia.com/?LicType=EVAL&ProductFamily=vGPU) （申请需要企业邮箱）
  >
  > b. 更新GRID vGPU驱动
  >
  > 通过License申请成功的邮件所提供的链接[NVIDIA License仪表盘](https://ui.licensing.nvidia.com) ，下载到vGPU/GRID驱动最新的软件包，如”NVIDIA-GRID-Windows-418.130-426.52.zip“，安装更新即可。

2. 下载更新GRID vGPU驱动

   通过 [NVIDIA官网驱动程序下载入口](https://www.nvidia.cn/Download/index.aspx?lang=cn) 搜索获取到的GRID最新驱动软件包，下载更新即可**（未测试）**

   <img src="vGPU Download.jpg" alt="vGPU Download" style="zoom:50%;" />

3. 到此，运行Unreal Engine4.24 PixelStreaming应用程序实例，运行正常，没有报错。

## 单个实例配置

1. 启动STUN服务 Start_STUNServer.bat

   **目录：** ` \Engine\Source\ThirdParty\WebRTC\rev.23789\programs\Win64\VS2017\release\Start_STUNServer.bat `

2. 启动Signalling和Web服务器 runAWS.bat

   **目录：** ` \Engine\Source\Programs\PixelStreaming\WebServers\SignallingWebServer\runAWS.bat `

3. 启动应用程序实例，具体启动参数参考局域网部署步骤。

> 如果上述步骤Web浏览器无法查看视频流送，则换用TURN服务部署方法。

1. 启动TURN服务 Start_AWS_TURNServer.bat

   **目录：** ` \Source\ThirdParty\WebRTC\rev.23789\programs\Win64\VS2017\release\Start_AWS_TURNServer.bat `

2. 启动Signalling和Web服务器 runAWS_WithTURN.bat

   **目录：** ` \Engine\Source\Programs\PixelStreaming\WebServers\SignallingWebServer\runAWS_WithTURN.bat `

3. 启动应用程序，具体启动参数参考局域网部署步骤。

## 多个实例配置

1. 启动Start_AWS_TURNServer.bat

2. 启动Matchmaker/run.bat

   **启动参数**（默认为90/9999，启动时可不加参数）：

   ` --httpPort 90 --matchmakerPort 9999 `

3. 启动SignallingWebServer/runAWS_WithTURN.bat

   **启动参数**（streamerPort=8888为默认）：

   **[服务器1]** ` --UseMatchmaker true --matchmakerAddress 127.0.0.1 --matchmakerPort 9999 --publicIp 127.0.0.1 --httpPort 80 --streamerPort = 8888 `

   **[服务器2]** ` --UseMatchmaker true --matchmakerAddress 127.0.0.1 --matchmakerPort 9999 --publicIp 127.0.0.1 --httpPort 81 --streamerPort = 8887 `

   * 云服务器上，参数UseMatchmaker 不起作用，需要修改config.json文件，将UseMatchmaker改为True：

     ```json
     {
     	"UseFrontend": false,
     	"UseMatchmaker": true,
     	"UseHTTPS": false,
     	...
     }
     ```

   * 在云服务器上，参数httpPort 、streamerPort 也不起作用，修改cirrus.js对应的参数即可
   
     ```js
     var httpPort = 80;
     var streamerPort = 8888; // port to listen to Streamer connections
     ```
   
   * 需将SignallingWebServer文件夹复制多份，作相应配置。

4. 启动PixelStreaming.exe应用程序实例

   **启动参数：**

   **[实例1]** ` -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8888 -AudioMixer -RenderOffScreen `

   **[实例2]** ` -PixelStreamingIP=127.0.0.1 -PixelStreamingPort=8887 -AudioMixer -RenderOffScreen `

5. 客户端使用支持WebRTC协议的浏览器（Google Chrome、Mozilla Firefox、Apple Safari）**直接浏览**http://127.0.0.1:90 ，Matchmaker将自动分配端口，从而单独浏览实例。或者**分别访问**网页链接

   **[网址1]** http://127.0.0.1:80

   **[网址2]** http://127.0.0.1:81

   即可多人浏览单独的PixelStreaming应用程序实例。



***



**参考资料**

[Unreal Engine Docs: Platform Development_Pixel Streaming](https://docs.unrealengine.com/en-US/Platforms/PixelStreaming/index.html)

[Unreal Engine Blog: UE4像素流应用在公有云上的快速部署指南_周澄清](https://www.unrealengine.com/zh-CN/tech-blog/how-to-deploy-ue4-pixel-streaming-on-public-cloud)



---

