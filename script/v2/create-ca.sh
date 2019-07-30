#!/bin/bash

CN=${1:-root}
COUNTRY=${2:-JP}
LOCATION=${3:-Japan}
STATE=${4:-Tokyo}
ORG=${5:-AWS}
ORGUNIT=${6:-Demo}

mkdir -p tmp
openssl genrsa -out "tmp/$CN.ca.key" 2048
openssl req -new -sha256 -key "tmp/$CN.ca.key" -nodes -out "tmp/$CN.ca.csr" -config ./config/rootCA_openssl.conf -subj "/CN=$CN/C=$COUNTRY/L=$LOCATION/ST=$STATE/O=$ORG/OU=$ORGUNIT"
openssl x509 -req -days 1024 -extfile ./config/rootCA_openssl.conf -extensions v3_ca -in "tmp/$CN.ca.csr" -signkey "tmp/$CN.ca.key" -out "tmp/$CN.ca.pem"

# original
# openssl genrsa -out "$CN.ca.key" 2048
# openssl req -x509 -new -nodes -key "$CN.ca.key" -sha256 -days 1024 -out "$CN.ca.pem"  -subj "/CN=$CN/C=$COUNTRY/L=$LOCATION/ST=$STATE/O=$ORG/OU=$ORGUNIT"

# how to fix basicConstraints
# https://stackoverflow.com/questions/50414315/the-ca-certificate-does-not-have-the-basicconstraints-extension-as-true
