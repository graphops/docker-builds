FROM netboxcommunity/netbox:v4.0.6@sha256:e4813edc83d5330214b9b12140f7a4250a1f10daef2ef324f3b42b42bcc9b1ac

RUN echo "netbox-attachments" >> requirements.txt && \
    echo "netbox-attachments" >> local_requirements.txt

RUN . /opt/netbox/venv/bin/activate && \
    pip install netbox-attachments

RUN echo "PLUGINS = ['netbox-attachments']" >> /opt/netbox/netbox/netbox/configuration.py