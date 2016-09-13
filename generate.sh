#!/bin/bash
HASH=sha256
BITS=2048
SITE=$1

if [[ "$SITE" == "" ]]; then
	echo "Usage: generate.sh <sitename>"
	echo ""
	echo "Generates a Certificate Signing Request and Private Key"
	echo ""
	echo "Puts the CSR and Private Key at ./sites/<sitename>"
	exit;
fi

mkdir ./sites/$SITE

# Generate a private key
openssl genrsa -out ./sites/$SITE/$SITE.key.pem $BITS

openssl req -config sites/openssl.conf -key ./sites/$SITE/$SITE.key.pem -new -$HASH -out ./sites/$SITE/$SITE.csr.pem
