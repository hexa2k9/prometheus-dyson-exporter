FROM rockylinux:8-minimal

# Create config directory
RUN microdnf module enable -y python39:3.9 && microdnf install -y python39 && mkdir -p /config && pip3.9 install --no-cache-dir virtualenv

# Install package
WORKDIR /app
COPY . .
RUN virtualenv .venv && .venv/bin/pip --no-cache-dir install .

# Set Environment Variables
ENV EXPORTER_PORT="9672"
ENV EXPORTER_LOG_LEVEL="INFO"
ENV CONFIG_PATH="/config/devices.ini"
ENV DYSON_SERIAL=""
ENV DYSON_CREDENTIAL=""
ENV DYSON_DEVICE_TYPE=""
ENV DYSON_IP=""

ENTRYPOINT ["/app/.venv/bin/python", "dyson-exporter"]
