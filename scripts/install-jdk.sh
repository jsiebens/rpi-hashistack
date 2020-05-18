#!/bin/bash
set -euo pipefail

URL="https://download.bell-sw.com/java/11.0.7+10/bellsoft-jdk11.0.7+10-linux-arm32-vfp-hflt-lite.deb"
CHECKSUM="FF42DA02EEA128C225CDC69822226E000D03F9F3"

echo "Fetching Bellsoft JDK 11 ..."
curl -s -L -o /tmp/bellsoft.deb ${URL}

echo "Verifiying Bellsoft JDK 11 download ..."
echo "${CHECKSUM} /tmp/bellsoft.deb" | sha1sum --check

echo "Installing Bellsoft JDK 11 ..."
apt-get install /tmp/bellsoft.deb -y
rm /tmp/bellsoft.deb
