FROM netboxcommunity/netbox:v4.1.1@sha256:0a0234c2e3c09617413b7b01d1afd370d04cab04d8035a96c00fdebcf0f778a2

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py