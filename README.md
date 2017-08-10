# docker-openvpn-firefox

A Docker container for running Firefox behind OpenVPN.

The `openvpn` directory is taken from [haugene/docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn).

Guidance on how to get PulseAudio working from [thebiggerguy/docker-pulseaudio-example](https://github.com/TheBiggerGuy/docker-pulseaudio-example).

## The Scripts

`start-oneshot.sh` starts the image in a temporary container, deleted after Ctrl-C is pressed.

`start-longterm.sh` creates a long-term container.
