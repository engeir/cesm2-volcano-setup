#!/bin/bash

# This script assumes the python CLI `volcano-cooking` is installed. The current
# installed version is
#   $ volcano-cooking --version
#   0.12.2

if [[ $(volcano-cooking --version) != "volcano-cooking, version 0.12.2" ]]; then
    echo "This is not the correct volcano-cooking version, mate."
    exit 1
fi

# TT, 2 year, ens 2
volcano-cooking --file "./tt-2year-ens2-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tt-2year-ens2
mv source-files source-files-tt-2year-ens2
