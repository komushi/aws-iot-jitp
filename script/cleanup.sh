#!/bin/bash
CID=`cat tmp/ca_output.json | jq -r '.certificateId'`
PARN=`cat tmp/iot_policy_output.json | jq -r '.policyName'`
aws iot update-ca-certificate --certificate-id ${CID} --new-status INACTIVE
aws iot delete-ca-certificate --certificate-id ${CID}

aws iot delete-policy --policy-name ${PARN}

aws iam delete-role-policy --role-name IoTJitpProvisioning --policy-name IoTJitpProvisioningPolicy
aws iam delete-role --role-name IoTJitpProvisioning

rm -rf ./tmp/

