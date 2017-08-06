#!/bin/bash

set -eu

cd "$(dirname "${BASH_SOURCE}")"

providers="$(find . -mindepth 1 -maxdepth 1 -type d)"

for p in ${providers}; do
	./adjustConfigs.sh "${p}"
done
