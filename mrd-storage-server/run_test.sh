#! /bin/bash

set -euo pipefail

trap 'kill $(jobs -p)' EXIT

mrd-storage-server &

url_root="http://localhost:3333"

health_check_endpoint="${url_root}/v1/blobs?subject=123"
echo "Waiting for successful response from ${health_check_endpoint}"
for wait in {0..30}; do
  if [[ "$(curl -s -o /dev/null -m 1 -w '%{http_code}' "$health_check_endpoint")" == "200" ]]; then
    echo "Server ready"
    break
  fi
  if [ "$wait" == 30 ]; then
    echo "ERROR: could not reach server"
  fi
  echo "Waiting...$wait"
  sleep 1
done

content='This is my content'
curl --request POST \
  "${url_root}/v1/blobs/data?subject=123&session=mysession&name=NoiseCovariance" \
  --header 'content-type: text/plain' \
  --data "$content"

response_content=$(curl -s --request GET "${url_root}/v1/blobs/data/latest?subject=123&session=mysession&name=NoiseCovariance")

if [[ "${response_content}" != "${content}" ]]; then
    echo "ERROR: Did not get expected result from server. Response = ${response_content}"
    exit 1
fi
