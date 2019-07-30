#!/bin/bash
thingName=$1

if [[ -z "$thingName" ]]; then
	echo "Usage: $0 thing message..."
	exit
fi

shift
message="$@"

endpoint=$(aws iot describe-endpoint --endpoint-type iot:Data-ATS | jq -r .endpointAddress )

if [[ -z "$endpoint" ]]; then
	echo "Could not discover AWS IoT Endpoint"
	exit
fi

echo "Connecting $thingName to $endpoint"
mosquitto_pub -d --cafile certs/AmazonRootCA1.pem --cert tmp/$thingName.crt --key tmp/$thingName.key -h $endpoint -p 8883 -q 0 -t $thingName -i $thingName --tls-version tlsv1.2 -m "$message"
