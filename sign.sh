#!/bin/bash
DAYS=375
HASH=sha256
SITE=$1
echo $SITE

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

if [[ "$SITE" == "" ]]; then
	echo "Usage: sign.sh <sitename>"
	echo ""
	echo "Signs a Certificate Signing Request"
	echo ""
	echo "The CSR must be located at $SITES_DIR/<sitename>/<sitename>.csr.pem"
	echo "Creates a certificate at $SITES_DIR/<sitename>/<sitename>.cert.pem"
	exit;
fi

openssl ca -config $CA_DIR/openssl.conf -extensions server_cert -days $DAYS -notext -md $HASH -in $SITES_DIR/$SITE/$SITE.csr.pem -out $SITES_DIR/$SITE/$SITE.cert.pem

