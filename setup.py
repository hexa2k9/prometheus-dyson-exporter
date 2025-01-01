from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()


def parse_requirements(filename):
    """Load requirements from a pip requirements file"""
    with open(filename, "r") as fd:  # pylint: disable=unspecified-encoding
        lines = []
        for line in fd:
            line = line.strip()
            if line and not line.startswith("#"):
                lines.append(line)
    return lines


setup(
    name="prometheus-dyson-exporter",
    packages=["dyson_exporter"],
    version="1.0.0",
    long_description=long_description,
    long_description_content_type="text/markdown",
    description="Prometheus exporter for Dyson Fan Products leveraging Libdyson (https://github.com/shenxn/libdyson)",
    author="Zachary Cohen",
    author_email="zacharykhcohen@gmail.com",
    url="https://github.com/zkhcohen/prometheus-dyson-exporter",
    download_url="https://github.com/zkhcohen/prometheus-dyson-exporter/archive/refs/tags/1.0.0.tar.gz",
    keywords=["prometheus", "dyson"],
    classifiers=[],
    python_requires=">=3",
    install_requires=parse_requirements("requirements.txt"),
    entry_points={
        "console_scripts": [
            "dyson-exporter=dyson_exporter.exporter:main",
        ]
    },
)
