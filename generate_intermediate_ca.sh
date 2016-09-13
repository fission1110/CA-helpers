# Turn this on to encrypt RSA key
#ENCRYPT=-aes256
BITS=4096
DAYS=3650
DIGEST=sha256

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

# This file generates a intermediate certificate authority and puts it in ./intermediate

mkdir $CA_DIR/
mkdir $CA_DIR/keys/
mkdir $CA_DIR/certs/
mkdir $CA_DIR/csr/
mkdir $CA_DIR/newcerts/
mkdir $CA_DIR/crl/
mkdir $SITES_DIR/
touch $CA_DIR/index.txt
echo 1000 > $CA_DIR/crlnumber
echo 1000 > $CA_DIR/serial

cp ./openssl-intermediate.conf $CA_DIR/openssl.conf
cp ./openssl-sites.conf $SITES_DIR/openssl.conf

#Generate the intermediate key
openssl genrsa $ENCRYPT \
	-out $CA_DIR/keys/intermediate.key.pem $BITS

#Generate the certifacte signing request
openssl req -config $CA_DIR/openssl.conf -new -$DIGEST \
	-key $CA_DIR/keys/intermediate.key.pem \
	-out $CA_DIR/csr/intermediate.csr.pem

#Sign the intermediate certificate with the root certificate
 openssl ca -config $ROOT_DIR/openssl.conf -extensions v3_intermediate_ca \
	-days $DAYS -notext -md $DIGEST \
	-in $CA_DIR/csr/intermediate.csr.pem \
	-out $CA_DIR/certs/intermediate.cert.pem

#Verify it worked!
openssl verify -CAfile $ROOT_DIR/certs/ca.cert.pem \
	$CA_DIR/certs/intermediate.cert.pem

#Generate a certificate chain NOTE: Order matters here
cat $CA_DIR/certs/intermediate.cert.pem $ROOT_DIR/certs/ca.cert.pem > ./ca-chain.cert.pem
