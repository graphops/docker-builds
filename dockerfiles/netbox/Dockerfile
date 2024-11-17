FROM netboxcommunity/netbox:v4.1.6@sha256:db44dc545ab8e01e24bf332fde6c964bdb31c7fa4ee8a223759135decc88be56

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py