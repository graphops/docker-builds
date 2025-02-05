# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.3"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:953cb21c3c62462ba6b174dbcd874f7ea96e88852b778b566bdaffaf3be85171

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py