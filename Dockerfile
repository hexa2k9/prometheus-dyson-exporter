FROM rockylinux:9-minimal

ENV PYTHON_VERSION=3.12

# Create config directory
RUN set -eux \
	&& microdnf install --nodocs -y python${PYTHON_VERSION} python${PYTHON_VERSION}-pip \
	&& pip${PYTHON_VERSION} install --no-cache-dir virtualenv \
	&& mkdir -p /config 

# Install package
WORKDIR /app
COPY . .
RUN set -eux \
	&& virtualenv -p ${PYTHON_VERSION} .venv \
	&& .venv/bin/pip --no-cache-dir install .

# Set Environment Variables
ENV EXPORTER_PORT="9672"
ENV EXPORTER_LOG_LEVEL="INFO"
ENV CONFIG_PATH="/config/devices.ini"
ENV DYSON_SERIAL=""
ENV DYSON_CREDENTIAL=""
ENV DYSON_DEVICE_TYPE=""
ENV DYSON_IP=""

ENTRYPOINT ["/app/.venv/bin/dyson-exporter"]
