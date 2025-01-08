FROM netboxcommunity/netbox:v4.2.1@sha256:ec8bd7baec143d8898d204e2baeb399753a5783bc315b117f100b793154f9797

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py