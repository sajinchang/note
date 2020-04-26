function move(ele, obj, callback) {
    /*
    ele: dom obj, 运动源,元素
    obj: 对象, 运动的属性和目标,需要遍历
    callback: 回调函数
    */
    // 每一次运动先停止计时器
    clearInterval(ele.timer);

    ele.timer = setInterval(function () {
        var flag = true;
        for (var attr in obj) {
            if (attr == "opacity") {
                var currentStyle = getStyle(ele, attr) * 100;
            } else {
                var currentStyle = parseInt(getStyle(ele, attr));
            }

            var speed = (obj[attr] - currentStyle) / 6;
            speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);

            if (attr == "opacity") {
                currentStyle += speed;
                ele.style[attr] = currentStyle / 100;
            } else {
                ele.style[attr] = currentStyle + speed + "px";
            }

            if (currentStyle != obj[attr]) {
                flag = false;
            }
        }

        if (flag) {
            clearInterval(ele.timer);
            callback && callback();
        }

    }, 30)
}

function getStyle(ele, attr) {
    //  获取元素的样式(attr)
    if (getComputedStyle) {
        return getComputedStyle(ele, false)[attr];
    } else {
        return ele.currentStyle[attr];
    }
}