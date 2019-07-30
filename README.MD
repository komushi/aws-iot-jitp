## 1. Preparation




```
$ export AWS_ACCOUNT=<your_account>
```



## 2. v1
https://github.com/aws-samples/aws-iot-jitp-sample-scripts/blob/master/bin/register-ca

```
$ chmod +x ./script/v1/create-role.sh
$ chmod +x ./script/v1/create-ca.sh
$ chmod +x ./script/v1/register-ca.sh
$ chmod +x ./script/v1/provision.sh
$ chmod +x ./script/v1/pub.sh
$ chmod +x ./script/v1/sub.sh
$ chmod +x ./script/v1/delete-thing.sh
$ chmod +x ./script/v1/cleanup.sh
```

```
$ ./script/v1/create-role.sh
```

```
$ ./script/v1/create-ca.sh
```

```
$ ./script/v1/register-ca.sh
```

```
$ ./script/v1/provision.sh d01
$ ./script/v1/provision.sh s01
```

```
$ openssl x509 -noout -serial -in ./tmp/d01.crt
$ openssl x509 -noout -subject -in ./tmp/d01.crt
$ openssl x509 -noout -serial -in ./tmp/s01.crt
$ openssl x509 -noout -subject -in ./tmp/s01.crt
```

```
$ ./script/v1/sub.sh s01
```

```
$ ./script/v1/pub.sh d01 "hello from d01"
```

```
$ ./script/v1/delete-thing.sh d01
$ ./script/v1/delete-thing.sh s01
```

```
$ ./script/v1/cleanup.sh
```

## 3. v2
https://qiita.com/keni-chi/items/f2df7fa0fc6c2b5e0df4

```
```
$ chmod +x ./script/v2/create-role.sh
$ chmod +x ./script/v2/create-ca.sh
$ chmod +x ./script/v2/register-ca.sh
$ chmod +x ./script/v2/provision.sh
$ chmod +x ./script/v2/pub.sh
$ chmod +x ./script/v2/sub.sh
$ chmod +x ./script/v2/delete-thing.sh
$ chmod +x ./script/v2/cleanup.sh
```

```

```
$ ./script/v2/create-role.sh
```

```
$ ./script/v2/create-ca.sh
```

```
$ ./script/v2/register-ca.sh
```

```
$ ./script/v2/provisionv2.sh d01
$ ./script/v2/provisionv2.sh s01
```

```
$ openssl x509 -noout -serial -in ./tmp/d01.crt
$ openssl x509 -noout -subject -in ./tmp/d01.crt
$ openssl x509 -noout -serial -in ./tmp/s01.crt
$ openssl x509 -noout -subject -in ./tmp/s01.crt
```

```
$ ./script/v2/sub.sh s01
```

```
$ ./script/v2/pub.sh d01 "hello from d01"
```

```
$ ./script/v2/delete-thing.sh d01
$ ./script/v2/delete-thing.sh s01
```

```
$ ./script/v2/cleanup.sh
```

-------

```
fields @timestamp, eventType, logLevel, clientId, status
| sort @timestamp desc
| limit 20
| filter eventType like "Connect" or eventType like "Disconnect"

```