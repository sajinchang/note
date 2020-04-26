# DOM 常用操作

## DOM 属性的基本操作（增删改查）

1. 内置属性

内置属性可以直接通过 `.` 操作

|属性|返回值|
|:-:|:-:|
|tagName|           |返回当前元素的标签名|
|innerHTML/innerText|返回当前元素的内容|
|id                 |返回当前元素的 id|
|title              |获取 title 的标签值，这个 title 是从 document 中获取的|
|className          |返回当前元素的 class 属性|
|href               |返回值是当前的 href 的值|
**以上这些属性即可以获取也可以设置**

2. 非内置属性

```javascript
getAttribute()              // 获取元素的属性
setAttribute(attr, value)   // 设置修改元素的属性,接收两个参数, 属性名和属性值
removeAttribute()           // 删除元素的属性

```

## 节点

1. 获取 DOM 节点

```javascript
obj.parentNode                  // 获取父元素节点
obj.children                    // 获得子元素节点的集合, 不包含空白节点
obj.childNodes                  // 获取所有子节点的集合, 包括空白节点

obj.attributes                  // 获得所有的属性节点,返回一个数组

```

2. childNodes 过滤空白节点

通过 obj.childNodes 获得所有子节点的集合
节点属性 nodeType 返回值为数值

|节点描述|节点类型 (nodeType)|节点名字 (nodeName)|节点值 (nodeValue)|
|:-:|:-:|:-:|:-:|
|元素节点|1|标签名|null|
|文本节点|3|#text|文本|
|注释节点|8|#document|注释的文字|
|文档节点|9|#document|null|
|属性节点|2|属性名|属性值|

3. 高级选取（子节点、父节点、兄弟节点）

|节点|描述|
|:-:|:-:|
|obj.childNodes|获取当前元素节点的所有子节点|
|obj.ownerDocument|获取该节点的文档根节点，相当于 documentb|
|obj.firstChlid|获取第一个子节点 (IE7/8 非空白节点，可能是注释节点）|
|obj.lastElementChild|获取第一个非空白节点（即：获取第一个标签）(IE7/8 不支持）|
|obj.lastChlid|获取最后一个子节点（IE7 最后一个元素节点，IE8 最后一个非空白节点，可能是注释节点）|
|obj.lastElementChild|获取最后一个非空白节点（IE7/8 不支持）|
|obj.nextSibling|获取下一个兄弟节点（包含空白节点和注释，IE7/8 包括注释节点，不包括空白节点）|
|obj.nextElementSibling|获得下一个兄标签（IE7/8 不支持）|
|obj.previousSibling|获得上一个兄弟节节点（包含空白节点和注释，IE7/8 包括注释节点，不包括空白节点）|
|obj.previousElementSibling|获得上一个元素标签（IE7/8 不支持）|

*以上内容兼容性差

4. DOM 元素的基本操作（增删改查）

```javascript
查询: 选择器

// 创建:
var div = docuemnt.createElement('div');   // 创建标签
obj.appendChild(div);                 //将创建好的元素,插入到某个标签内的最后

// 删除:
removeChild(子标签) 配合parentNode
obj.remove()   //　直接删除当前元素

// 修改:
var html = obj.outerHTML;    // 获取当前标签的内容
obj.outerHTML = "<div>" + obj.innerHTML + "</div>"

// 创建文本节点
createTextNode("hello");

insertBefore(newNode, oldNode);     // 在某个节点之前插入一个新的节点

```

## 样式

### 获取非行内样式

*解决兼容问题*

```javascript
function getStyle(obj, attr){
    if(obj.currentStyle){       // 针对ie获取非行间样式
        return obj.currentStyle[attr];
    }

    // 针对非IE
    return getComputedStyle(obj, false)[attr];
}

```

### css 尺寸

```javascript
offsetParent: 获取元素最近的具有定位属性(absolute 或者 relative) 的父级元素.如果没有返回body
offsetLeft: 获取元素相当具有定位属性的父级元素的左侧偏移距离
offsetTop: 获取元素相当具有定位属性的父级元素的顶部偏移距离
offsetWidth: 元素实际宽度
offsetHeight: 元素实际高度
clientWidth: 元素视图宽度
clientHeight: 元素视图高度
scrollLeft: 滚动条最顶端和窗口中课件内容的最顶端之间的距离
scrollTop:


console.log(obox.offsetHeight);          //cont + padding + border
console.log(obox.clientHeight);          //cont + padding
console.log(obox.scrollHeight);          //cont + padding + scroll
console.log(obox.offsetLeft);            //margin + position
```

### CSS 非尺寸样式

1. 行内样式

```javascript
console.log(obj.style.width);           // 获取
obj.style.width = "200px";              // 设置单个样式

// 一次性设置多个样式
obj.style.cssText = "width: 200px; height: 80px; background: red";
```

2. 非行内样式

```javascript
// 既可以获取行内样式, 也可以获取非行内样式, 但是只能获取, 不能设置

// 该方法第一个参数是元素标签, 第二个false表示获取非伪类样式(:after等等), 返回对象
console.log(getComputedStyle(obj, false));          // ie不支持
console.log(obj.currentStyle);                      // ie支持, 获取样式在标签的currentStyle属性上
```

### 浏览器及元素各项尺寸

![浏览器及元素各项尺寸的图示](./pictures/style.gif "尺寸图")
