FROM netboxcommunity/netbox:v4.2.1@sha256:d5420d690d3e614253198e1a98d704a7e1840f9d97d7b4542605b43132f32118

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py