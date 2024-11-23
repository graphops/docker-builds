FROM netboxcommunity/netbox:v4.1.7@sha256:ca05c51a706eb130012c0058dacc16d427cd013ca820a8918adfa2299759a635

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py