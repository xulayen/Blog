---
title: 一行代码搭建Hexo站点
date: 2017-10-23 15:32:14
categories: "Web"
tags:
     - Hexo
     - NexT
---

## 初始化Hexo模版引擎

{% raw %}
一行代码快速搭建Hexo.NexT主题网站，来吧，趁热打铁一起快速进入学习吧！
{% endraw %}

### 执行安装
进入本机E盘Blog目录下
* 第一步，安装下载{% link Hexo https://hexo.io/ %}模版，即初始化{% link Hexo https://hexo.io/ %}模版
* 第二步，进入blog文件夹，执行安装依赖包
* 第三步，启动{% link Hexo https://hexo.io/ %}服务
* 第四步，打开控制台给出的http地址，http://localhost:4000/

<!-- more -->

{% codeblock %}
npm install hexo-cli -g

hexo init blog

cd blog

npm install

hexo server

{% endcodeblock %}

如果你没有安装npm，请先执行下载{% link 安装 https://www.npmjs.com/ %}

安装成功执行

{% codeblock %}

npm -v

{% endcodeblock %}

执行以上步骤之后在浏览器中键入http://localhost:4000 即可看到一个初始状态的模版

{% img /img/一行代码搭建hexo站点/01.jpg %}

### 修改测试端口号

如果需要修改端口4000，可以在node-modules文件夹下找到hexo-server模块中的index.js:

{% codeblock %}

/* global hexo */

'use strict';

var assign = require('object-assign');

hexo.config.server = assign({
  port: 5000,//自行修改端口号
  log: false,
  ip: '0.0.0.0',
  compress: false,
  header: true
}, hexo.config.server);


{% endcodeblock %}


修改之后重新执行hexo server即可:

{% img /img/一行代码搭建hexo站点/02.jpg %}


## 网站基础配置

### 显示或隐藏Menu菜单
在修改菜单之前你首先要弄清楚当前网站使用的皮肤是哪一个，打开网站根目录 `config_yml`
``` bash

# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: landscape

```

其中`landscape`就是你的皮肤框架


然后在网站根目录找到`themes/landscape`这里面就会有你菜单想的配置，同时这里面也有一个 `config_yml`，为了区分，我们索性把站点下的配置文件称为`站点配置yml`，皮肤框架下的配置文件称之为`皮肤配置yml`

OK，打开`皮肤配置yml`你会看到一些简短的配置，其中第一条就是我们的菜单栏配置

``` bash

# Header
menu:
  Home: /
  Archives: /archives

```

修改`Home`为`主菜单`，修改`Archives`为 `文章`，刷新浏览器http://localhost:5000 即可看到效果

### 配置站点基础信息

打开`站点配置yml`

``` bash
# Site
title: 标题
subtitle: 副标题
description: 描述
author: 作者
language: zh-Hans
timezone:

```

刷新浏览器 http://localhost:5000
{% img /img/一行代码搭建hexo站点/03.jpg %}


### 设置rss

在站点根目录执行安装hexo-generator-feed

``` bash

npm install hexo-generator-feed  --save-dev

```

在`站点配置yml`中配置插件，为了快速的找到配置项，可以放到文件的结尾

``` bash

plugins: hexo-generator-feed

feed:
  type: atom ##feed类型 atom或者rss2
  path: atom.xml ##feed路径
  limit: 20  ##feed文章最小数量

```

点击RSS按钮，会出现如下提示，前提是你的浏览器有rss功能，我本地使用的是`rss feed reader`：

{% img /img/一行代码搭建hexo站点/04.jpg %}


### 设置本地全局搜索

安装下载hexo-generator-searchdb模块
``` bash

npm install hexo-generator-searchdb --save-dev

```

`站点配置yml`需要配置

``` bash

search:
  path: search.xml
  field: post
  format: html
  limit: 10000

```


`皮肤配置yml`需要配置

``` bash

local_search:
  enable: true

```

当然你会发现并没有起作用，这是因为当前`landscape`并不支持本地搜索，后续将介绍`NexT`主题


### 使用命令生成静态文件

您可执行下列的其中一个命令，让 Hexo 在生成完毕后自动部署网站，两个命令的作用是相同的。生成的文件在网站`public`目录下

``` bash
hexo generate --deploy
hexo deploy --generate
```

可缩写为：

``` bash
hexo g -d
hexo d -g
```

## NexT主题

### 下载安装NexT模版

在github上{% link 下载 https://github.com/xulayen/hexo-theme-next %}NexT主题源码

把`NexT`主题源码的源码整个复制到你的站点目录下的`themes/next`目录下

### 修改`站点配置yml`来更改主题

文章上面有讲到，当前我们的主题使用的是`landscape`需要修改为`next`

重新启动服务

刷新页面查看效果

{% img /img/一行代码搭建hexo站点/05.png %}

### 学习并使用NexT主题配置

打开`next`的`皮肤配置yml`，你会看到很多我们不明白的配置项，根据注释可以读出其中配置的含义。


#### 根据语言配置菜单栏语言

打开`next皮肤配置yml`文件，找到`languages`文件夹

{% img /img/一行代码搭建hexo站点/06.png %}

点开`zh-Hans.yml`其中的配置项就是已经翻译的文本，网站会根据你`站点配置yml`中的语言配置来去读取对应的语言文件

打开你`next皮肤配置yml`你会看到菜单栏基础配置：

``` js

menu:
  home: / || home
  #about: /about/ || user
  #tags: /tags/ || tags
  #categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat

```

发现`home`和`archives`菜单是开启的，现在我们全部开启，只需要去掉前面的`#`，刷新浏览器

``` js

menu:
  home: / || home
  about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  schedule: /schedule/ || calendar
  sitemap: /sitemap.xml || sitemap
  commonweal: /404/ || heartbeat

```

尝试修改`站点配置yml`语言，重启服务后刷新浏览器

``` bash

language: zh-tw

```

{% img /img/一行代码搭建hexo站点/07.jpg %}

#### 配置站内搜索


安装下载hexo-generator-searchdb模块
``` bash

npm install hexo-generator-searchdb --save-dev

```

`站点配置yml`需要配置

``` bash

search:
  path: search.xml
  field: post
  format: html
  limit: 10000

```

`皮肤配置yml`需要配置

``` bash

local_search:
  enable: true

```

#### 配置rss

配置同见 2.3. 设置rss

#### 配置标签(tags)

添加标签其实就是在你的`source`文件夹下新建一个page页面而已，比如菜单上的`tags`和`about`或者`categories`都是一样的，执行命令

``` bash

hexo new page "tags"

```

会在`source`目录下生成一个对应的文件夹，其中有`index.md`文件，打开会看到一些基础配置：

``` bash

---
title: tags
date: 2017-10-24 12:02:51
---

```



#### 配置分类(categories)


``` bash

hexo new page "categories"

```

会在`source`目录下生成一个对应的文件夹，其中有`index.md`文件，打开会看到一些基础配置：

``` bash
---
title: categories
date: 2017-10-24 12:02:51
---

```


#### 配置站点基础信息

##### 配置头像

在`next皮肤配置yml`中可以配置远程地址，也可以是本地资源地址

``` bash

# Sidebar Avatar
# in theme directory(source/images): /images/avatar.gif
# in site  directory(source/uploads): /uploads/avatar.gif
avatar: 头像地址


```

##### 配置站点描述

在`站点配置yml`文件中，找到`menu/description`就是当前站点的描述

``` bash

description: 站点描述

```

##### 配置第三方跳转链接

在`next皮肤配置yml`中，找到`social`配置项

``` bash

social:
  GitHub: https://github.com/yourname || github
  E-Mail: mailto:yourname@163.com || envelope
  QQ: http://wpa.qq.com/msgrd?v=3&uin=yourqq&site=在线客服&menu=yes || qq
  #Google: https://plus.google.com/yourname || google
  #Twitter: https://twitter.com/yourname || twitter
  #FB Page: https://www.facebook.com/yourname || facebook
  #VK Group: https://vk.com/yourname || vk
  #StackOverflow: https://stackoverflow.com/yourname || stack-overflow
  #YouTube: https://youtube.com/yourname || youtube
  #Instagram: https://instagram.com/yourname || instagram
  #Skype: skype:yourname?call|chat || skype

```

##### 友情链接

在`next皮肤配置yml`中，找到`links`配置项

``` bash

links_icon: link
links_title: Links
links_layout: inline
links:
  friend1:
  friend2:
  friend3:

```


#### 配置阅读次数（使用第三方服务）

`leancloud`作为装逼神器确实不错，可以随意修改当前文章的阅读次数

``` bash

# Show number of visitors to each article.
# You can visit https://leancloud.cn get AppID and AppKey.
# 使用第三方服务 LeanCloud 查看文章阅读量
leancloud_visitors:
  enable: true
  app_id:
  app_key:

```


#### 配置评论（使用第三方服务）

在disqus官网 http://www.disqus.com 注册一个帐号添加应用之后可获得一个名称，作为你的shortname

``` bash

# Disqus
disqus:
  enable: true
  shortname: 你的名称
  count: true

```


#### 配置站点统计（使用第三方服务）

百度站点统计 http://tongji.baidu.com/web/welcome/login

``` bash

# Baidu Analytics ID
# 注意： baidu_analytics 不是你的百度 id 或者 百度统计 id
baidu_analytics: 327573ae29bff3e49a0152fd0be5e1c2

```


#### 当前文章是否启用评论配置

如果不需要当前页面或这文章不启用评论，则只需要添加以下配置：

``` js

---
title: tags
date: 2017-10-24 12:02:51
comments: false
---

```

### 自定义配置

#### 在每个文章的最后加上版权声明

* 新建 passage-end-tag.swig 文件

在路径 `\themes\next\layout\_macro`中添加`passage-end-tag.swig`文件，其内容可以自定义：

``` bash

{% if theme.passage_end_tag.enabled %}
<div>
<div style="text-align:center;color: #ccc;font-size:14px;">
------ 本文结束 ------</div>
<br/>

<ul class="post-copyright" style="margin: 2em 0 0; padding: 0.5em 1em;border-left: 3px solid #ff1700;background-color: #f9f9f9;list-style: none; ">
  <li class="post-copyright-author">
    <strong>本文作者：</strong>
    Xu Layen
  </li>
  <li class="post-copyright-license">
    <strong>版权声明： </strong>
    本博客所有文章除特别声明外，转载请注明出处！
  </li>
</ul>
</div>
{% endif %}



```

* 修改 post.swig 文件
在`\themes\next\layout\_macro\post.swig`中，`post-body`之后，`post-footer`之前添:

``` bash

  {% if not is_index %}
    {% include 'passage-end-tag.swig' %}
  {% endif %}

```

* 在`next主题配置yml`中添加字段

``` bash

# 文章末尾添加“本文结束”标记
passage_end_tag:
  enabled: true

```

## 结束语
跟着我的步骤可以很快的搭建一个属于自己的博客站点，当然`hexo.next`远远不知这些配置项，有兴趣的同学可以自己看看里面的配置。
这篇文章为什么叫一行代码搭建hexo博客呢，啊哈哈哈，不这样也不会有人看哇，懂hexo的人就不用看了，高手勿喷~另外可以使用翻墙软件在下方评论，写下你想说的话，没有翻墙的，可以直接在`站点概述`中qq我或者e-mail我都可以。
祝，早新手早日玩转hexo博客，这是 {% link 博主 http://xulayen.imwork.net/ %} 的博客，文章不定期更新

{% link NexT官网地址 http://theme-next.iissnan.com/getting-started.html %}





