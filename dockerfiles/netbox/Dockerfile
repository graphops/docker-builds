# renovate: datasource=docker depName=netboxcommunity/netbox
ARG NETBOX_VERSION="v4.2.3"

FROM netboxcommunity/netbox:${NETBOX_VERSION}@sha256:06b882ea0a44c50f212e09babf9a411a759fb8b4c4a3085282bd5e8565b4334b

COPY plugin_requirements.txt /opt/netbox/
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/plugins.py /etc/netbox/config/plugins.py

# Create attachments directory
RUN mkdir -p /opt/netbox/netbox/media/netbox-attachments

RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
