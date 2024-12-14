FROM netboxcommunity/netbox:v4.1.8@sha256:1cee41eec65fa16ef87cc57a4c6a6cc67b317d948273dc776ae1d84542b950e8

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py