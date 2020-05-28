# RPI HashiCorp Stack


This repository contains Packer templates and scripts to build Raspbian images with different HashiCorp tools like Consul, Nomad or Vault pre-installed.

[Consul](https://www.consul.io/) is a distributed, highly-available tool that you can use for service discovery and key/value storage. A Consul cluster typically includes a small number of server nodes, and a larger number of client nodes, which you typically run alongside your apps.

[Nomad](https://www.nomadproject.io/) is a distributed, highly-available data-center aware scheduler. A Nomad cluster typically includes a small number of server nodes, and a larger number of client nodes, which are used for running jobs.

[Vault](https://www.vaultproject.io/) is an open source tool for managing secrets and protecting sensitive data.

This setup includes the following images:

- __rpi-consul.img__: a Raspbian image with Consul installed as a systemd service

- __rpi-vault.img__: a Raspbian image with Consul and Vault installed as systemd services

- __rpi-nomad.img__: a Raspian image with Consul and Nomad installed as a systemd service

- __rpi-nomad-client.img__: same as previous image, but with extra software like Docker and a JDK

- __rpi-hashi-stack.img__: a Raspbian image with Consul, Vault and Nomad installed as systemd services

- __rpi-hashi-stack-ext.img__: same as previous image, but with extra software like Docker and a JDK

## Building the images

This project includes a Vagrant file and some scripts to build the images in an isolated environment.

To use the Vagrant environment, start by cloning this repository:

```
git clone https://github.com/jsiebens/rpi-hashi-cluster
```

Next, start the Vagrant box and ssh into it:

```
vagrant up
vagrant ssh
```

When connected with the Vagrant box, run `make` in the `/vagrant` directory:

```
cd /vagrant
make
```

<a href="https://asciinema.org/a/Cs6xArNOR1V66mNvcLTbhWVmh"><img src="https://asciinema.org/a/Cs6xArNOR1V66mNvcLTbhWVmh.svg" width="600"/></a>