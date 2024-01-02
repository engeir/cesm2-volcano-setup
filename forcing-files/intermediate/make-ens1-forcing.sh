#!/bin/bash

# This script assumes the python CLI `volcano-cooking` is installed. The current
# installed version is
#   $ volcano-cooking --version
#   0.9.2

if [[ $(volcano-cooking --version) != "volcano-cooking, version 0.9.2" ]]; then
    echo "This is not the correct volcano-cooking version, mate."
    exit 1
fi

# Original
volcano-cooking --file "./ens1-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-ens1
mv source-files source-files-ens1
NC=$(ls ./source-files-ens1/synth*nc)
# Ens 2
volcano-cooking -init 1850 -init 5 -init 15 --shift-eruption-to-date "$NC"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-ens2
mv source-files source-files-ens2
# Ens 3
volcano-cooking -init 1850 -init 8 -init 15 --shift-eruption-to-date "$NC"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-ens3
mv source-files source-files-ens3
# Ens 4
volcano-cooking -init 1850 -init 11 -init 15 --shift-eruption-to-date "$NC"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-ens4
mv source-files source-files-ens4
# Ens 5
volcano-cooking -init 1851 -init 2 -init 15 --shift-eruption-to-date "$NC"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-ens5
mv source-files source-files-ens5
