# vue 指令系统

> vue 指令全部是 `v-*` 样子的

## 条件循环指令，事件绑定

> `v-if`
> `v-on` ----> `v-on:click="funcName"`

```html
   <div id="app">
        <h1 v-if='show'>{{ msg }}</h1>
        <button v-on:click='switchShow'>切换</button>
    </div>
```

```javascript
    var app = new Vue({
        el: '#app',
        data: {
            msg: 'sam',
            show: false,
        },
        methods: {
            // 对象的单体模式
            switchShow() {
                this.show = !this.show;
            },

            // switchShow: function(){
            //     this.show = ! this.show;
            // }
        }
    })

```

## v-show

> `v-show`: 控制显示（修改 css)

## v-bind（绑定属性）

> `v-bind:click` = `:click` = `@click`

```html
  <div id="app">
        <h1 v-if='show' v-bind:title="title_data">{{ msg }}</h1>
    </div>
```

```html
 <style>
        .box {
            width: 200px;
            height: 200px;
            background-color: rebeccapurple;
        }

        .box1 {
            background-color: green;
        }
        .box2{
            width: 400px;
            height: 400px;
        }
    </style>


  <div id="app">
        <h1 v-if='show' v-bind:title="title">{{ msg }}</h1>
        <button v-on:click='switchShow'>切换</button>
        <!-- 多属性绑定 -->
        <div class="box" v-bind:class="{ box1: isGreen, box2: bigger }"></div>
        <button @click='switchColor'>颜色切换</button>

    </div>


    <script>
    var app = new Vue({
        el: '#app',
        data: {
            msg: 'sam',
            show: false,
            title: "啊哈哈",
            isGreen: false,
            bigger: false
        },
        methods: {
            // 对象的单体模式
            switchShow() {
                this.show = !this.show;
            },
            switchColor() {
                this.isGreen = !this.isGreen;
                this.bigger = !this.bigger;

            }
        }
    })
</script>
```

> 数组语法 

```html
<div v-bind:class='[green, bigger]'>v-bind 数组</div>

<script>
    var app = new Vue({
        el: '#app',
        data: {
            green: 'box1',
            bigger: 'box2'
        },
    })
</script>
```