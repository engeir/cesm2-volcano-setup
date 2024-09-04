# CESM2 Volcano Setup

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13683168.svg)](https://zenodo.org/doi/10.5281/zenodo.13683168)
<sup>Latest version: v0.2.0</sup> <!-- x-release-please-version -->

> Recipe to initialise CESM2 to run simulations of volcanic eruptions in a steady
> climate.

## Creating source files

> Depends on [volcano-cooking](https://github.com/engeir/volcano-cooking/) and
> [NCL](https://www.ncl.ucar.edu/index.shtml).

To create the volcanic forcing input files, move into each directory inside
[forcing-files](./forcing-files/) and run the shell script.

```bash
cd ./forcing-files/
cd ./small/
./make-ens1-forcing.sh
cd ..
# And so on ...
```

## Creating "INTERP_MISSING_MONTHS" simulations

> Depends on [netCDF4](https://pypi.org/project/netCDF4/) and
> [NCO](http://research.jisao.washington.edu/data_sets/nco/).

The files listed in the `ext_frc_specifier` configuration in the `user_nl_cam` file
(e.g., [`emissions-cmip6_bc_a4_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc`])
contain only data for the year 1850, so we must shift the time to year 1 and year 9999
([forum hint]).

This is done using the scripts in the [cyclic2interp](./cyclic2interp/) directory. Let
us say `input-file.nc` is an input file that should be used in the `CYCLE` CESM2
configuration, but we want to use `INTERP_MISSING_MONTHS`. We then do

```bash
cd ./cyclic2interp/
./cycle2interp.sh input-file.nc
```

## Updating `user_nl_cam`

When setting up a model run, the only important file to fix is `user_nl_cam`. We change
the forcing type to `INTERP_MISSING_MONTHS` and use our new files from running the
`cycle2interp` strategy [above](#creating-interp_missing_months-simulations). The last
SO2 input file is one created from the [Creating source files](#creating-source-files)
procedure.

### `BWma1850`

```txt
ext_frc_cycle_yr       = -999
ext_frc_specifier      = 'bc_a4 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_bc_a4_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc',
        'NO2 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_NO2_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc'
        'num_a1 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_num_so4_a1_anthro-ene_vertical_1750-2015_1.9x2.5_c20170616.nc',
        'num_a1 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_num_a1_so4_contvolcano_vertical_850-5000_1.9x2.5_c20190417.nc',
        'num_a2 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_num_a2_so4_contvolcano_vertical_850-5000_1.9x2.5_c20190417.nc',
        'num_a4 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_num_bc_a4_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc',
        'SO2 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_SO2_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc',
        'SO2 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_SO2_contvolcano_vertical_850-5000_1.9x2.5_c20190417.nc',
        'SO2 -> /cluster/projects/nn9817k/cesm/input-data/historic-forcing/ensemble-runs/medium/ens1/VolcanEESMv3.11Enger_SO2_850-2016_Zreduc_2deg_c20240102-151625.nc',
        'so4_a1 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_so4_a1_anthro-ene_vertical_1750-2015_1.9x2.5_c20170616.nc',
        'so4_a1 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_so4_a1_contvolcano_vertical_850-5000_1.9x2.5_c20190417.nc',
        'so4_a2 -> /cluster/projects/nn9817k/cesm/input-data/cyclic2interp_missing_months/BWma1850/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_so4_a2_contvolcano_vertical_850-5000_1.9x2.5_c20190417.nc'
ext_frc_type       = 'INTERP_MISSING_MONTHS'
```

[forum hint]: https://sourceforge.net/p/nco/discussion/9830/thread/8f0abe56/
[`emissions-cmip6_bc_a4_aircraft_vertical_1750-2015_1.9x2.5_c20170608.nc`]: https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/atm/cam/chem/emis/CMIP6_emissions_1750_2015_2deg/emissions-cmip6_so4_a1_anthro-ene_vertical_1750-2015_1.9x2.5_c20170616.nc
