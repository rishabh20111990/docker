FROM osism/cinder-volume:train
LABEL name="rhosp16/openstack-cinder-volume-hpe" \
      maintainer="sneha.rai@hpe.com" \
      vendor="HPE" \
      version="1.0" \
      release="16" \
      summary="Red Hat OpenStack Platform 16.0 cinder-volume HPE plugin" \
      description="Cinder plugin for HPE 3PAR"

# switch to root and install a custom RPM, etc.
USER "root"

# install python module python-3parclient(dependent module for HPE 3PAR Cinder driver)
RUN export http_proxy=http://web-proxy.atl.hpecorp.net:8080/ && export https_proxy=http://web-proxy.atl.hpecorp.net:8080/
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py && pip install -U setuptools && pip install python-3parclient==4.2.11 && rm get-pip.py

RUN mkdir -p /licenses

# Add required license as text file in Liceses directory (GPL, MIT, APACHE, Partner End User Agreement, etc)
COPY LICENSE /licenses

# switch the container back to the default user
USER "cinder"

