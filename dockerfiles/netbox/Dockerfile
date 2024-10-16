FROM netboxcommunity/netbox:v4.1.4@sha256:f495106bfe677265333c42dceed42f8ba09ad11ccbc219dea7cd37c5c4f47414

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py