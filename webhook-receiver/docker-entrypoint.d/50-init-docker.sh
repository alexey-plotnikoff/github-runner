#!/bin/bash

usermod -aG docker www-data
chown root:docker /var/run/docker.sock
