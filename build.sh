#!/bin/bash

set -euo pipefail

usage()
{
  cat << EOF

Builds one or more conda packages.

Usage: $0 [options]

Options:
  -p|--package                           Package to build (defaults to all)
  -h, --help  Brings up this menu
EOF
}

all_packages=("ismrmrd" "ismrmrd-python" "siemens_to_ismrmrd" "range-v3" "gadgetron-python" "gadgetron")
packages_to_build=()

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -p|--package)
      packages_to_build+=("$2")
      shift
      shift
      ;;
    -h|--help)
      usage
      exit
      ;;
    *)
      echo "ERROR: unknown option \"$key\""
      usage
      exit 1
      ;;
  esac
done

if [ ${#packages_to_build[@]} -eq 0 ]; then
    packages_to_build=("${all_packages[@]}") 
fi

for p in "${packages_to_build[@]}"
do
    conda build -c mihansen -c conda-forge -c intel "$p"
done