#!/bin/bash
set -e

#apt-get -y update 
apt-get -y install -y curl unzip

curl -sL get.hashi-up.dev | sh

hashi-up consul install \
    --local \
    --advertise-addr "{{ GetPrivateInterfaces | include \"type\" \"IP\" | attr \"address\" }}" \
    --client-addr "0.0.0.0" \
    --server \
    --skip-enable \
    --skip-start

hashi-up nomad install \
    --local \
    --address "0.0.0.0" \
    --server \
    --client \
    --skip-enable \
    --skip-start

cat /etc/nomad.d/nomad.hcl

hashi-up vault install \
    --local \
    --storage "consul" \
    --skip-enable \
    --skip-start
    
cat /etc/vault.d/vault.hcl