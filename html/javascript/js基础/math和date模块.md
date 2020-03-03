# 内置对象 Math 和 Date

## Math

### Math 的方法

```javascript
Math.round(3.6);        // 四舍五入
Math.random();          // 返回一个大于0小于1的随机数
Math.max(a, b, c);      // 返回最大值
Math.min(a, b, c);      // 返回最小值
Math.abs(num);          // 返回绝对值
Math.ceil(3.6);         // 向上取整
Math.floor(3.6);        // 向下取整
Math.pow(x, y);         // x的y次方
Math.sqrt(num);         // 对num开平方
Math.sin(x);            // x的正弦值,返回值在-1到1之间,x为弧度值,并非角度
Math.cos(x);            // x的余弦值,返回值在-1到1之间,x为弧度值,并非角度
```

### Math 的属性

```javascript
Math.PI;                // 约等于3.14159
```

### 生成范围随机数

```javascript
Math.round(Math.random() * (max - min) + min)
```

## Date

**Date 对象不同于 Math, 需要自己先创建对象 `var date = new Date()`**

### 获取时间

```javascript
var date = new Date()

console.log(date.getFullYear());         // 获取年
console.log(date.getMonth());            // 获取月
console.log(date.getDate());             // 获取日
console.log(date.getDay());              // 获取星期

console.log(date.getHours());            // 或取小时
console.log(date.getMinutes());          // 获取分钟
console.log(date.getSeconds());          // 获取秒
console.log(date.getMilliseconds());     // 获取毫秒

console.log(date.getTime());             // 获取时间戳

console.log(date);          // 获取本地时间
```

### 设置时间

1. 简单设置

```javascript
var date = new Date('2020/3/2');
```

2. 复杂

```javascript
var date = new Date();

date.setFullYear(2020);         // 设置年
date.setMonth(14);              // 设置月,超过11,累加年
date.setDate(30);               // 设置日,超过最大日期累加月
date.setHours(40);              // 设置小时,超过24小时,累加天
date.setMinutes(30);            // 设置分钟,超过60分钟累加小时
date.setSeconds(65);            // 设置秒,超过60秒累加分钟
date.setMilliseconds(40);       // 设置毫秒,超过1000毫秒累加秒

date.setTime(10000000);         // 设置从时间戳起始点过去了多少毫秒

console.log(date);              // 返回更改后的时间

```
