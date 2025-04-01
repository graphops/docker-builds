# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.6"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:e3b9806817a2d17e553e7fc8f6a0ae5818d739af8db0e0bf3cdae3b21c28113a

COPY plugin_requirements.txt /opt/netbox/
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/plugins.py /etc/netbox/config/plugins.py

# Create attachments directory
RUN mkdir -p /opt/netbox/netbox/media/netbox-attachments

RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
