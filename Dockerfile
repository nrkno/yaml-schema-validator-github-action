FROM alpine:3

RUN apk add --no-cache bash python3 py3-pip \
  && mkdir -p /usr/src/app \
  && addgroup -g 10000 app \
  && adduser  -s /bin/bash -G app -u 10000 -h /usr/src/app -k /dev/null -D app \
  && python3 -m venv /usr/src/app/venv \
  && chown -R app:app /usr/src/app

WORKDIR /usr/src/app
USER 10000:10000
ENV VIRTUAL_ENV=/usr/src/app/venv \
    PATH=/usr/src/app/venv/bin:$PATH

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
