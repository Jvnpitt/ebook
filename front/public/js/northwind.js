function editCustomer(customerID) {
    console.log(customerID)
    path = '/edit/customers/' + document.getElementById('CustomerID').value
    var xhr = new XMLHttpRequest();
    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        "CustomerID":document.getElementById('CustomerID').value,
        "CompanyName":document.getElementById('CompanyName').value,
        "ContactName":document.getElementById('ContactName').value,
        "Address":document.getElementById('Address').value,
        "PostalCode":document.getElementById('PostalCode').value,
        "Country":document.getElementById('Country').value,
        "Phone":document.getElementById('Phone').value
    }));

    xhr.onreadystatechange = function() {
        if(this.readyState == this.HEADERS_RECEIVED) {
            window.location.href = '/customers/update/success';
        }
    }
}

function insertCustomer(customerID) {
    console.log(customerID)
    path = '/insert/customers'
    var xhr = new XMLHttpRequest();
    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        "CompanyName":document.getElementById('CompanyName').value,
        "ContactName":document.getElementById('ContactName').value,
        "Address":document.getElementById('Address').value,
        "PostalCode":document.getElementById('PostalCode').value,
        "Country":document.getElementById('Country').value,
        "Phone":document.getElementById('Phone').value
    }));

    xhr.onreadystatechange = function() {
        if(this.readyState == this.HEADERS_RECEIVED) {
            window.location.href = '/customers/insert/success';
        }
    }
}