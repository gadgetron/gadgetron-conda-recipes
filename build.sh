#!/bin/bash

set -euo pipefail

usage()
{
  cat << EOF

Builds one or more conda packages.

Usage: $0 [options]

Options:
  -p|--package <package>                 Package to build (defaults to all)
  -u|--user <user>                       Anaconda.org channeluser or organization (default: 'gadgetron')
  -t|--token <token>                     Token for uploading to anaconda.org
  --include-user-channel                 Add a "-c https://anaconda.org/<user>" to list of channels.
  --clean                                Clean build directory
  --push                                 Push package to anaconda channel
  --force                                Force push even if package exists
  -h, --help  Brings up this menu
EOF
}

all_packages=("ismrmrd" "ismrmrd-python" "mrd-storage-server" "siemens_to_ismrmrd" "range-v3" "cpr" "gadgetron-python")
packages_to_build=()
user="gadgetron"

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -p|--package)
      packages_to_build+=("$2")
      shift
      shift
      ;;
    -u|--user)
      user="$2"
      shift
      shift
      ;;
    -t|--token)
      token="$2"
      shift
      shift
      ;;
    --include-user-channel)
      include_user_channel=1
      shift
      ;;
    --clean)
      clean=1
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
  echo "Please supply token with --token argument"
  exit 1
fi

if [ ${#packages_to_build[@]} -eq 0 ]; then
    packages_to_build=("${all_packages[@]}")
fi

# Build up channel directives
global_channels=$(cat $(dirname "$0")/global.yml | yq -r '.channels | join(" -c ")')

if [[ -n "${include_user_channel:-}" ]]; then
  channel_directive="-c https://conda.anaconda.org/$user -c $global_channels"
else
  channel_directive="-c $global_channels"
fi

force_directive="--skip-existing"
if [[ -n ${force:-} ]]; then
  force_directive="--force"
fi

build_directory="./build"
if [[ -n "${clean:-}" ]]; then
  rm -rf "$build_directory"
  exit 0
fi

mkdir -p "$build_directory"
for p in "${packages_to_build[@]}"
do
    package_name=$(cat "$(dirname "$0")/${p}/meta.yaml" | yq -r .package.name)
    package_version=$(cat "$(dirname "$0")/${p}/meta.yaml" | yq -r .package.version)
    bash -c "conda build --no-anaconda-upload --output-folder $build_directory $channel_directive $p"
    if [[ -n "${push:-}" ]]; then
      for dirname in $build_directory/*; do
        if [ -d "$dirname" ]; then
          for filename in $dirname/*; do
            if [[ "${filename: -8}" == ".tar.bz2" ]] && [[ "$filename" =~ ^${dirname}/${package_name}-${package_version} ]]; then
              anaconda -t "$token" upload -u $user $force_directive $filename
            fi
          done
        fi
      done
    fi
done
