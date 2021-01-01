# ............................... DISCLAIMER ............................ #
#
#These scripts come without warranty of any kind. Use them at your own risk.
#I assume no liability for the accuracy, correctness, completeness, or usefulness
#of any information provided by this script nor for any sort of damages using
#these scripts may cause.
# ....................................................................... #

cd ../certs/

rm -f nexuscert.crt nexuskey.pem nexus.csr rootCA.key rootCA.pem rootCA.srl

cd ../nginx/

rm -f nexuscert.crt nexuskey.pem

cd ../

docker-compose down

docker rmi nginx-nexusproxy
