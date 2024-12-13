FROM netboxcommunity/netbox:v4.1.8@sha256:53291cfa1655d4995b3783d7bf272e92b50fa6817f53691021ea1edede3b3a7d

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py