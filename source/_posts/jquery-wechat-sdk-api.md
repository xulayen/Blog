---
title: jquery-wechat-sdk-api
date: 2017-11-15 23:01:25
categories: "tool"
tags:
     - Wechat
     - api
---

## 依赖模块

``` bash

$ npm install jqyery

$ npm install weixin-js-sdk


```

## 简介
> ***一个基于`jquery`的兼容AMD、CMD、Commandjs的[插件](https://www.npmjs.com/package/jquery_wechat_sdk)，目的在于帮助微信开发者更好的更方便的使用微信里面的api。***

<!-- more -->

## 快速上手

### 简单加载


导入资源

``` html

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
<script src="https://github.com/xulayen/WeChat/blob/master/static/script/Jquery.WeChat.1.2.2.js"></script>

```

#### 1、动态获取资源

``` js
var wechatMgr= $.WeChart({
    api: [''],
    type: ['GET'],
    facid: [''],
    typenum: [''],
    async: [false]
}).InitWeChat();
```

#### 2、静态获取资源

``` js
var wechatMgr= $.WeChart({
    appId: [''],
    timestamp: [''],
    nonceStr: [''],
    signature: ['']
}).InitWeChat();
```

## 入门篇

### 环境准备

准备基础环境 `nodejs` `npm`，基础浏览器一枚

### 安装

``` js

$ npm install jquery_wechat_sdk

```

### 设置

``` js
require.config({
　　　baseUrl: "./static",
　　　paths: {
        "jquery": "jquery",
        "jquery_wechat_sdk":"jquery_wechat_sdk"
　　  }
});
　　
require(['jquery','jquery_wechat_sdk'],function($){
    //dosomething……
});
```

## 进阶篇

### 微信菜单
`.InitWeChat()`api默认隐藏所有的微信功能菜单，如果需要显示某个功能菜单，如：

1. 显示分享到朋友圈
2. 显示分享给朋友


``` js

wechatMgr.InitWeChat({
    menu_share_timeline: true[false],
    menu_share_appMessage: true[false]
});

```

### 分享内容

#### 分享到朋友圈

* `object`是一个对象字面量
    * `forword_title`：标题
    * `forword_desc`：描述
    * `forword_link`：跳转链接
    * `forword_imgUrl`：图片地址
* `fn1`是成功分享之后的回调函数success(`res`)
    * `res` 回调函数总对象
* `fn2`是取消分享之后的回调函数cancel(`res`, `forword`)
    * `res` 回调函数总对象
    * `forword` 当前分享内容对象


``` js

wechatMgr.Forword([object],[fn1],[fn2])

```


#### 分享给朋友

* `object`是一个对象字面量
    * `forword_title`：标题
    * `forword_desc`：描述
    * `forword_link`：跳转链接
    * `forword_imgUrl`：图片地址
* `fn1`是成功分享之后的回调函数success(`res`)
    * `res` 回调函数总对象
* `fn2`是取消分享之后的回调函数cancel(`res`, `forword`)
    * `res` 回调函数总对象
    * `forword` 当前分享内容对象


``` js

wechatMgr.ForwordToFriend([object],[fn1],[fn2])

```
> **和分享到朋友圈一样，`ShareQQ `、`ShareWeibo `、`ShareQZone`也是如此操作。在这里就不做赘述了。**

### 获取地理位置

* `type`默认为`wgs84`的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入`gcj02`
* `fn`是获取地理位置成功之后的回调函数success(`res`,` latitude`, `longitude`, `speed`, `accuracy`)
    * `res`：回调总对象
    * `latitude`：经度
    * `longitude`：纬度
    * `speed`：速度
    * `accuracy`：精度

> **api这里没有给到`cancel`回调函数，如果需要此回调，可重写**


``` js

wechatMgr.GetLocation([type],[fn])

```

### 获取网络状态

* `fn`是成功获取当前网络状态之后的回调函数success(`res`, `networkType`)
    * `res`：回调总对象
    * `networkType`：当前网络类型

``` js

wechatMgr.GetNetWorkType(fn)


```


### 选择图片

* `fn`是当前成功回调函数success(`res`, `localIds`)
    * `res`：总回调对象
    * `localIds`：选定照片的本地ID列表，localId可以作为img标签的src属性显示图片

``` js

wechatMgr.ChooseImg([fn])

```

### 上传图片

* `imgLocalIds`需要上传的图片的本地ID，由`chooseImage`接口获得
* `fn`当前成功回调的函数success(`res`, `serverId`)
    * `res`：回调总对象
    * `serverId`：返回图片的服务器端ID

``` js

wechatMgr.UploadImage([imgLocalIds], [fn])

```

### 预览图片

* `previewCurrentImg`当前显示图片的http链接
* `previewUrls`需要预览的图片http链接列表[]

``` js

wechatMgr.PreviewImage([previewCurrentImg], [previewUrls])

```

### 打开地图

* `res`是一个对象包含
    * `latitude`：纬度，浮点数，范围为90 ~ -90
    * `longitude`：经度，浮点数，范围为180 ~ -180。
    * `name`：位置名
    * `address`：地址详细说明
    * `scale`：地图缩放级别,整形值,范围从1~28。默认为最大
    * `infoUrl`：在查看位置界面底部显示的超链接,可点击跳转

``` js

wechatMgr.OpenLocation(res)

```

### 调取摄像头
* fn是当前扫描成功之后的回调函数success(`result`)
    * `result`：扫码返回的结果

``` js
document.getElementById('btn1').onlick=function(){
    wechatMgr.Scan(fn)
}

document.getElementById('btn1').onlick=function(){
    $.Scan(fn)
}

$('#btn1').Scan(fn)
```


### 显示隐藏右上角菜单

``` js
/**隐藏右上角菜单**/
wechatMgr.HideOptionMenu();

/**显示右上角菜单**/
wechatMgr.ShowOptionMenu();
```

### 微信卡券




### 微信支付
* `object`是当前支付对象字面量
    * `timestamp`：支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
    * `nonceStr`：支付签名随机串，不长于 32 位
    * `package`：统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
    * `signType`：签名方式，默认为`SHA1`，使用新版支付需传入`MD5`
    * `paySign`：支付签名
* `fn`是当前支付成功回调函数success(`res`, `pay`)
    * `res`：当前支付回调总对象
    * `pay`：支付对象


``` js
wechatMgr.ChooseWXPay([object],[fn])
```


### 是否是微信浏览器
* `fn`是当前成功回调函数success(`isWeixinBro`)
    *  `isWeixinBro`是否是微信浏览器`boolean`

``` js
wechatMgr.IsWeChatBrower([fn])
```


### 关闭微信窗口

``` js
wechatMgr.CloseWindow()
```

### 异常捕获
* `fn`是当前异常捕获之后的回调函数success(`res`)
    * `res`是异常信息

``` js
wechatMgr.InitWxError([fn])
```

## API

### 可配置项
#### debug
是否打开debug调试，默认`false`
#### baseapi_checkJsApi
判断当前客户端是否支持指定的js接口，默认`true`
#### baseapi_onMenuShareTimeline
是否启用分享到朋友圈js接口，默认`true`
#### baseapi_onMenuShareAppMessage
是否启用分享给朋友js接口，默认`true`
#### baseapi_onMenuShareQQ

是否启用分享到QQjs接口，默认`true`
#### baseapi_onMenuShareWeibo
是否启用分享到微博js接口，默认`true`
#### baseapi_hideMenuItems
是否启用隐藏菜单js接口，默认`true`
#### baseapi_showMenuItems
是否启用显示菜单js接口，默认`true`
#### baseapi_hideAllNonBaseMenuItem
是否启用隐藏基础菜单js接口，默认`true`
#### baseapi_showAllNonBaseMenuItem
是否启用显示基础菜单js接口，默认`true`
#### baseapi_hideOptionMenu
是否启用隐藏普通菜单js接口，默认`true`
#### baseapi_showOptionMenu
是否启用显示普通菜单js接口，默认`true`
#### baseapi_closeWindow
是否启用关闭窗口js接口，默认`true`
#### baseapi_scanQRCode
是否启用扫描二维码js接口，默认`true`
#### baseapi_startRecord
是否启用录音js接口，默认`true`
#### baseapi_stopRecord
是否启用停止录音js接口，默认`true`
#### baseapi_onVoiceRecordEnd
是否启用录音结束js接口，默认`true`
#### baseapi_playVoice
是否启用播放录音js接口，默认`true`
#### baseapi_pauseVoice
是否启用暂停录音js接口，默认`true`
#### baseapi_stopVoice
是否启用停止录音js接口，默认`true`
#### baseapi_onVoicePlayEnd
是否启用播放停止js接口，默认`true`
#### baseapi_uploadVoice
是否启用上传录音js接口，默认`true`
#### baseapi_downloadVoice
是否启用下载录音js接口，默认`true`
#### baseapi_chooseImage
是否启用选择图片js接口，默认`true`
#### baseapi_previewImage
是否启用预览图片js接口，默认`true`,
#### baseapi_uploadImage
是否启用上传图片js接口，默认`true`
#### baseapi_downloadImage
是否启用下载图片js接口，默认`true`
#### baseapi_translateVoice
是否启用转换声音js接口，默认`true`
#### baseapi_getNetworkType
是否启用获取网络类型js接口，默认`true`
#### baseapi_openLocation
是否启用打开地图js接口，默认`true`
#### baseapi_getLocation
是否启用获取地理位置js接口，默认`true`
#### baseapi_chooseWXPay
是否启用微信支付js接口，默认`true`
#### baseapi_openProductSpecificView
是否启用跳转微信商品页js接口，默认`true`
#### baseapi_addCard
是否启用添加卡券js接口，默认`true`
#### baseapi_chooseCard
是否启用选择卡券js接口，默认`true`
#### baseapi_openCard
是否启用打开卡券js接口，默认`true`
#### appId
微信appid
#### timestamp
时间戳
#### nonceStr
特定字符窜
#### signature
签名
#### access_token
token
#### menu_share_timeline
分享到朋友圈，默认`true`
#### menu_share_appMessage
分享给朋友，默认`true`
#### menu_share_favorite
收藏，默认`true`
#### menu_share_openWithSafari
浏览器中打开，默认`true`
#### menu_share_email
邮件打开，默认`true`
#### menu_share_qq
分享到qq，默认`true`
#### menu_share_QZone
分享到qq空间，默认`true`
#### menu_share_weiboApp
分享到微博，默认`true`
#### menu_share_copyUrl
复制，默认`true`
#### menu_share_setFont
设置字体，默认`true`
#### menu_share_readMode
阅读模式，默认`true`
#### menu_share_refresh
刷新，默认`true`
#### api
远程api地址
#### facid
业务标识
#### typenum
公众号类型
#### scanAuthUrl
需要调取摄像头的页面，默认location.href
#### hideOptionMenu
是否隐藏菜单，默认`true`
#### async
是否异步，默认`true`
#### type
提交类型，默认`post`
#### ContentType
文档类型，默认`application/x-www-form-urlencoded`
#### cache
是否启用缓存，默认`true`


## FAQ

### 调用api的方式有几种？
1、`jquery`静态调用
``` js

document.getElementById('btn1').onlick=function(){
    $.Scan(fn)
}



```

2、`jquery`实例调用
``` js

$('#btn1').Scan(fn)

```

3、`wechart`对象调用
``` js

document.getElementById('btn1').onlick=function(){
    wechatMgr.Scan(fn)
}


```

### 如何调试debug
1、使用`微信开发这工具`[调试](https://mp.weixin.qq.com/debug/wxadoc/dev/devtools/download.html?t=2017119)

2、在`WeChart`中启用`debug`为``true``即可


### 无法使用`node`模式加载？
在`npm`是可以直接下载使用的，但是次此插件仅供在浏览器端使用，`node`端无法执行本插件。会抛出`jquery_wechat_sdk requires a window with a document`的异常


## 附录

### 需要改善的地方
1、获取`api`地址的地方的参数化需要抽象化。
2、微信支付必须在后台产生必要的支付信息`pay`之后才能发起请求，需要优化。
3、每次调用都会从服务器端获取`appid`等信息，需要优化处理。

### 外链地址
1、[微信官方文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1445241432)
2、[jquery_wechat_sdk](https://www.npmjs.com/package/jquery_wechat_sdk)在npm上的地址
3、[jquery_wechat_sdk](https://github.com/xulayen/WeChat/)源码


