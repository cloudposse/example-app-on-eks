#!/bin/sh

set -ex

apk add --update curl

/app/example-app&

sleep 3

set -o pipefail


curl -fsSL http://app:8080/ | grep "background-color: ${COLOR}"

exit 1
