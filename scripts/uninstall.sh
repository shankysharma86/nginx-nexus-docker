cd ../certs/

rm -f nexuscert.crt nexuskey.pem nexus.csr rootCA.key rootCA.pem rootCA.srl

cd ../nginx/

rm -f nexuscert.crt nexuskey.pem

cd ../

docker-compose down

docker rmi nginx-nexusproxy
