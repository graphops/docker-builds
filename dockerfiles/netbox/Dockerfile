FROM netboxcommunity/netbox:v4.1.3@sha256:f18570dee95938d1780d15d7c7a42415693b777deb4e650578bbb82ab91a9fa7

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py