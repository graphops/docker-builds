# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.7"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:6cb789ac9d800a5d0eb435dd3ffc7706cc5ef238db9bf8b3af9f02ef7b79af48

COPY plugin_requirements.txt /opt/netbox/
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/plugins.py /etc/netbox/config/plugins.py

# Create attachments directory
RUN mkdir -p /opt/netbox/netbox/media/netbox-attachments

RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
