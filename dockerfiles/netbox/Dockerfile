FROM netboxcommunity/netbox:v4.1.3@sha256:46a5ff45382c13bf10f8c9d425a2e43f9c2238c40f49debafe77a318667b8d8a

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py