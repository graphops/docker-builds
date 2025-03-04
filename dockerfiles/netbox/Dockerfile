# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.4"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:319e0ee089c1236a37653ae2da40f24bb2508b39d5693daad75fd526d8e205a0

COPY plugin_requirements.txt /opt/netbox/
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/plugins.py /etc/netbox/config/plugins.py

# Create attachments directory
RUN mkdir -p /opt/netbox/netbox/media/netbox-attachments

RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
