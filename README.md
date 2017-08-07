# docker-openvpn-firefox

A Docker container for running Firefox behind OpenVPN.

The `openvpn` directory is taken from [haugene/docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn).

## The Scripts

`start-oneshot.sh` starts the image in a temporary container, deleted after Ctrl-C is pressed.

`start-longterm.sh` creates a long-term container.
