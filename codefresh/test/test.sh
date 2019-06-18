#!/bin/sh

set -ex

apk add --update curl

sleep 3

curl -fL http://app:8080/
