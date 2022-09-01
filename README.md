# Gadgetron conda recipes

This repo contains conda recipes for a few dependencies for [Gadgetron](https://github.com/gadgetron/gadgetron) that are not available through other sources. The Gadgetron itself and ISMRMRD (https://github.com/ismrmrd/ismrmrd) related projects provide their own conda packages through their respective repos and build pipelines. 

For details on installing the gadgetron via conda, consult the [Gadgetron documentation](https://gadgetron.readthedocs.io/en/latest/obtaining.html#installing-in-conda-environment)

## Building packages

Use the [`build.sh`](build.sh) script at the root to build all or a specific packe and optionally push to anaconda.org. For example, to build and force push the cpr package, use:

```bash
./build.sh -p cpr --token <TOKEN> -u <user or org> --push --force
```

If you would like to upload the packages, do `conda config --set anaconda_upload yes` and log in with your anaconda.org account first.
