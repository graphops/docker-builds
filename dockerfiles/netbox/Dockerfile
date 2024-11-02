FROM netboxcommunity/netbox:v4.1.6@sha256:3b5bfc5f01ecbeac482f1d18f76e70892270cdf393b599c4cad47a8cc1b5de79

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py