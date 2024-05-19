openssl ecparam -genkey -name secp384r1 -out rootCA.key
openssl req -new -key rootCA.key -out rootCA.req -nodes -config root_request.config
touch index
echo 01 > serial.txt
openssl ca -out rootCA.pem -keyfile rootCA.key -selfsign -config root_certificate.config  -in rootCA.req
openssl x509 -noout -text -in rootCA.pem
openssl ecparam -genkey -name secp384r1 -out server.key
openssl req -new -sha512 -nodes -key server.key -out server.csr -config server_request.config
openssl x509 -req -sha512 -days 365 -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.pem -extfile server_cert.config
openssl verify -verbose -CAfile rootCA.pem server.pem

