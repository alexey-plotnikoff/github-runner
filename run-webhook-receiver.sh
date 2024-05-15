#!/bin/bash

port="${1:-10000}"
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -p $port:80 -e GITHUB_TOKEN=$GITHUB_TOKEN --env-file env nginx-webhook-receiver