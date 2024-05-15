#!/bin/bash

. /etc/profile
docker run --rm -d -e GITHUB_TOKEN=$GITHUB_TOKEN github-runner-ubuntu:latest

echo "Content-type:text/text"
echo "Runner has been started successfully"

