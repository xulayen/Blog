---
title: react and vue summary
categories: "Web"
tags:
     - React
     - Vue
     - Webpack
---

## 前言

> 俗话说的好，好记忆不如烂键盘；所以博主就把自己理解的或者别人总结的东西放到这里

<!-- more -->

## React理解总结笔记

### 语法

1、自定义组件名首字母必须大写


### 组件

#### 如何编写组件

1、ES5编写JSX

``` js
var HelloMessage = React.createClass({                                                
    render:function(){                                                                  
        return(                                                                               
            <div>
                Hello, world!
            </div>
        )                                                                                       
    }                                                                                          
}) 
```

2、ES6语法编写JSX

``` js
import React from 'react';
class HelloMessage extends React.Component {
    render () {
        return (
            <div>
                Hello, world!
            </div>
        )
    }
}
```

#### 生命周期

1、构造函数
> 构造函数，在创建组件的时候调用一次。

``` js
constructor(props, context)
```

2、渲染前
``` js
void componentWillMount()
```

3、渲染完成后
``` js
void componentDidMount()
```

4、组件挂载之后加载
``` js
void componentWillReceiveProps(nextProps)
```

5、组件状态被修改前
``` js
void componentWillUpdate(nextProps, nextState)
```

6、组件被修改完成之后
``` js
void componentDidUpdate()
```

7、组件被销毁前
``` js
void componentWillUnmount()
```

8、是否需要渲染
> 组件挂载之后，每次调用setState后都会调用shouldComponentUpdate判断是否需要重新渲染组件。
> 默认返回true，需要重新render。在比较复杂的应用里，有一些数据的改变并不影响界面展示，可以在这里做判断，优化渲染效率。

``` js
bool shouldComponentUpdate(nextProps, nextState)
```

### 更新方式
> 在react中，触发render的有4条路径。

1、首次渲染Initial Render
2、调用this.setState （并不是一次setState会触发一次render，React可能会合并操作，再一次性进行render）
3、父组件发生更新（一般就是props发生改变，但是就算props没有改变或者父子组件之间没有数据交换也会触发render）
4、调用this.forceUpdate

如图：

![image](/img/react-and-vue-summary/reactzq.png)

### state

> 个人认为，state一般存在于父组件或者自身需要即时获取用户状态的情况下使用，state在组件中是越少越好

### props

> 个人认为，props一般存在于子组件，父组件的state数据变化传递给子组件作为props来更新视图，而且不可被改变

### state和props的关系

> Props and state are related. The state of one component will often become the props of a child component. 
> Props are passed to the child within the render method of the parent as the second argument to React.createElement() or, if you're using JSX, the more familiar tag attributes.
> 属性和状态是有联系的。通常，一个组件的state会变成另一个组件的props,子组件的render函数会被props传递给`React.createElement()`的第二个参数，或者你使用jsx会变成其他属性

```js 
<MyChild name={this.state.childsName} />
```

> The parent's state value of childsName becomes the child's this.props.name. From the child's perspective, the name prop is immutable. If it needs to be changed, the parent should > just change its internal state:
> 父组件的`state.childsName`会变成子组件的属性`this.props.name`,子组件的props是不能被改变的。如果需要改变，父组件需要改变它的内部state

``` js
this.setState({ childsName: 'New name' });
```

> and React will propagate it to the child for you. A natural follow-on question is: what if the child needs to change its name prop? This is usually done through child events and  > parent callbacks. The child might expose an event called, for example, onNameChanged. The parent would then subscribe to the event by passing a callback handler.
> 然后React会传递给子组件给用户，那么问题来了：子组件如何改变属性状态？这通常需要通过子组件的事件和父组件的回调来完成。子组件需要暴露一个事件名称，举个例子，父组件将会订阅回调事件`onNameChanged`

``` js
<MyChild name={this.state.childsName} onNameChanged={this.handleName} />
```

> The child would pass its requested new name as an argument to the event callback by calling, e.g.,  this.props.onNameChanged('New name'), and the parent would use the name in the > event handler to update its state.
> 子组件将会通过请求一个新的名称作为参数提交给事件回调，举个例子`this.props.onNameChanged('New name')`，在父组件将会用这个新的名称来更新state

``` js
handleName: function(newName) {
   this.setState({ childsName: newName });
}
```
## Vue理解总结笔记