#!/bin/bash

mkdir -p tmp
aws iam create-role --role-name IoTJitpProvisioning --assume-role-policy-document file://config/iot_provision_assume_role_policy.json
aws iam put-role-policy --role-name IoTJitpProvisioning --policy-name IoTJitpProvisioningPolicy --policy-document file://config/iot_provision_role_policy.json
sed "s%\${AWS::AccountId}%$AWS_ACCOUNT%" config/iot_access_policy_template.json  > tmp/iot_access_policy.json
aws iot create-policy --policy-name IoTJitpAccess --policy-document file://tmp/iot_access_policy.json > tmp/iot_policy_output.json