#!/bin/sh

##########################################################################
# The MIT License
#
# Copyright (c) engeir
#
# Permission is hereby granted, free of charge,
# to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to
# deal in the Software without restriction, including
# without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom
# the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice
# shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
# ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##########################################################################

#
# Description: Create file used in the CESM2 that works with the INTERP_MISSING_MONTHS mode,
# from a file meant to be run in CYCLE mode.
#
# Dependencies: NCO - http://research.jisao.washington.edu/data_sets/nco/
#               reset_date_variable.py - https://github.com/engeir/cesm2-volcano-setup/blob/main/cyclic2interp/reset_date_variable.py
#
# Usage:
#   1. Run with some netCDF file as the first argument
#     `./cycle2interp.sh in.nc`
#
# Needs a python environment with the netcdf4 package installed, and the NCO command line
# tools.
#
# Shell: POSIX compliant
# Author: Eirik R. Enger
#

if ! command -v ncks >/dev/null 2>&1; then
    echo "Cannot access NCO commands"
    exit 1
fi

ncks -d time,'1850-1-1 0:00:0.0','1851-1-1 0:00:0.0' "$1" 1850.nc

ncap2 -s 'time=time+(1-1850)*365' 1850.nc 1.nc
ncap2 -s 'time=time+(9999-1850)*365' 1850.nc 9999.nc

if ncdump -h "$1" | grep 'time = UNLIMITED' >/dev/null 2>&1; then
    cp 1.nc 1_un.nc
    cp 9999.nc 9999_un.nc
else
    ncks --mk_rec_dmn time 1.nc 1_un.nc
    ncks --mk_rec_dmn time 9999.nc 9999_un.nc
fi
  
# Make a backup and save to the original name.
mv "$1" "$1".bak
ncrcat -h 1_un.nc 9999_un.nc "$1"

echo "$1" | reset_date_variable.py

# Clean up
rm 1850.nc 1.nc 9999.nc 1_un.nc 9999_un.nc
