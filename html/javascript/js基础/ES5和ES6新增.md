# ES5 和 ES6 新增内容

## 严格模式

```javascript
// 进入严格模式, 在全局顶部
"user strict"
```

## bind

bind() 方法会创建一个新函数，称为绑定函数。当调用这个绑定函数时，绑定函数会以创建他是传入的 bind() 方法的第一个
参数作为`this`, 传入 bind() 方法的第二个参数以及后面的参数加上绑定函数运行时本身的参数按照顺序作为原函数的参数来
调用原函数。

```javascript
// bind方法可以改变当前函数的this指向
function test (){
    console.log(this);
    console.log(arguments);
}

test.bind("this 指针", "参数1", "参数2")()

// VM338:2 String {"this 指针"}0: "t"1: "h"2: "i"3: "s"4: " "5: "指"6: "针"length: 7__proto__: String[[PrimitiveValue]]: "this 指针"
// VM338:3 Arguments(2) ["参数1", "参数2", callee: ƒ, Symbol(Symbol.iterator): ƒ]
```

### 事件委托

```javascript
function eventDelegation(children, callback){
    // 利用bind方法封装事件委托
    return function(eve){
        eve = eve || window.event;
        var target = eve.target || eve.srcElement;

        // 遍历传进来的子元素
        for(var i = 0; i < children.length; i++){
            // 将事件源和我们需要点击的元素进行比较, 如果相等表示找到点击的元素了
            if(children[i] == target){
                callback.bind(target)();
            }
        }
    }
}

```

## let

ES6 中新增的生面变量方式

`let` 关键字声明变量，类似于`var`, 区别如下：

- 不存在变量提升
- 暂时性死区
- 不允许重复声明，同一作用域内只能声明一次
- 新增块级作用域 (for 循环的作用域）

## const

`const` 声明变量，表示为常量，不能再次修改（不能修改变量的指针）, 其他的于`let`一致
所谓不能改变指针，表示简单的数据结构不可以改变 (number, str, boolean), 其他的对象类型可以修改其内部的值

## JSON.parse 和 JSON.stringify

ES5 中增加了 json 序列化和反序列化的方法

|方法|描述|
|:---:|:---:|
|JSON.parse(str)|将 json 字符串转换为对象|
|JSON.stringify(obj)|将对象转换为 json 字符串|

**在转换的数据时，不允许出现函数 (function), undefined, NaN**

## 字符串扩展

Unicond 编码，4 位十六进制

### 字符串新增的方法

**主要针对不常见的字**

```javascript
// 获取字符的unicond编码
codePointAt()   // 新增
charCodeAt()    //
String.fromCodePoint() // 将unicnod编码转换为字符

// 重复功能
str.repeat(num)    // 将字符串重复拼接num次

// indexOf() 补充
// 判断字符串中是否存在某个字符串
var str = "hello world"
str.includes("ll", [start])      // true
str.startsWith("he"[start])        // true
str.endsWith("d", [start])       // true

```

### for-of 循环

类似于 for-in 的使用

```javascript
// 类似于python中的for-in循环
var str = "abc";
for(var i of str){
    console.log(i)      // a->b->c
}
```

### 字符串模板

ES6 中新增反引号字符串，使得字符串拼接变得很方便，模板还可以调用函数。

e.g.

```javascript
var arg1 = "hello";
var arg2 = "world";
function test(){
    return "test"
}
var str = `${arg1}, ${arg2}---${test()}`
```

## 正则扩展

1. u
ES6 中新增的正则表达式`u`修饰符，表示 Unicode, 用来处理大于`\uFFFF`的 unicode 编码。也就是说，他可以正确的处理。
四个字节的 UTF-16 编码。
**用法和`i`和`g`一致**

2. y

ES6 添加了`y`修饰符，和 g 类似。但是`y`修饰符在下次匹配的时候需要紧跟上次匹配成功之后的结果，而`g`表示全局，`i`
表示忽略大小写。

```javascript
var s = 'aaa_aa_a’;
var r1 = /a+/g;
var r2 = /a+/y;

r1.exec(s) // ["aaa”]
r2.exec(s) // ["aaa”]
r1.exec(s) // ["aa”]
r2.exec(s) // null
```

## => 函数

**=>函数类似于匿名函数，多用于回调函数**

```javascript
var fn = ()=>{
    console.log("匿名函数");
}

// 最简洁的方式, 但是没不能写复杂的逻辑,只能写一条简单的语句
var fn = a=>a+"world";
```

## symbol

新增的数据类型，Symbol 函数会生成一个唯一的值，可以理解为 Symbol 类型跟字符串是接近的，但是每次生成唯一的值，
也就是每一次生成的值都不相等，他的值是多少并不重要，在意的是谈的值每次都不相等。

```javascript
// 定义方式
var s = Symbol("s")

var SIZE = {
    MIDDLE: Symbol(),
    SMALL: Symbol(),
    LARGE: Symbol()
}

function create(size){
    switch(size){
        case SIZE.MIDDLE:
            console.log("middle"); break;
        case SIZE.SMALL:
            console.log("small"); break;
        case SIZE.LARGE:
            console.log("large"); break;
    }
}

create(SIZE.LARGE);     // large
```

## set 和 map 结构

### map

map 集合，即映射，遍历方式用`for-of`, 使用 key(), value(), entires().

```javascript
let map = new Map();

// 添加元素
map.set("001", "sam")
map.set("002", "tom")

// 获取元素
map.get("001");         // sam


// 循环遍历
for(let [key, value] of map){
    console.log(key + ": " + value);
}

```

### set

set 集合，顾名思义就是数学中的集合，最大的特点就是元素不重复，可以用作去重。所谓的不可以重复是严格意义上的不可以
重复，并非是字面上的相等，即`===`, set 本质上还是 map.

```javascript
let ss = new Set()

ss.add(1);
ss.add(2);
ss.add(new String("abc"))
ss.add(1);  // {1, 2, "abc"}

// set 集合并没有提供下标方式的访问,因此只能用`for-of`来遍历
for(let s of ss){
    console.log(s);   // 1   2   "abc"
}

// 数组去重

var arr = [1, 2, 3, 4, 4, 3, 6]
var mySet = new Set(arr)
var newArr = []
for(s of mySet){
    newArr,push(s);
}

var ss = new Set([1, 2, 3])

// 根据 keys 遍历
for(let s of ss.keys()){
    console.log(s);     // 1   2   3
}

// 根据 values 遍历
for(let s of ss.values()){
    console.log(s);         // 1   2   3
}

// 根据 key, value 遍历
for(let s of ss.entries()){
    console.log(s);     // [1, 1]   [2, 2]   [3, 3]
}

```

## class
