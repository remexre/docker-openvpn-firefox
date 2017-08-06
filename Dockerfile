FROM ubuntu:xenial

# Install firefox and openvpn
RUN apt-get update && apt-get install -y curl firefox openvpn && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install dumb-init
RUN curl -LO https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb && dpkg -i dumb-init_*.deb && rm dumb-init_*.deb

# Add the Firefox user
RUN useradd -Um firefox

# Add the OpenVPN configs
ADD openvpn/ /etc/openvpn/

# Add the scripts
ADD scripts/start-ff.sh /openvpn-firefox/start-ff.sh
ADD scripts/stop-ff.sh /openvpn-firefox/stop-ff.sh
ADD scripts/entrypoint.sh /openvpn-firefox/entrypoint.sh

# Set the startup script
CMD ["dumb-init", "/openvpn-firefox/entrypoint.sh"]
