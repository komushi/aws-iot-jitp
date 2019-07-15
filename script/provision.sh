#!/bin/bash
#
# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

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

endpoint=$(aws iot describe-endpoint --endpoint-type iot:Data-ATS | jq -r .endpointAddress )

mosquitto_pub --cafile certs/AmazonRootCA1.pem --cert tmp/$DEVICE.crt --key tmp/$DEVICE.key \
	-h $endpoint -p 8883 -q 0 -i $DEVICE -d --tls-version tlsv1.2 -m '' -t '/register'
mosquitto_pub --cafile certs/AmazonRootCA1.pem --cert tmp/$DEVICE.crt --key tmp/$DEVICE.key \
	-h $endpoint -p 8883 -q 0 -i $DEVICE -d --tls-version tlsv1.2 -m '' -t '/register'
