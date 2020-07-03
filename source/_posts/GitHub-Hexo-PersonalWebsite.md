---
title: GitHub+Hexo+NexT搭建个人网站全流程及魔改记录
date: 2020-04-20 14:00:00
categories: Hexo
copyright: true
tags: 
	- GitHub Pages
	- Hexo
	- NexT
---

# 写在前面

本篇是关于利用GitHub Pages服务，使用Hexo框架以及NexT主题搭建个人网站的全流程的记录，本着高效工作的原则做了一些自定义修改来优化个人网站。

<!-- more -->

-- 持续更新 --

# 概述

GitHub Pages：一项静态站点托管服务

Hexo：一个高效的博客框架

NexT：一个简约风格的网站主题

GitHub提供了 ` .github.io` 域，省去了自已去购买域名的金钱和精力。



# Hexo开始使用

1. 创建远程仓库。注册GitHub账号，创建仓库，仓库命名为：用户名+ .github.io 后缀， ` username.github.io `

2. 本地安装Git、NodeJS

3. 安装Hexo。创建用来部署博客网站的文件夹，如 ` D:\zhangypcn ` ，安装Hexo，并初始化网站

   ```shell
   # 安装Hexo
   npm install -g hexo
   # 在当前文件夹初始化一个网站，也可以指定项目名：` hexo i blog `
   hexo init
   # 启动服务器，默认情况下，访问网址为： http://localhost:4000
   # 也可以指定端口启动服务 hexo s -p 5000
   hexo server
   ```

   * 本地测试

   <img src="GitHub-Hexo-PersonalWebsite\Test.png" alt="Test" style="zoom:33%;" />

4. 一键部署网站到远程仓库

   * 安装 [hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)

     ```shell
     npm install hexo-deployer-git --save
     ```
     
   * 打开站点配置文件 ` _config.yml ` ，目录 ` "D:\zhangypcn\hexo\_config.yml" ` ，修改deploy字段，其repo项设置为远程仓库URL，branch项设置为master
   
     ```yaml
     # Deployment
     ## Docs: https://hexo.io/docs/deployment.html
     ## repo：仓库（Repository）地址
     ## branch：分支名称
     deploy:
       type: git
       repo: git@github.com:zhangypcn/zhangypcn.github.io.git
       branch: master
     ```
     
   * 生成站点文件并推送至远程库
   
     ```shell
     // 执行 hexo clean 时，Hexo会清除缓存文件 (db.json) 和已生成的静态文件 (public)；
     // 执行 hexo generate时，Hexo会在 public 目录下生成网站静态文件；
     // 执行 hexo deploy 时，Hexo 会将 public 目录中的文件和目录推送至 _config.yml 中
     // 指定的远端仓库和分支中，并且完全覆盖该分支下的已有内容。
     hexo clean
     hexo generate
     hexo deploy
     ```
     
   * 现在就可以通过仓库名作为域名来访问网站，如： ` https://username.github.io  ` 

# NexT主题配置

## 开始使用

1. 下载主题至 Hexo 站点目录的themes文件夹下

   ```shell
    git clone https://github.com/iissnan/hexo-theme-next themes/next
   ```

2. 打开站点配置文件 ` _config.yml ` ，目录 ` "D:\zhangypcn\hexo\_config.yml" ` ，修改 theme 字段，设置为 next

   ```yaml
   theme: next
   ```

## 修改主题样式

* 打开 **主题配置文件**，目录 ` "D:\zhangypcn\hexo\themes\next\_config.yml" ` ，修改 Schemes 字段，设置喜欢的风格

  ```yaml
  # Next主题可选样式
  # Schemes
  ## Muse - 默认 Scheme，这是 NexT 最初的版本，黑白主调，大量留白
  ## Mist - Muse 的紧凑版本，整洁有序的单栏外观
  ## Pisces - 双栏 Scheme，小家碧玉似的清新
  # scheme: MUSE
  # scheme: Mist
  # scheme: Pisces
  scheme: Gemini
  ```

## 设置语言

* 打开 **站点配置文件** ` _config.yml ` ，目录 ` "D:\zhangypcn\hexo\_config.yml" ` ，修改 ` language ` 字段

  ```yaml
  language: zh-Hans
  ```

* 目前 NexT 支持的语言如以下表格所示：

  | 语言         | 代码                 | 设定示例                            |
  | :----------- | :------------------- | :---------------------------------- |
  | English      | `en`                 | `language: en`                      |
  | 简体中文     | `zh-Hans`            | `language: zh-Hans`                 |
  | Français     | `fr-FR`              | `language: fr-FR`                   |
  | Português    | `pt`                 | `language: pt` or `language: pt-BR` |
  | 繁體中文     | `zh-hk` 或者 `zh-tw` | `language: zh-hk`                   |
  | Русский язык | `ru`                 | `language: ru`                      |
  | Deutsch      | `de`                 | `language: de`                      |
  | 日本語       | `ja`                 | `language: ja`                      |
  | Indonesian   | `id`                 | `language: id`                      |
  | Korean       | `ko`                 | `language: ko`                      |

## 设置菜单

> 新版本菜单内容的设置格式是： ` Key: /link/||icon ` 
> 其中 ` Key ` 是菜单项的默认名称，将用于匹配图标和翻译，如果此菜单的翻译可以在语言中找到，将加载此翻译；` link ` 为目标链接； ` icon ` 为菜单项对应的图标/ [Font Awesome](http://fontawesome.io/) 图标的名称。

1. 设置菜单内容，打开 **主题配置文件**，目录 ` "D:\zhangypcn\hexo\themes\next\_config.yml" ` ，修改 menu 字段。

   ```yaml
   # 主菜单
   menu 
     #注意||前后不要留空格，否则会加载至404页面
     tags: /tags/||tags
     Portfolio: /Portfolio/||plug
   ```

2. 启用菜单图标，打开主题配置文件，修改 ` menu_icon ` 字段

   ```yaml
   # Enable/Disable menu icons.
   menu_icons:
     enable: true
   ```

3. 设置菜单项的显示文本。打开 NexT 主题目录下的 `languages/{language}.yml` 文件，（`{language}` 为网站所使用的语言）。以简体中文为例，若你需要添加一个菜单项，,则需要修改简体中文对应的翻译文件 `languages/zh-Hans.yml`，在 `menu` 字段下添加该项：

   ```yaml
   menu:
     tags: 标签
     Portfolio: 作品
   ```

4. 新建菜单项目标文件。使用新建页面指令， ` key_name ` 为菜单项及页面名称，没有对应页面，点击菜单打开后为404页面

   ```shell
   // 新建菜单项页面
   hexo new page key_name
   ```

## 设置侧边栏

1. 设置侧栏的位置，打开 **主题配置文件**，修改 ` sidebar.position ` 字段

   ```yaml
   sidebar:
     # Sidebar Position, available value: left | right (only for Pisces | Gemini).
     position: left
   ```

2. 设置侧栏显示的时机，打开 **主题配置文件**，修改 `sidebar.display` 字段

   ```yaml
   sidebar:
     # Sidebar Display, available value (only for Muse | Mist):
     #  - post    expand on posts automatically. Default.
     #  - always  expand for all pages automatically
     #  - hide    expand only when click on the sidebar toggle icon.
     #  - remove  Totally remove sidebar including sidebar toggle.
     display: post
   ```

## 设置头像

* 打开 **主题配置文件**，修改字段 `avatar` 

  ```yaml
  avatar: /images/custom/zhang.png
  ```

# 网站其他设置

* 打开 **站点配置文件**

  | 参数          | 描述                                                         |
  | :------------ | :----------------------------------------------------------- |
  | `title`       | 网站标题                                                     |
  | `subtitle`    | 网站副标题                                                   |
  | `description` | 网站描述                                                     |
  | `keywords`    | 网站的关键词。使用半角逗号 `,` 分隔多个关键词。              |
  | `author`      | 您的名字                                                     |
  | `language`    | 网站使用的语言。                                             |
  | `timezone`    | 网站时区。Hexo 默认使用电脑的时区。其他时区如 `America/New_York`, `Japan`, 和 `UTC` 。一般的，对于中国大陆地区可以使用 `Asia/Shanghai`。 |

# 主题其他设置

```shell
    # 友情链接
    Links 
    # 建站时间
    since
    # 添加文章更新时间
    updated_at
    # 添加站点访问统计
    busuanzi_count
    # 添加社交账号
    social
```

# 更新文章

* 新建文章

  ```shell
  hexo new 'my-blog'
  ```

* 上传部署

  ```shell
  hexo g -d
  ```

* 文章在首页显示 ` 阅读全文 `  效果

  ```markdown
  # 在文章合适的位置添加
  <!-- more -->
  ```

* 文章添加标题、更新时间、分类、版权声明、标签和其他属性，在文章开头添加以下内容

  ```markdown
  ---
  title: GitHub+Hexo+NexT搭建个人网站全流程及魔改记录
  date: 2020-04-20 14:00:00
  categories: Hexo
  copyright: true
  tags: 
  	- GitHub Pages
  	- Hexo
  	- NexT
  ---
  ```

* 



# 文章版权声明

## 添加版权声明

1. 修改主题配置文件，关键词：post_copyright，设置 enable 为 true 

   **目录：** ` .\yourWebsiteRootDir\themes\next\_config.yml `

   ```yaml
   # Declare license on posts
   post_copyright:
     enable: true
     license: <i class="fa fa-creative-commons"></i> BY-NC-SA 3.0
     license_url: https://creativecommons.org/licenses/by-nc-sa/3.0/
   ```


2. 修改站点配置文件，关键词：url，设置 url 为主页地址

   **目录：** ` .\yourWebsiteRootDir\_config.yml `

   ```yaml
   # URL
   ## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
   url: http://zhangypcn.github.io
   ```

## 自定义版权声明

### 自定义是否添加版权声明

1. 修改post-copyright.swig文件，添加文章是否开启版权声明的判断

   **目录** ` ".\yourWebsiteRootDir\themes\next\layout\_macro\post-copyright.swig" `

   ```yaml
   {% if page.copyright %}
     <div>    
       {% if not is_index %}
       
       ···
   
       {% endif %}
     </div>
   {% endif %}
   ```

   **修改后：**

   ```yaml
   {% if page.copyright %}
     <div>    
       {% if not is_index %}
   
         <ul class="post-copyright">
           <li class="post-copyright-author">
             <strong>{{ __('post.copyright.author') + __('symbol.colon') }}</strong>
             {{ post.author | default(config.author) }}
           </li>
           <li class="post-copyright-link">
             <strong>{{ __('post.copyright.link') + __('symbol.colon') }}</strong>
             <a href="{{ post.url | default(post.permalink) }}" title="{{ post.title }}">{{ post.url | default(post.permalink) }}</a>
           </li>
           <li class="post-copyright-license">
             <strong>{{ __('post.copyright.license_title') + __('symbol.colon') }} </strong>
             {{ __('post.copyright.license_content', theme.post_copyright.license_url, theme.post_copyright.license) }}
           </li>
         </ul>
   
       {% endif %}
     </div>
   {% endif %}
   ```

2. 文章添加前置内容copyright，若不需要版权声明，则设置为false，或者不加此项

   ```yaml
   title: XXX
   date: 2020-04-20 14:00:00
   copyright: true
   ...
   ```



# 相关链接

[GitHub Pages](https://pages.github.com/)

[Hexo](https://hexo.io/zh-cn/)

[NexT](http://theme-next.iissnan.com/)



---