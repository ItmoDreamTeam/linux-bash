#!/bin/bash

# Download package
mkdir -p ./tmp
yum install --downloadonly --downloaddir=./tmp rsync

# View content with mc
mc ./tmp

# Or with the following command
rpm2cpio ./tmp/*.rpm | cpio -t
