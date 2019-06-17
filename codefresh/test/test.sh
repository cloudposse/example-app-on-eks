#!/usr/bin/env bash

set -ex

apk add curl

sleep 3

curl -fL http://localhost:8080/
