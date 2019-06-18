#!/bin/sh

set -ex

apk add --update curl

sleep 3

set -o pipefail

curl -fL http://app:8080/ | grep "background-color: ${COLOR}"
