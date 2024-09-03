FROM netboxcommunity/netbox:v4.0.11@sha256:619f123f65cb747dd5acac56283506ca9a82107bac27475fa7176e432e403877

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py