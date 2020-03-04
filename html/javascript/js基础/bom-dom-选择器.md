# dom bom 选择器

## window 对象

**window 对象是浏览器内置的一个对象，是对 BOM 的抽象，window 对象是 js 中全局对象的寄存地**

1. window 对象常见的方法

```javascript
alert("弹出信息框");
prompt();                   // 弹出输入框, 确定返回字符串, 取消返回 null
confirm();                  // 提示文字, 确定返回true, 取消返回false

close();                    // 关闭浏览器(火狐仅仅支持脚本打开的页面)
open(url, name, feature, replace);
    /*
    url: 要在新窗口打开的链接
    name(可选): 声明了新窗口的名称
    feature(可选): 参照a链接的target属性
    replace(可选):　可以指定打开页面的大小等等
    */
```

2. window 对象的内置子对象

```javascript
1. history 对象包含浏览器访问过的url
history.length;          // 返回历史记录的长度

history.back();          // 加载前一个url
history.forward();       // 前进,加载后一个url
history.go(num);        // num>0(前进相应的数目), num<0(后退相应的数目), num=0(刷新页面)

2. location 包含url的相关信息
location.href;              // 返回或者设置完整的url, 可以进行页面跳转
location.search;            // 返回url中?后面的查询参数部分
location.hash;              // 返回url中的锚点,可读可写

location.reload();          // 刷新页面,(传递一个true,不使用缓存刷新)
location.assgin("");        // 刷新页面(需要传递一个空字符串)

3. navigator 对象(浏览器信息)
navigator.appName           // 返回当前浏览器的名称
navigator.appVersion;       // 返回浏览器的版本号
navigator.platform;         // 返回当前计算机的操作系统名称
// 以上的三个属性逐渐被抛弃

navigator.userAgent;        // 返回浏览器信息

```

3. 事件

* onload 加载事件

`当文档加载完执行一些操作`

```javascript
window.onload = function(){
    console.log("文档加载完成");
}
```

* onscroll 页面滚动事件

`当页面发生一些滚动时执行一些操作`

```javascript
//  页面滚动条距离顶部的距离
document.documentElement.scrollTop;

// 页面滚动条距离左边的距离
document.documentElement.scrollLeft;
```

* onresize 

`当窗口大小发生改变时执行一些操作`

## DOM 选择器

|名称|使用|返回值|
|-|-|-|
|id选择器|getElementById("id")|返回一个节点对象|
|标签选择器|getElementsByTagName("span")|获取相同元素的节点列表|
|name选择器|getElementsByName()|通过name属性值获取元素,返回数组,通常获取有name的input标签|
|类选择器|getElementsByClassName("className")|通过class名获取元素|

**ES5选择器**

```javascript
document.querySelectorAll("css选择器语法");     // 返回一个数组(支持ie8+)
document.querySelector("css选择器语法");     // 返回单个元素(支持ie8+)
```