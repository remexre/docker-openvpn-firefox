#!/bin/bash

set -eu

function new_container() {
	docker run \
		--cap-add=NET_ADMIN \
		--device=/dev/net/tun \
		--dns 8.8.8.8 \
		--dns 8.8.4.4 \
		--name "${1:-openvpn-firefox}" \
		-d \
		-e DISPLAY="${DISPLAY}" \
		-e OPENVPN_PROVIDER="${OPENVPN_PROVIDER}" \
		-e OPENVPN_USERNAME="${OPENVPN_USERNAME}" \
		-e OPENVPN_PASSWORD="${OPENVPN_PASSWORD}" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		"remexre/openvpn-firefox:${2:-latest}"
}

function restart_container() {
	docker start "${1:-openvpn-firefox}"
}

function new_window() {
	docker exec \
		-d \
		-e DISPLAY="${DISPLAY}" \
		-u firefox \
		"${1:-openvpn-firefox}" firefox
}

if [[ "${#}" -gt 2 ]]; then
	echo >&2 "Usage: ./start-longterm.sh [NAME [TAG]]"
	echo >&2 ""
	echo >&2 "  NAME    The name for the container. Defaults to openvpn-firefox."
	echo >&2 "  TAG     The tag to use for the container. Defaults to latest."
	exit 1
fi

container_status="$(docker inspect "${1:-openvpn-firefox}" 2>/dev/null | jq -cer ".[0].State.Status // empty" || echo "does-not-exist")"
case "${container_status}" in
	does-not-exist)
		new_container ${@}
		;;
	exited)
		restart_container ${@}
		;;
	running)
		new_window ${@}
		;;
	*)
		echo "Unknown container status \`${container_status}': file a bug."
		;;
esac
