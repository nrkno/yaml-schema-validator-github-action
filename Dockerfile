FROM python:3.8-alpine

RUN apk add --no-cache bash

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY example/ ./example

# Nonexistent
USER 2000:2000

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
