#!/bin/bash

# Based on haugene's start script for docker-transmission-openvpn.

set -eu

# Choose an OpenVPN config
config="/etc/openvpn/$(echo ${OPENVPN_PROVIDER} | tr '[A-Z]' '[a-z]')/${OPENVPN_CONFIG:-default}.ovpn"
if [[ ! -f "${config}" ]]; then
	echo "No such OpenVPN config: \`${config}'" >&2
	exit 1
fi

# Set OpenVPN credentials
echo "${OPENVPN_USERNAME}" > /openvpn-firefox/credentials.txt
echo "${OPENVPN_PASSWORD}" >> /openvpn-firefox/credentials.txt
chmod 600 /openvpn-firefox/credentials.txt

# Store the display.
echo "${DISPLAY}" > /openvpn-firefox/display

# Start OpenVPN.
exec openvpn --script-security 2 --up-delay --up /openvpn-firefox/start-ff.sh --down /openvpn-firefox/stop-ff.sh --config "${config}"
