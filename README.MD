## 1. Register IoT CA certificate



https://github.com/aws-samples/aws-iot-jitp-sample-scripts/blob/master/bin/register-ca
```
$ export AWS_ACCOUNT=<your_account>
```

```
$ chmod +x ./script/create-role.sh
$ chmod +x ./script/create-ca.sh
$ chmod +x ./script/register-ca.sh
$ chmod +x ./script/provision.sh
$ chmod +x ./script/pub.sh
$ chmod +x ./script/sub.sh
$ chmod +x ./script/delete-thing.sh
$ chmod +x ./script/cleanup.sh
```

```
$ ./script/create-role.sh
```

```
$ ./script/create-ca.sh
```

```
$ ./script/register-ca.sh
```

```
$ ./script/provision.sh d01
$ ./script/provision.sh s01
```

```
$ openssl x509 -noout -serial -in ./tmp/d01.crt
$ openssl x509 -noout -subject -in ./tmp/d01.crt
$ openssl x509 -noout -serial -in ./tmp/s01.crt
$ openssl x509 -noout -subject -in ./tmp/s01.crt
```

```
$ ./script/sub.sh s01
```

```
$ ./script/pub.sh d01 "hello from d01"
```

```
$ ./script/delete-thing.sh d01
$ ./script/delete-thing.sh s01
```

```
$ ./script/cleanup.sh
```
