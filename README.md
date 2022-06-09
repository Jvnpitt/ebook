# 2021-unicap-eng-soft-ESebo-app-01

Install:
```
$ gem install bundler
$ bundle install
```


Run: 
```
$ ruby main.rb
```


```
POST /users HTTP/1.1
Host: <host>

{"UserName": "<name>", "Email" : "<email>", "Password": "<password>"}
```

```
POST /login HTTP/1.1
Host: <host>

{"Email" : "<email>", "Password": "<password>"}
```

```
POST /books HTTP/1.1
Host: <host>

{"BookName": "<name>", "AuthorName": "<name>", "CategoryName": "<name>", "UnitPrice": "<price>", "UnitsInStock": "<units>", "BookImgURL":"<url>"}
```

```
POST /books/search HTTP/1.1
Host: <host>

{"BookName": "3129"}
```

```
GET /orders/<orderID> HTTP/1.1
Host: <host>
```

