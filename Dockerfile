FROM quay.io/experimentalplatform/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y -q --no-install-recommends collectd python-pip python-setuptools libpython2.7 lm-sensors && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/hinnerk/docker-collectd-plugin.git /opt/docker-collectd-plugin
WORKDIR /opt/docker-collectd-plugin
RUN git checkout fix-timestamp
RUN pip install wheel
RUN pip install -r requirements.txt

COPY collectd.conf /etc/collectd/collectd.conf
COPY docker.conf /etc/collectd/collectd.conf.d/docker.conf
COPY interface.conf /etc/collectd/collectd.conf.d/interface.conf
COPY rrdtool.conf /etc/collectd/collectd.conf.d/rrdtool.conf

CMD ["/usr/sbin/collectd", "-f"]

