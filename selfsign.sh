#!/bin/bash

BITS=2048
DAYS=375
SITE=$1
NOPASSWD=-nodes

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

if [[ "$SITE" == "" ]]; then
	echo "Usage: selfsign.sh <sitename>"
	echo ""
	echo "Generates a self signed certificate"
	exit;
fi
openssl req -x509 $NOPASSWD -newkey rsa:$BITS -keyout $SITES_DIR/$SITE/$SITE.key.pem -out $SITES_DIR/$SITE/$SITE.cert.pem -days $DAYS
