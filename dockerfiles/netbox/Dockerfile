FROM netboxcommunity/netbox:v4.1.1@sha256:bd43b9286d1d64a7a2466194cd50e9a5a33c4cacc877a4f7a5481d89bb35e819

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py