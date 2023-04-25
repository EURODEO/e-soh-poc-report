## NetCDF versus Postgres

To compare the performance of different backends for storing recent observations, a special Python
program has been written (ref: to repo?).

The storage is a rolling buffer for keeping the latest (typically 24H of) observations for a set of
time series. Currently, two backends have been implemented/compared: A hybrid netCDF/PostGIS
solution, and a pure PostGIS solution.

An *observation* is assumed to consist of two components:

- a time represented as a *UNIX timestamp* (seconds since 1970-01-01T00:00:00Z)
- a value represented as a *floating point number*

A *time series* is assumed to be identified by the combination of a *station* and a *parameter*
(like air temperature).

### Storage backends

Two backends are currently implemented:

| Name  | Description |
| :---- | :--------------------------------- |
| PostGISSBE | Keeps all data in PostGIS database. |
| NetCDFSBE_TSMDataInPostGIS | Keeps all data in netCDF files on the local file system, one file per time series. Per time series metadata (i.e. not actual observations) will also be kept in a PostGIS database to speed up searching for target files to retrieve observations from. |

**Note:** the program is designed to make it easy to add more backends.

### Use cases

The following use cases are currently implemented:

| Name  | Description |
| :---- | :---------------------------------- |
| Reset | Reset storage with *n* time series, wiping all existing data. |
| Fill  | Fill storage with observations. |
| AddNew | Add new observations to the storage while deleting any old observations and overwriting any existing ones. |
| GetAll | Retrieve all observations. |

**Note:** the program is designed to make it easy to add more use cases.

### Testing

Testing is done essentially according to this algorithm:

```text
    for uc in use cases:
      for sbe in storage backends:
         apply uc to sbe and aggregate stats
```

<span style="color:#ff0000">
**MORE INFO HERE SOON!**
</span>

#### Test environment

The tests have been run in the following environment:

- HW: HP ZBook with 16GB RAM
- OS: Ubuntu 18.04 Bionic
- Python version: 3.9

The two storage backends both use a PostGIS server that runs in a local docker container
(they use separate databases, though: `esoh_postgis` for PostGISSBE and `esoh_netcdf`
for NetCDFSBE_TSMDataInPostGIS).

#### Test results

<span style="color:#ff0000">
**MORE INFO HERE SOON!**
</span>
