# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
