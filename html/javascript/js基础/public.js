function getStyle(ele, attr) {
    // 获取一个元素的style属性值
    if (getComputedStyle) {
        return getComputedStyle(ele, false)[attr];
    }
    return ele.currentStyle[attr];
}

function random(a, b) {
    // 获取一个a-b之间的一个随机数 
    return Math.round(Math.random() * (a - b) + b);
}