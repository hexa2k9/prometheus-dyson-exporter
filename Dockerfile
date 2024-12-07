FROM python:3.13-alpine3.20 AS builder

ADD . /work
WORKDIR /work

RUN set -eux \
  && apk update \
  && apk add musl-dev gcc \
  && pip install virtualenv \
  && virtualenv /opt/virtualenv \
  && /opt/virtualenv/bin/pip install .

FROM python:3.13-alpine3.20

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Set Environment Variables
ENV EXPORTER_PORT="9672"
ENV EXPORTER_LOG_LEVEL="INFO"
ENV CONFIG_PATH="/config/devices.ini"
ENV DYSON_SERIAL=""
ENV DYSON_CREDENTIAL=""
ENV DYSON_DEVICE_TYPE=""
ENV DYSON_IP=""

RUN set -eux \
    && apk --no-cache upgrade

COPY --from=builder /opt/virtualenv /opt/virtualenv

EXPOSE 9672

ENTRYPOINT [ "/opt/virtualenv/bin/python", "/opt/virtualenv/bin/dyson-exporter" ]
