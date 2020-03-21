# js 事件阻止

# 默认事件

**阻止浏览器默认事件**
比如：a 链接跳转，form 表单提交，浏览器右键菜单

```javascript
/* 阻止默认事件的方式:
eve.preventDefault();
eve.returnValue = false;       // 兼容ie
*/


// 处理兼容问题
function stopDefault(eve){
    if(eve.prevntDefault){
        e.preventDefalut();
    }else{
        eve.returnValue = false;
    }
}
```

# 事件冒泡

**阻止某个同一事件在元素本身和父元素上一级一级触发**
```javascript
function (eve) {
    eve = eve || window.event;
    eve.stopPropagation();
    }
```
