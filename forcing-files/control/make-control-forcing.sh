#!/bin/bash

# This script assumes the python CLI `volcano-cooking` installed. The current installed
# version is
#   $ volcano-cooking --version
#   0.9.1

if [[ $(volcano-cooking --version) != "volcano-cooking, version 0.9.2" ]]; then
    echo "This is not the correct volcano-cooking version"
    exit 1
fi

volcano-cooking --file "/media/een023/LaCie/een023/cesm/model-runs/ensemble-simulations/source-control-run/control-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
