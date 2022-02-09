# Gadgetron conda recipes

This repo contains conda recipes for a number of [Gadgetron](https://github.com/gadgetron/gadgetron) and ISMRMRD (https://github.com/ismrmrd/ismrmrd related projects and has been used to produce the conda packages in [https://anaconda.org/gadgetron/repo](https://anaconda.org/gadgetron/repo). 

## Testing the packages

To spin up a Gadgetron environment in conda, first [install conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) and define the following `environment.yml` file:

```yaml
name: gadgetron-test-env
channels:
  - nvidia/label/cuda-11.6.0
  - gadgetron
  - conda-forge
  - defaults
  - intel
dependencies:
  - gadgetron=4.1.2
  - siemens_to_ismrmrd>=1.0.0
```

And create the environment with:

```bash
conda env create -f environment.yml
```

Then activate the environment with:

```bash
conda activate gadgetron-test-env
```

And you should be able to run the Gadgetron. Test capabilities with `gadgetron --info`

## Building packages

Use the [`build.sh`](build.sh) script at the root to build all or a specific packe and optionally push to anaconda.org. For example, to build and force push the ismrmrd package, use:

```bash
./build.sh -p ismrmrd --token <TOKEN> -u <user or org> --push --force
```

If you would like to upload the packages, do `conda config --set anaconda_upload yes` and log in with your anaconda.org account first.
