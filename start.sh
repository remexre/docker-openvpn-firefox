#!/bin/bash

set -eu

cd "$(dirname "${BASH_SOURCE}")"

docker build -t openvpn-firefox .
docker run --rm -it \
	--cap-add=NET_ADMIN \
	--device=/dev/net/tun \
	--dns 8.8.8.8 \
	--dns 8.8.4.4 \
	-e DISPLAY=$DISPLAY \
	-e OPENVPN_PROVIDER="${OPENVPN_PROVIDER}" \
	-e OPENVPN_USERNAME="${OPENVPN_USERNAME}" \
	-e OPENVPN_PASSWORD="${OPENVPN_PASSWORD}" \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	openvpn-firefox
