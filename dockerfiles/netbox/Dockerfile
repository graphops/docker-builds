FROM netboxcommunity/netbox:v4.0.10@sha256:835331ba44a6262c53ca10aaa48250a120280dc1b554182f53578f2fc1f264dd

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py