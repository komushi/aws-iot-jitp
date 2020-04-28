#!/bin/bash
thingName=$1
fileName=$2
topic=\$aws/things/$thingName/shadow/update


if [[ -z "$thingName" ]]; then
	echo "Usage: $0 thing message..."
	exit
fi

shift

endpoint=$(aws iot describe-endpoint --endpoint-type iot:Data-ATS | jq -r .endpointAddress )

if [[ -z "$endpoint" ]]; then
	echo "Could not discover AWS IoT Endpoint"
	exit
fi

echo "Connecting $topic to $endpoint"
mosquitto_pub -d --cafile certs/AmazonRootCA1.pem --cert tmp/$thingName.crt --key tmp/$thingName.key -h $endpoint -p 8883 -q 0 -i $thingName -t ${topic} --tls-version tlsv1.2 -f ${fileName}
