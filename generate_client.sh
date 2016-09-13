#!/bin/bash
DAYS=375
HASH=sha256
BITS=2048
SITE=$1

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

if [[ "$SITE" == "" ]]; then
	echo "Usage: generate_client.sh <sitename>"
	echo ""
	echo "Generates a Client Certificate Signing Request and Private Key, then signs it with the Intermediate CA"
	exit;
fi

mkdir $SITES_DIR/$SITE

# Generate a private key
openssl genrsa -out $SITES_DIR/$SITE/$SITE.key.pem $BITS

openssl req -config $SITES_DIR/openssl.conf -key $SITES_DIR/$SITE/$SITE.key.pem -new -$HASH -out $SITES_DIR/$SITE/$SITE.csr.pem

openssl ca -config $CA_DIR/openssl.conf -extensions usr_cert -days $DAYS -notext -md $HASH -in $SITES_DIR/$SITE/$SITE.csr.pem -out $SITES_DIR/$SITE/$SITE.cert.pem

openssl pkcs12 -export -in $SITES_DIR/$SITE/$SITE.cert.pem -inkey $SITES_DIR/$SITE/$SITE.key.pem -out $SITES_DIR/$SITE/$SITE.cert.pfx
