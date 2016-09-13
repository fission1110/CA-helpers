#!/bin/bash
DAYS=375
HASH=sha256
SITE=$1

if [[ "$SITE" == "" ]]; then
	echo "Usage: sign.sh <sitename>"
	echo ""
	echo "Revokes a certificate and updates the CRL on the webserver"
	echo ""
	echo "Run ./publish_crl.sh to update the CRL on the webserver"
	exit;
fi

openssl ca -config intermediate/openssl.conf \
	-revoke sites/$SITE/$SITE.cert.pem

openssl ca -config intermediate/openssl.conf \
	-gencrl -out intermediate/crl/intermediate.crl.pem

