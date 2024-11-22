FROM netboxcommunity/netbox:v4.1.7@sha256:e88d5e58dd32d643d8d9851f6c9edde20a69a87fd4a72a14259d045f6d3e19d3

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py