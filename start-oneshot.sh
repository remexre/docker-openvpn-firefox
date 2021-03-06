#!/bin/bash

set -eu

if [[ "${#}" -gt 1 ]]; then
	echo >&2 "Usage: ./start-oneshot.sh [TAG]"
	echo >&2 ""
	echo >&2 "  TAG     The tag to use for the container. Defaults to latest."
	exit 1
fi

docker run \
	--cap-add=NET_ADMIN \
	--device=/dev/net/tun \
	--dns 8.8.8.8 \
	--dns 8.8.4.4 \
	--rm \
	-e DISPLAY="${DISPLAY}" \
	-e OPENVPN_PROVIDER="${OPENVPN_PROVIDER}" \
	-e OPENVPN_USERNAME="${OPENVPN_USERNAME}" \
	-e OPENVPN_PASSWORD="${OPENVPN_PASSWORD}" \
	-v /dev/shm:/dev/shm \
	-v /etc/machine-id:/etc/machine-id \
	-v /run/user/"$(id -u)"/pulse:/run/user/1000/pulse \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /var/lib/dbus:/var/lib/dbus \
	"remexre/openvpn-firefox:${1:-latest}"
