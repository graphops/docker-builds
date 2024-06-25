FROM netboxcommunity/netbox:v4.0.3

RUN echo "netbox-attachments" >> requirements.txt && \
    echo "netbox-attachments" >> local_requirements.txt

RUN . /opt/netbox/venv/bin/activate && \
    pip install netbox-attachments

RUN echo "PLUGINS = ['netbox-attachments']" >> /opt/netbox/netbox/netbox/configuration.py