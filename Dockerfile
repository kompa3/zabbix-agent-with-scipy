FROM zabbix/zabbix-agent:ubuntu-latest

# install prerequisites for pypy
RUN apt-get update && apt-get install -y --no-install-recommends \
    libexpat1 libgdbm3 \
    curl \
    ca-certificates \
    gcc g++ gfortran \
    libatlas-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# update prerequisite package from trusty version to later ones
RUN curl -LO http://de.archive.ubuntu.com/ubuntu/pool/main/n/ncurses/libncurses5_6.0+20160625-1ubuntu1_amd64.deb && \
    curl -LO http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu13.3_amd64.deb && \
    curl -LO http://de.archive.ubuntu.com/ubuntu/pool/main/n/ncurses/libtinfo5_6.0+20160625-1ubuntu1_amd64.deb && \
    dpkg -i *.deb && \
    rm *.deb

# install pypy 5.8
RUN curl -LO http://de.archive.ubuntu.com/ubuntu/pool/universe/p/pypy/pypy-lib_5.8.0+dfsg-2_amd64.deb && \
    curl -LO http://de.archive.ubuntu.com/ubuntu/pool/universe/p/pypy/pypy_5.8.0+dfsg-2_amd64.deb && \
    curl -LO http://de.archive.ubuntu.com/ubuntu/pool/universe/p/pypy/pypy-dev_5.8.0+dfsg-2_all.deb && \
    dpkg -i pypy-lib_5.8.0+dfsg-2_amd64.deb && \
    dpkg -i pypy_5.8.0+dfsg-2_amd64.deb && \
    dpkg -i pypy-dev_5.8.0+dfsg-2_all.deb && \
    rm *.deb

# install pip
RUN curl -LO https://bootstrap.pypa.io/get-pip.py && \
    pypy get-pip.py && \
    rm get-pip.py

# install numpy
RUN pip install --no-cache-dir numpy

# install scipy
RUN pip install --no-cache-dir scipy

# Replace /usr/bin/python with link to pypy
RUN rm /usr/bin/python && ln -s /usr/bin/pypy /usr/bin/python


