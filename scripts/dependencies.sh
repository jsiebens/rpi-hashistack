#!/bin/bash
set -e

apt-get -y update 
apt-get -y install -y curl unzip

mkdir /tmp/keyring
chmod 700 /tmp/keyring

curl -s https://keybase.io/hashicorp/pgp_keys.asc | gpg --import --homedir /tmp/keyring