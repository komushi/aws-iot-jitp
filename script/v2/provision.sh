#!/bin/bash

DEVICE=$1
CA=${2:-root}

if [[ -z "$DEVICE" ]]; then
	echo "Usage: $0 deviceName [CA]"
	exit
fi

if [[ ! -f "tmp/$CA.ca.pem" ]]; then
	echo "Could not find certificate for tmp/$CA"
	exit
fi

openssl genrsa -out "tmp/$DEVICE.key" 2048
openssl req -new -key "tmp/$DEVICE.key" -out "tmp/$DEVICE.csr"  -subj "/CN=$DEVICE"
openssl x509 -req -in tmp/$DEVICE.csr -CA "tmp/$CA.ca.pem" -CAkey "tmp/$CA.ca.key" -CAcreateserial -out "tmp/$DEVICE.crt.tmp" -days 500 -sha256
cat "tmp/$DEVICE.crt.tmp" "tmp/$CA.ca.pem" > "tmp/$DEVICE.crt"
rm "tmp/$DEVICE.crt.tmp"
rm "tmp/$DEVICE.csr"

endpoint=$(aws iot describe-endpoint --endpoint-type iot:CredentialProvider | jq -r .endpointAddress)
role_alias='IoTJitpProvisioningRoleAlias'
url="https://$endpoint/role-aliases/$role_alias/credentials"

echo $url

curl -vvv --header "x-amzn-iot-thingname:$DEVICE" --cert ./tmp/$DEVICE.crt --key ./tmp/$DEVICE.key ${url}