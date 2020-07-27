#!/bin/sh

for f in *.xz; do shasum -a 256 $f > $f.sha256; done