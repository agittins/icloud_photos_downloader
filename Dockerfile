FROM alpine:3.11.3

RUN set -xe && \
    apk add --no-cache python3 imagemagick && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

COPY . /tmp/
RUN set -xe && \ 
  cd /tmp/ && \
  pip install /tmp  && \
  icloudpd --version && \
  icloud -h | head -n1
