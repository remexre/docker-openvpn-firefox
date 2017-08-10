#!/bin/bash

# Based on haugene's start script for docker-transmission-openvpn.

set -eu

# Get the DISPLAY variable back.
export DISPLAY="$(< /openvpn-firefox/display)"

# Start Firefox
su -l firefox -c "firefox --profile /data" &
