# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.3"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:06b882ea0a44c50f212e09babf9a411a759fb8b4c4a3085282bd5e8565b4334b

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py