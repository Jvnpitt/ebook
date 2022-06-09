function doLogin() {
    path = '/login'
    var xhr = new XMLHttpRequest();
    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        "Email":document.getElementById('email').value,
        "Password":document.getElementById('password').value,
    }));

    xhr.onreadystatechange = function() {
        if(this.readyState == this.HEADERS_RECEIVED) {
            window.location.href = '/';
        }
    }
}

function doRegister() {
    path = '/users'
    var xhr = new XMLHttpRequest();
    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        "UserName":document.getElementById('username').value,
        "Email":document.getElementById('email').value,
        "Password":document.getElementById('password').value,
    }));

    xhr.onreadystatechange = function() {
        if(this.readyState == this.HEADERS_RECEIVED) {
            window.location.href = '/';
        }
    }
}