#!/bin/bash
set -e

if [ -z "$2" ]; then
  jq -s '.[0] * .[1]' packer/rpi-$1.json packer/provisioners.json | sudo -E packer build -parallel-builds=1 -
else
  jq -s '.[0] * .[1]' packer/rpi-$1.json packer/provisioners.json | sudo -E packer build -parallel-builds=1 -only=$2 -
fi