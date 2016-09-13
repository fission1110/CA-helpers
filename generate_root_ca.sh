# Turn this on to encrypt RSA key (recommended)
#ENCRYPT=-aes256
BITS=4096
DAYS=7300
DIGEST=sha256

# Note, if you change any of these, you'll have to update them in the openssl.conf's
CA_DIR=./intermediate
ROOT_DIR=./root
SITES_DIR=./sites

# This file generates a root certificate authority and puts it in ./root

mkdir $ROOT_DIR/
mkdir $ROOT_DIR/keys/
mkdir $ROOT_DIR/certs/
mkdir $ROOT_DIR/newcerts/
touch $ROOT_DIR/index.txt
echo 1000 > $ROOT_DIR/serial

cp ./openssl-root.conf $ROOT_DIR/openssl.conf

#Generate private key
openssl genrsa $ENCRYPT -out $ROOT_DIR/keys/ca.key.pem $BITS

# Self-Sign the cert
openssl req -config $ROOT_DIR/openssl.conf \
	-key $ROOT_DIR/keys/ca.key.pem \
	-new -x509 -days $DAYS -$DIGEST -extensions v3_ca \
	-out $ROOT_DIR/certs/ca.cert.pem

#Verify the root cert
openssl x509 -noout -text -in $ROOT_DIR/certs/ca.cert.pem
