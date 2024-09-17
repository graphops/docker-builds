FROM netboxcommunity/netbox:v4.1.1@sha256:016d0a3d34cd09816c5098adfe745f4d10aea064d520287c132f51cf3f8082be

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py