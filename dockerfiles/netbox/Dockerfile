FROM netboxcommunity/netbox:v4.1.10@sha256:4894ec2c79db779cb57f6dc4edf5839877d4f7e278961c7e540b0fa785afae00

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py