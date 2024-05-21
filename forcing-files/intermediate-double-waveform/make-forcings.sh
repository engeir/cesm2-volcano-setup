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
# TT, 2 year, ens 4
volcano-cooking --file "./tt-2year-ens4-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tt-2year-ens4
mv source-files source-files-tt-2year-ens4
# TT, 4 year, ens 2
volcano-cooking --file "./tt-4year-ens2-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tt-4year-ens2
mv source-files source-files-tt-4year-ens2
# TT, 4 year, ens 4
volcano-cooking --file "./tt-4year-ens4-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tt-4year-ens4
mv source-files source-files-tt-4year-ens4
# TN, 2 year, ens 2
volcano-cooking --file "./tn-2year-ens2-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tn-2year-ens2
mv source-files source-files-tn-2year-ens2
# TN, 2 year, ens 4
volcano-cooking --file "./tn-2year-ens4-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-tn-2year-ens4
mv source-files source-files-tn-2year-ens4
# NN, 2 year, ens 2
volcano-cooking --file "./nn-2year-ens2-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-nn-2year-ens2
mv source-files source-files-nn-2year-ens2
# NN, 2 year, ens 4
volcano-cooking --file "./nn-2year-ens4-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-nn-2year-ens4
mv source-files source-files-nn-2year-ens4
# NN, 4 year, ens 2
volcano-cooking --file "./nn-4year-ens2-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-nn-4year-ens2
mv source-files source-files-nn-4year-ens2
# NN, 4 year, ens 4
volcano-cooking --file "./nn-4year-ens4-forcing.json"
volcano-cooking --run-ncl
volcano-cooking --package-last
rm -rf source-files-nn-4year-ens4
mv source-files source-files-nn-4year-ens4
