---
title: JSON WEB TOKEN
date: 2016-10-31 15:58:04
categories: "Web"
tags:
     - Nodejs
     - JWT
     - Token
---

## JSONWebToken API

An implementation of JSON Web Tokens.This was developed against draft-ietf-oauth-json-web-token-08. It makes use of {% link node-jws https://github.com/xulayen/node-jsonwebtoken %}.


### 安装

``` bash

$ npm install jsonwebtoken

```

### 版本迁移

{% link From v7 to v8 https://github.com/xulayen/node-jsonwebtoken/wiki/Migration-Notes:-v7-to-v8 %}

<!-- more -->

### 用法API

``` bash

jwt.sign(payload, secretOrPrivateKey, [options, callback])

```



{% blockquote @Auth0 https://github.com/xulayen/node-jsonwebtoken %}

    (Asynchronous) If a callback is supplied, the callback is called with the err or the JWT.

    (Synchronous) Returns the JsonWebToken as string

    payload could be an object literal, buffer or string. Please note that exp is only set if the payload is an object literal.

    secretOrPrivateKey is a string, buffer, or object containing either the secret for HMAC algorithms or the PEM encoded private key for RSA and ECDSA. In case of a private key with passphrase an object { key, passphrase } can be used (based on crypto documentation), in this case be sure you pass the algorithm option.

{% endblockquote %}



- sign with default (HMAC SHA256)


``` bash

    // sign with default (HMAC SHA256)
    var jwt = require('jsonwebtoken');
    var token = jwt.sign({ foo: 'bar' }, 'secret');
    console.log(token)

```

- sign with RSA SHA256

``` bash

    // sign with RSA SHA256
    var cert = fs.readFileSync('private.key');  // get private key
    var token = jwt.sign({ foo: 'bar' }, cert, { algorithm: 'RS256'});

    // sign asynchronously
    jwt.sign({ foo: 'bar' }, cert, { algorithm: 'RS256' }, function(err, token) {
      console.log(token);
    });

```

### TOKEN失效

{% blockquote @Auth0 https://github.com/xulayen/node-jsonwebtoken %}

The standard for JWT defines an exp claim for expiration. The expiration is represented as a NumericDate:
A JSON numeric value representing the number of seconds from 1970-01-01T00:00:00Z UTC until the specified UTC date/time, ignoring leap seconds. This is equivalent to the IEEE Std 1003.1, 2013 Edition [POSIX.1] definition "Seconds Since the Epoch", in which each day is accounted for by exactly 86400 seconds, other than that non-integer values can be represented. See RFC 3339 [RFC3339] for details regarding date/times in general and UTC in particular.
This means that the exp field should contain the number of seconds since the epoch.

{% endblockquote %}

- 产生一个token1小时后失效：
``` bash

    jwt.sign({
      exp: Math.floor(Date.now() / 1000) + (60 * 60),
      data: 'foobar'
    }, 'secret');

```
- 另外一个方式产生token并且有失效机制
``` bash

jwt.sign({
  data: 'foobar'
}, 'secret', { expiresIn: 60 * 60 });

//or even better:

jwt.sign({
  data: 'foobar'
}, 'secret', { expiresIn: '1h' });

```


### 验证token

token是一个JsonWebToken字符窜

{% blockquote @Auth0 https://github.com/xulayen/node-jsonwebtoken %}

   (Asynchronous) If a callback is supplied, function acts asynchronously. The callback is called with the decoded payload if the signature is valid and optional expiration, audience, or issuer are valid. If not, it will be called with the error.

   (Synchronous) If a callback is not supplied, function acts synchronously. Returns the payload decoded if the signature is valid and optional expiration, audience, or issuer are valid. If not, it will throw the error.

{% endblockquote %}

`secretOrPublicKey`是一个字符窜或者`HMAC algorithms`缓冲区中的任何一个PEM编码了RSA和ECDSA的公钥。


``` bash

    //verify a token symmetric - synchronous
    var decoded = jwt.verify(token, 'secret');
    console.log(decoded.foo) // bar

    // verify a token symmetric
    jwt.verify(token, 'shhhhh', function(err, decoded) {
      console.log(decoded.foo) // bar
    });

    // invalid token - synchronous
    try {
      var decoded = jwt.verify(token, 'wrong-secret');
    } catch(err) {
      // err
    }

    // invalid token
    jwt.verify(token, 'wrong-secret', function(err, decoded) {
      // err
      // decoded undefined
    });

    // verify a token asymmetric
    var cert = fs.readFileSync('public.pem');  // get public key
    jwt.verify(token, cert, function(err, decoded) {
      console.log(decoded.foo) // bar
    });

    // verify audience
    var cert = fs.readFileSync('public.pem');  // get public key
    jwt.verify(token, cert, { audience: 'urn:foo' }, function(err, decoded) {
      // if audience mismatch, err == invalid audience
    });

    // verify issuer
    var cert = fs.readFileSync('public.pem');  // get public key
    jwt.verify(token, cert, { audience: 'urn:foo', issuer: 'urn:issuer' }, function(err, decoded) {
      // if issuer mismatch, err == invalid issuer
    });

    // verify jwt id
    var cert = fs.readFileSync('public.pem');  // get public key
    jwt.verify(token, cert, { audience: 'urn:foo', issuer: 'urn:issuer', jwtid: 'jwtid' }, function(err, decoded) {
      // if jwt id mismatch, err == invalid jwt id
    });

    // verify subject
    var cert = fs.readFileSync('public.pem');  // get public key
    jwt.verify(token, cert, { audience: 'urn:foo', issuer: 'urn:issuer', jwtid: 'jwtid', subject: 'subject' }, function(err, decoded) {
      // if subject mismatch, err == invalid subject
    });

    // alg mismatch
    var cert = fs.readFileSync('public.pem'); // get public key
    jwt.verify(token, cert, { algorithms: ['RS256'] }, function (err, payload) {
      // if token alg != RS256,  err == invalid signature
    });

```


### 解码token

``` bash

jwt.decode(token [, options])

```

* token is the JsonWebToken string

* options:

* json: force JSON.parse on the payload even if the header does not contain "typ":"JWT".
* complete: return an object with the decoded payload and header.

Example


``` bash

// get the decoded payload ignoring signature, no secretOrPrivateKey needed
var decoded = jwt.decode(token);

// get the decoded payload and header
var decoded = jwt.decode(token, {complete: true});
console.log(decoded.header);
console.log(decoded.payload)

```


### token失效异常

#### TokenExpiredError

- Thrown error if the token is expired.
- Error object:
    * name: 'TokenExpiredError'
    * message: 'jwt expired'
    * expiredAt: [ExpDate]



``` bash

jwt.verify(token, 'wrongsecret', function(err, decoded) {
  if (err) {
    /*
      err = {
        name: 'TokenExpiredError',
        message: 'jwt expired',
        expiredAt: 1408621000
      }
    */
  }
});

```


#### JsonWebTokenError

- Error object:
    * name: JsonWebTokenError
    * message:
        * 'jwt malformed'
        * 'jwt signature is required'
        * 'invalid signature'
        * 'jwt audience invalid. expected: [OPTIONS AUDIENCE]'
        * 'jwt issuer invalid. expected: [OPTIONS ISSUER]'
        * 'jwt id invalid. expected: [OPTIONS JWT ID]'
        * 'jwt subject invalid. expected: [OPTIONS SUBJECT]'


``` bash

jwt.verify(token, 'woringsecret', function(err, decoded) {
  if (err) {
    /*
      err = {
        name: 'JsonWebTokenError',
        message: 'jwt malformed'
      }
    */
  }
});

```