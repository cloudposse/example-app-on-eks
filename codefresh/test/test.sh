#!/bin/sh

set -ex

apk add --update curl

sleep 3

curl -fL http://localhost:8080/
