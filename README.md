Public KV
=========

Suppose you want to store something from script running in browser, and then retrieve
the value from somewhere else. This is a primitive key-value store exactly for that.

Setup
=====
```
$ make
```

Run
===
```
$ _rel/pubkv_release/bin/pubkv_release start
```

Use
===
```
$ KV = http://kv.jamhed.tk | http://localhost:10080
$ UUID = `curl $KV/uuid`
```

Put
---
```
$ curl -X PUT -H "Content-Type: application/json"  -d '{"key": "json data"}' $KV/key/$UUID/some-data
$ curl -X PUT -H "Content-Type: application/json"  -d '{"key": "other data"}' $KV/key/$UUID/some-other-data
Returns: HTTP 200, ok
```

List keys
----------
```
$ curl $KV/key/$UUID
Returns: HTTP 200, ["some-data", "some-other-data"] or []
```

Get
---
```
$ curl $KV/key/$UUID/some-data
Returns: HTTP 200, {"key": "json data"}
```
```
$ curl $KV/key/$UUID/some-missing-key
Returns: HTTP 404, not found
```

Delete
------
```
$ curl -X DELETE $KV/key/$UUID/some-data
$ curl -X DELETE $KV/key/$UUID
Returns: HTTP 200, ok 
```

Readme Alias
------------
Create an UUID alias only for reading (write and delete take no effect)
```
$ ALIAS = `curl $KV/alias/$UUID`
$ curl $KV/key/$ALIAS/some-data
```

CORS Support
============

Each OPTION request returns response with headers set:
```
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Access-Control-Allow-Methods: VALUE_OF(Access-Control-Request-Method)
Access-Control-Allow-Headers: VALUE_OF(Access-Control-Request-Headers)
```

Therefore allowing use from everywhere.

Closing words
=============

Public beta available at: http://kv.jamhed.tk
