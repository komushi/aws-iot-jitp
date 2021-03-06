#!/bin/bash
thingName=$1
TOPIC=${2:-'#'}

if [[ -z "$thingName" ]]; then
	echo "Usage: $0 thing [ topic ]"
	exit
fi

echo "$thingName subscribing to $TOPIC"

endpoint=$(aws iot describe-endpoint --endpoint-type iot:Data-ATS | jq -r .endpointAddress )

if [[ -z "$endpoint" ]]; then
	echo "Could not discover AWS IoT Endpoint"
	exit
fi

echo "Connecting $thingName to $endpoint"
mosquitto_sub -v --cafile certs/AmazonRootCA1.pem --cert tmp/$thingName.crt --key tmp/$thingName.key -h $endpoint -p 8883 -q 0 -t '#' -i $thingName -d --tls-version tlsv1.2
