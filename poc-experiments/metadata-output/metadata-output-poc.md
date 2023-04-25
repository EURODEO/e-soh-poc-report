## Metadata output

By using the [py-mmd-tools package](https://github.com/metno/py-mmd-tools) developed at MET Norway,
one can create a [MET Norway Metadata Format](https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html) (MMD) file from a properly documented dataset (here NetCDF4).

By using the xslt-transformations defined in the [MMD-repo](https://github.com/metno/mmd/tree/master/xslt), one can then transform to different metadata standards.

See [/metadata-output folder](https://github.com/EURODEO/e-soh-poc-report/blob/main/poc-experiments/metadata-outputs) for simple python script to go through all the xslt-translations from the xslt-folder (Need to have lxml installed, and xslt-folder copied where you want to run the script)

Deciding on one internal metadata format will then facilitate increased interoperability when translations between the different metadata-formats are in place
