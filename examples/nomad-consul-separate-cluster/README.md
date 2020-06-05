# Nomad and Consul separated Cluster

This tutorial explains how the build a Nomad cluster that connects to a separate Consul cluster on Raspberry Pi devices.
The Nomad cluster consists of two groups: one with 3 instances running the Nomad service nodes, and a second one with a number of Nomad client nodes, which are used to run jobs.

## Prerequisites

- the pre-built images
- 9 Raspberry Pi devices
- 9 SD cards
- [flash](https://github.com/hypriot/flash) utility

> This tutorial relies heavily on the usage of _flash_, because it allows you to write the images to an SD card and customize it's user-data and a hostname with a single command. If you rather use a different tool, make sure you write the correct user-data and hostname on each SD card.


## Quickstart

1. `git clone` this repository

2. download or build the images

3. review the user-data examples and adjust if required

4. write the images to SD cards and customize the user-data

_Consul servers_

```
flash --hostname consul-svr-1 --user-data examples/nomad-consul-separated-cluster/consul-server.yaml dist/rpi-consul.img
flash --hostname consul-svr-2 --user-data examples/nomad-consul-separated-cluster/consul-server.yaml dist/rpi-consul.img
flash --hostname consul-svr-3 --user-data examples/nomad-consul-separated-cluster/consul-server.yaml dist/rpi-consul.img
```

_Nomad servers_

```
flash --hostname nomad-svr-1 --user-data examples/nomad-consul-separated-cluster/nomad-server.yaml dist/rpi-nomad.img
flash --hostname nomad-svr-2 --user-data examples/nomad-consul-separated-cluster/nomad-server.yaml dist/rpi-nomad.img
flash --hostname nomad-svr-3 --user-data examples/nomad-consul-separated-cluster/nomad-server.yaml dist/rpi-nomad.img
```

_Nomad clients_

```
flash --hostname nomad-clt-1 --user-data examples/nomad-consul-separated-cluster/nomad-client.yaml dist/rpi-nomad-client.img
flash --hostname nomad-clt-2 --user-data examples/nomad-consul-separated-cluster/nomad-client.yaml dist/rpi-nomad-client.img
flash --hostname nomad-clt-3 --user-data examples/nomad-consul-separated-cluster/nomad-client.yaml dist/rpi-nomad-client.img
```

5. put the SD cards in the Raspberry Pi devices

6. connect all devices to the same network and power up!
