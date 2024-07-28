FROM netboxcommunity/netbox:v4.0.8@sha256:024f858e891bb4f8f20f888a7349414770a834d7a8067472d5652590cdef7fff

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py