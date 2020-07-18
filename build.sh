#!/bin/bash
set -e

if [ -z "$1" ]; then
  jq -s '.[0] * .[1]' packer/rpi-ubuntu64.json packer/provisioners.json | sudo -E packer build -parallel-builds=1 -
else
  jq -s '.[0] * .[1]' packer/rpi-ubuntu64.json packer/provisioners.json | sudo -E packer build -parallel-builds=1 -only=$1 -
fi