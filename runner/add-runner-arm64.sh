#!/bin/bash

# Create the runner and start the configuration experience
TOKEN=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/alexey-plotnikoff/sport-forge/actions/runners/registration-token | jq -r '.token')

./config.sh --url https://github.com/alexey-plotnikoff/sport-forge --token ${TOKEN} --ephemeral --labels macbook --unattended --disableupdate
# Last step, run it!
./run.sh
