FROM netboxcommunity/netbox:v4.1.10@sha256:545f58a14d401dc028c75d9a198b77a4f200d5fb21a3142f6814e5631599bc59

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py