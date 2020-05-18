#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "Installing Docker ..."
curl -sSL https://get.docker.com | sh

echo "============================= Docker installation done"
