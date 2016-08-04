FROM quay.io/experimentalplatform/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y -q --no-install-recommends collectd python-pip python-setuptools libpython2.7 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lebauce/docker-collectd-plugin /opt/docker-collectd-plugin
WORKDIR /opt/docker-collectd-plugin
RUN git checkout c3edc64555f35d8ffcc9aee23b69c289e8f309fb
RUN pip install wheel
RUN pip install -r requirements.txt

COPY docker.conf /etc/collectd/collectd.conf.d/docker.conf
COPY collectd.conf /etc/collectd/collectd.conf
