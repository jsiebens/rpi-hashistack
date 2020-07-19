#!/bin/bash
set -euo pipefail

ARCH=$(uname -m)
case $ARCH in
    amd64)
        SUFFIX=amd64
        CHECKSUM="2caa61620df32b4a2ef7f7a86a11a512056c1ab6"
        ;;
    x86_64)
        SUFFIX=amd64
        CHECKSUM="2caa61620df32b4a2ef7f7a86a11a512056c1ab6"
        ;;
    arm64)
        SUFFIX=aarch64
        CHECKSUM="c09ca894b6d2a9633234d767908a1374adfd5831"
        ;;
    aarch64)
        SUFFIX=aarch64
        CHECKSUM="c09ca894b6d2a9633234d767908a1374adfd5831"
        ;;
    arm*)
        SUFFIX=arm32-vfp-hflt
        CHECKSUM="830f69924fcb8f58b7054d3da47ebff3ab5c79ad"
        ;;
    *)
        echo "Unsupported architecture $ARCH"
        exit 1
esac

URL="https://download.bell-sw.com/java/11.0.8+10/bellsoft-jdk11.0.8+10-linux-${SUFFIX}-lite.deb"

echo "Fetching Bellsoft JDK 11 ..."
curl -s -L -o /tmp/bellsoft.deb ${URL}

echo "Verifiying Bellsoft JDK 11 download ..."
echo "${CHECKSUM} /tmp/bellsoft.deb" | sha1sum --check

echo "Installing Bellsoft JDK 11 ..."
apt-get install /tmp/bellsoft.deb -y
rm /tmp/bellsoft.deb
