FROM netboxcommunity/netbox:v4.1.9@sha256:2d2a559249b855183e90b0ce4242150ad549b56ce56c0d847f4d846388f6345a

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py