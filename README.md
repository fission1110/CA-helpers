This is a collection of quick and dirty certificate authority scripts for running your own CA with openssl.
This is largely based on the guide at https://jamielinux.com/docs/openssl-certificate-authority/index.html

[ GETTING STARTED ]
Before starting you should update the CRL location inside of ./openssl-intermediate.conf

By default it looks like this:
	crlDistributionPoints = URI:http://10.131.40.99/intermediate.crl.pem

[ DIRECTORIES AND FILES ]

./ca-chain.cert.pem is the certificate authority chain. Upload this to your browser/server/client so the CA will be accepted.

./root/ is the root certificate authority. The root certificate is self signed and has permission to sign other certificate authoritys and site certificates

./intermeidate/ is the intermediate certificate authority. This CA is signed by the root CA and can sign certificates

./sites/ are where all of your signed certificates live

OCSP not yet implimented

[ QUICKSTART ]

Run ./kitchen_sink.sh to generate a root CA, generate an intermediate CA then generate a server certificate
