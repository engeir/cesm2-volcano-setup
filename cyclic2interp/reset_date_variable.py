#!/bin/python

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
# Description: Re-write the year of the "date" variable of a netCDF file. The first
# 12 elements are set to year 1, the rest to year 9999.
#
# Dependencies: netCDF4 - https://pypi.org/project/netCDF4/
#
# Usage:
#   1. Run the script with the filename as stdin
#     `echo "in.nc" | reset_date_variable.py`
#
# Author: Eirik R. Enger
#

import os
import sys

import netCDF4 as nc


def rewrite_date_variable() -> None:
    # Check file path
    data = sys.stdin.readlines()
    new_path = data[0].strip("\n")
    if not isinstance(new_path, str) or new_path[-3:] != ".nc":
        raise TypeError(f"Are you sure {new_path} is a valid netCDF file?")
    if not os.path.exists(new_path):
        raise FileNotFoundError(f"Cannot find file named {new_path}.")

    # Open file
    with nc.Dataset(new_path, "r+") as ncfile:
        # Fix values
        for i, d in enumerate(ncfile.variables["date"][:]):
            n = 1 if i < 12 else 9999
            ncfile.variables["date"][i] = d % 10000 + n * 10000


if __name__ == "__main__":
    rewrite_date_variable()
