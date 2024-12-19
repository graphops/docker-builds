FROM netboxcommunity/netbox:v4.1.9@sha256:087c95ebd3b1b9aa8c11fb98b597b9d7ff54e6aa1ee28f1f5689c534fc2070ee

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py