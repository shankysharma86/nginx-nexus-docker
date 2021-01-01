# ............................... DISCLAIMER ............................ #
#
#These scripts come without warranty of any kind. Use them at your own risk. 
#I assume no liability for the accuracy, correctness, completeness, or usefulness
#of any information provided by this script nor for any sort of damages using 
#these scripts may cause.
# ....................................................................... #

#!/bin/bash

# Generate Root Key rootCA.key with 2048
openssl genrsa -passout pass:"$1" -des3 -out ../certs/rootCA.key 2048

# Generate Root PEM (rootCA.pem) with 1024 days validity.
openssl req -passin pass:"$1" -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=Local Certificate"  -x509 -new -nodes -key ../certs/rootCA.key -sha256 -days 1024 -out ../certs/rootCA.pem

# Add root cert as trusted cert
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        yum -y install ca-certificates
        update-ca-trust force-enable
        cp ../certs/rootCA.pem /etc/pki/ca-trust/source/anchors/
        update-ca-trust
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ../certs/rootCA.pem
else
        # Unknown.
        echo "Couldn't find desired Operating System. Exiting Now ......"
        exit 1
fi


# Generate nexus Cert
openssl req -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost"  -new -sha256 -nodes -out ../certs/nexus.csr -newkey rsa:2048 -keyout ../certs/nexuskey.pem
openssl x509 -req -passin pass:"$1" -in ../certs/nexus.csr -CA ../certs/rootCA.pem -CAkey ../certs/rootCA.key -CAcreateserial -out ../certs/nexuscert.crt -days 500 -sha256 -extfile  <(printf "subjectAltName=DNS:localhost,DNS:nexus-repo")

# Create certs directory
mkdir ../certs

cd ../nginx/
echo $PWD

# Making Build Context for Dockerfile
cp ../certs/nexuscert.crt nexuscert.crt
cp ../certs/nexuskey.pem nexuskey.pem

# Docker build nginx image
docker build --no-cache -t nginx-nexusproxy .

cd ../
echo $PWD

# Run nginx and nexus containers
docker-compose up -d
