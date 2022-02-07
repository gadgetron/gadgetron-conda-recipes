#!/bin/bash

set -euo pipefail

usage()
{
  cat << EOF

Builds one or more conda packages.

Usage: $0 [options]

Options:
  -p|--package <package>                 Package to build (defaults to all)
  -c|--channel <channel>                 Anaconda.org channel (default: 'gadgetron')
  -t|--token <token>                     Token for uploading to anaconda.org
  --push                                 Push package to anaconda channel
  --force                                Force push even if package exists  
  -h, --help  Brings up this menu
EOF
}

all_packages=("ismrmrd" "ismrmrd-python" "siemens_to_ismrmrd" "range-v3" "gadgetron-python" "gadgetron")
packages_to_build=()
channel="gadgetron"

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -p|--package)
      packages_to_build+=("$2")
      shift
      shift
      ;;
    -c|--channel)
      channel="$2"
      shift
      shift
      ;;
    -t|--token)
      token="$2"
      shift
      shift
      ;;
    --push)
      push=1
      shift
      ;;
    --force)
      force=1
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

if [[ -n "${push:-}" ]] && [[ -z "${token:-}" ]]; then
  echo "You cannot push to anaconda without a token"
  echo "Please supplu token with --token argument"
  exit 1
fi

if [ ${#packages_to_build[@]} -eq 0 ]; then
    packages_to_build=("${all_packages[@]}") 
fi

# Build up channel directives
global_channels=$(cat $(dirname "$0")/global.yml | yq -r '.channels | join(" -c ")')
channel_directive="-c https://conda.anaconda.org/$channel -c $global_channels"

force_directive="--skip-existing"
if [[ -n ${force:-} ]]; then
  force_directive="--force"
fi

for p in "${packages_to_build[@]}"
do
    tmp_dir=$(mktemp -d -t "conda-build-${p}-XXXXXXXXXX")
    bash -c "conda build --no-anaconda-upload --output-folder $tmp_dir $channel_directive $p"
    if [[ -n "${push:-}" ]]; then
      for dirname in $tmp_dir/*; do
        if [ -d "$dirname" ]; then
          for filename in $dirname/*; do
            if [ "${filename: -8}" == ".tar.bz2" ]; then
              anaconda -t "$token" upload -c $channel $force_directive $filename
            fi
          done
        fi
      done
    fi
    rm -rf $tmp_dir
done