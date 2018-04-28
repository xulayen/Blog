---
layout: how
title: how-display-contents-works
date: 2018-03-29 18:03:05
tags:
---

> 正如我们所知道的，[文档树里面的每一个元素都是一个盒子模型](https://bitsofco.de/controlling-the-box-model/)。

首先，我们有一个实际的框，它由边框、填充和边缘区域组成；其次，我们的盒子有内容、内容区域。

![image](/img/how-display-contents-works/Group-3.png)

使用CSS`display`属性，我们可以控制该框及其子对象在页面上的绘制方式。我们可以把这个盒子放在它的兄弟姐妹节点中，比如`inline`。我们可以把这个盒子装得像一张`table`一样。我们甚至可以把盒子放在一个完全不同的z轴上。

`display`属性只有两个值，用于控制标记中定义的元素是否会生成一个框。任何值都不会导致该框或其内容被绘制在页面上。另一方面，新出现的内容值将导致被绘制为正常的框的内容，而周围的框则完全被忽略。


What happens when you use display: contents?



<!--more-->