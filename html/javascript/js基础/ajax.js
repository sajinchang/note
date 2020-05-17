function ajaxGet(url, data, callback) {
    // ajax get 请求
    // 未传值时处理undefine
    data = data ? data : {};

    var str = '';
    for (var i in data) {
        str += i + '=' + data[i] + '&';
    }
    var timer = new Date();
    url += '?' + str.slice(0, str.length - 1) + "__qft=" + timer.getTime();

    var xhr = new XMLHttpRequest();
    xhr.open('get', url, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            callback(xhr.responseText);
        }
    }

    xhr.send();
}

function ajaxPost(url, data, callback) {
    data = data ? data : {}
    var str = '';
    for (var i in data) {
        str += `${i}=${data[i]}&`
    }
    str = str.slice(0, str.length - 1);

    var xhr = new XMLHttpRequest();
    xhr.open('post', url, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            callback(xhr.responseText);
        }
    }

    // xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(str);

}