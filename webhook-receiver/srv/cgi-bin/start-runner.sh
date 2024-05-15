#!/bin/bash

. /etc/profile
docker run --rm -d -e GITHUB_TOKEN=$GITHUB_TOKEN -e ORGANIZATION=$ORGANIZATION -e REPO=$REPO github-runner-ubuntu:latest

echo "Content-Type: text/html"
echo "<html><body>Success</body></html>"

