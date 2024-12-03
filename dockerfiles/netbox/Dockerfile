FROM netboxcommunity/netbox:v4.1.7@sha256:238344b69e4efcb138eaa26a520f8ed2a3290fca115ad96b0f71d179d4e0df28

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py