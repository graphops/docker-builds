FROM netboxcommunity/netbox:v4.0.9@sha256:5cd2f4658d21b07973026d51359f86051df6a815af2017851de2b1ba9fad3e98

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py