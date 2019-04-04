#!/usr/bin/env bash

docker build -t quay.io/hdaems/ignite-node:latest .

docker push quay.io/hdaems/ignite-node:latest
