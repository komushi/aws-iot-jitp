#!/bin/bash

THING=$1

CERTARN=$(aws iot list-thing-principals --thing-name $THING | jq -r '.["principals"] | .[] ')
CERTID=$(expr "$CERTARN" : '.*/\(.*\)')

if [[ -z "$CERTARN" ]]; then
	echo "Failed to find device"
	exit
fi

echo "Found $CERTARN"
echo "Found $CERTID"

aws iot detach-policy --policy-name IoTJitpAccess --target $CERTARN

aws iot update-certificate --certificate-id $CERTID --new-status INACTIVE

aws iot detach-thing-principal --thing-name $THING --principal $CERTARN

aws iot delete-certificate --certificate-id $CERTID

aws iot delete-thing --thing-name $THING
