FROM netboxcommunity/netbox:v4.1.4@sha256:1df601ca34a634d6bdfd0783255c8c71cd4d5693da31c1035a5af6940bb2e464

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py