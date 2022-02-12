#!/bin/bash

set -euo pipefail

go build -o "${PREFIX}/bin/mrd-storage-server" .
