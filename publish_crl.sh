CRL_LOCATION=/var/www/intermediate.crl.pem

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

echo "Copything CRL to $CRL_LOCATION"

cp $CA_DIR/crl/intermediate.crl.pem $CRL_LOCATION
