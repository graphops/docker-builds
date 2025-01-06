FROM netboxcommunity/netbox:v4.1.11@sha256:d1260201d775b3f1d0b19e425bd19facc1e907e7153a8247d04d996037969e53

RUN echo "netbox_attachments" >> /opt/netbox/plugin_requirements.txt

RUN /opt/netbox/venv/bin/pip install netbox-attachments

RUN echo "PLUGINS = ['netbox_attachments']" >> /opt/netbox/netbox/netbox/configuration.py