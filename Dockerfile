FROM zabbix/zabbix-agent:ubuntu-latest

# intall python 
RUN apt-get update && apt-get install -y --no-install-recommends \
    python \
    python-dev \
    wget \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# install pip
RUN wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py

# Fix: InsecurePlatformWarning
# http://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning
RUN apt-get update && apt-get install -y --no-install-recommends \
    libffi-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && pip install --no-cache-dir ndg-httpsclient

# install numpy
RUN pip install --no-cache-dir numpy

# install scipy
RUN apt-get update && apt-get install -y --no-install-recommends \
    libatlas-base-dev \
    gfortran \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && pip install --no-cache-dir scipy

