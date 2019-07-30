#!/bin/bash
CA=${1:-root}

if [[ -z "$AWS_ACCOUNT" ]]; then
	echo "Please set the AWS_ACCOUNT environment variable"
	exit
fi

mkdir -p tmp
SUB=`aws iot get-registration-code | jq -r '.["registrationCode"]'`
openssl req -new -key "tmp/$CA.ca.key" -out tmp/verificationCert.csr -subj "/CN=$SUB"
openssl x509 -req -in tmp/verificationCert.csr -CA "tmp/$CA.ca.pem" -CAkey "tmp/$CA.ca.key" -CAcreateserial -out tmp/verificationCert.pem -days 500 -sha256
mkdir -p tmp
sed "s%\${AWS_ACCOUNT}%$AWS_ACCOUNT%" config/reg_ca_template.json  > tmp/reg_ca.json
aws iot register-ca-certificate --ca-certificate "file://tmp/$CA.ca.pem" --verification-cert file://tmp/verificationCert.pem --set-as-active  --allow-auto-registration --registration-config file://tmp/reg_ca.json > tmp/ca_output.json

# SUB=`aws iot get-registration-code | jq -r '.["registrationCode"]'`
# openssl genrsa -out verificationCert.key 2048
# openssl req -new -key verificationCert.key -out verificationCert.csr -subj "/CN=$SUB"
# openssl x509 -req -in verificationCert.csr -CA "$CA.ca.pem" -CAkey "$CA.ca.key" -CAcreateserial -out verificationCert.pem -days 500 -sha256
# mkdir -p tmp
# sed "s%\${AWS_ACCOUNT}%$AWS_ACCOUNT%" config/reg_ca_template.json  > tmp/reg_ca.json
# aws iot register-ca-certificate --ca-certificate "file://$CA.ca.pem" --verification-cert file://verificationCert.pem --set-as-active  --allow-auto-registration --registration-config file://tmp/reg_ca.json
