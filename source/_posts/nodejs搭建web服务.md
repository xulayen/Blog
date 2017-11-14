---
title: 'nodejs搭建web服务'
date: 2016-10-25 15:35:40
categories: "Web"
tags:
     - Nodejs
     - Express
---


## 安装{% link nodejs https://nodejs.org/en/ %}、{% link npm https://www.npmjs.com/ %}

安装成功之后，使用命令测试是否成功：

``` bash

$ node -v

v6.10.2

```

``` bash

$ npm -v

5.3.0

```

<!-- more -->

## 初始化项目配置

在`chat`文件夹下执行初始化命令来获取package.json文件，如果你自己能记住也是可以手写的

``` bash

$ npm init

package name: (20171022)
version: (1.0.0)
description:
entry point: (index.js)
test command:
git repository:
keywords:
author:
license: (ISC)
About to write to C:\Users\Administrator\Desktop\20171022\package.json:

{
  "name": "20171022",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}


```

## web服务需要引用的模块

### http模块(http协议)
``` bash

$ npm install http --save-dev

```

``` js

var url = require('http');

```

{% blockquote @Helios_nannan http://blog.csdn.net/woshinannan741/article/details/51357464 %}

Node中提供了http模块，其中封装了高效的http服务器和http客户端
http.server是一个基于事件的HTTP服务器，内部是由c++实现的，接口由JavaScript封装
http.request是一个HTTP客户端工具。用户向服务器发送数据。

{% endblockquote %}


### url模块(url解析)
``` bash

$ npm install url --save-dev

```
``` js
var url = require('url');
```

{% blockquote @npm https://www.npmjs.com/package/url %}

This module has utilities for URL resolution and parsing meant to have feature parity with node.js core url module.

{% endblockquote %}


### fs模块(文件系统)
``` bash

$ npm install fs --save-dev

```
``` js
var fs = require("fs");
```
{% blockquote @平凡 http://www.cnblogs.com/pingfan1990/p/4707317.html %}

Node.js 文件系统封装在 fs 模块是中，它提供了文件的读取、写入、更名、删除、遍历目录、链接等POSIX 文件系统操作。

与其他模块不同的是，fs 模块中所有的操作都提供了异步的和 同步的两个版本，例如读取文件内容的函数有异步的 fs.readFile() 和同步的 fs.readFileSync()。我们以几个函数为代表，介绍 fs 常用的功能，并列出 fs 所有函数 的定义和功能。

{% endblockquote %}
### path模块(路径解析)
``` bash

$ npm install path --save-dev

```
``` js
var path = require("path");
```
{% blockquote @npm https://www.npmjs.com/package/path %}

This is an exact copy of the NodeJS ’path’ module published to the NPM registry.

{% endblockquote %}


## 构建一个基于nodejs的web服务器

新建一个`index.html`

``` html

<html>
<head>
<title>Sample Page</title>
</head>
<body>
Hello World!
</body>
</html>

```

新建一个`webserver.js`

``` js

var http = require('http');
var fs = require('fs');
var url = require('url');

// 创建服务器
http.createServer( function (request, response) {
   // 解析请求，包括文件名
   var pathname = url.parse(request.url).pathname;

   // 输出请求的文件名
   console.log("Request for " + pathname + " received.");

   // 从文件系统中读取请求的文件内容
   fs.readFile(pathname.substr(1), function (err, data) {
      if (err) {
         console.log(err);
         // HTTP 状态码: 404 : NOT FOUND
         // Content Type: text/plain
         response.writeHead(404, {'Content-Type': 'text/html'});
      }else{
         // HTTP 状态码: 200 : OK
         // Content Type: text/plain
         response.writeHead(200, {'Content-Type': 'text/html'});

         // 响应文件内容
         response.write(data.toString());
      }
      //  发送响应数据
      response.end();
   });
}).listen(8081);

// 控制台会输出以下信息
console.log('Server running at http://127.0.0.1:8081/');

```

安装用到的模块到本地项目中：

``` bash

$ npm install path --save-dev

$ npm install fs --save-dev

$ npm install http --save-dev

$ npm install url --save-dev

```

安装成功之后执行命令

``` bash

$ node webserver

```

在浏览器起中打开：http://127.0.0.1:8081/ 即可查看效果：

{% img /img/nodejs搭建web服务/001.png %}


## Express

{% blockquote @express http://expressjs.com/ %}

Express is a minimal and flexible Node.js web application framework that provides a robust set of features for web and mobile applications.

{% endblockquote %}

express API地址：http://www.expressjs.com.cn/4x/api.html

创建一个文件夹`express+nodejs`，执行初始化项目操作，在项目上安装`express`

``` bash

$ npm install express --save

```

并且新建`index.js`、`index.html`文件

``` js

var express = require('express');
var app = express();

app.get('/', function(req, res){
  res.send('hello world2');
});

app.listen(3000);

```

``` html

<html>
<head>
<title>Sample Page</title>
</head>
<body>
Hello World!
</body>
</html>

```


在命令行中执行：
``` bash

$ node index

```

如果提示`listen EADDRINUSE :::3000`就说明端口被占用了，可以换成其他端口

``` bash

Error: listen EADDRINUSE :::3000
    at Object.exports._errnoException (util.js:1018:11)
    at exports._exceptionWithHostPort (util.js:1041:20)
    at Server._listen2 (net.js:1262:14)
    at listen (net.js:1298:10)
    at Server.listen (net.js:1394:5)
    at EventEmitter.listen (E:\工作\workpace\Express\node_modules\express\lib\application.js:618:24)
    at Object.<anonymous> (E:\工作\workpace\Express\index.js:8:5)
    at Module._compile (module.js:570:32)
    at Object.Module._extensions..js (module.js:579:10)
    at Module.load (module.js:487:32)

```

在浏览器中打开 http://localhost:3000/

{% img /img/nodejs搭建web服务/002.png %}


### 使用Express加载模版并输出数据

未完待续……