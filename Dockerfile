# Docker container for emulation testing

# Copyright (c) 2023 Zero ASIC Corporation
# This code is licensed under Apache License 2.0 (see LICENSE for details)

FROM python:3.11

# basic setup, including Python and Node.js installations
# (Node.js is needed for some GitHub Actions)
RUN \
apt update -y && \
apt install -y curl unzip git libsystemc libsystemc-dev && \
python3 -m pip install --upgrade pip && \
curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && \
apt install -y nodejs && \
apt clean && \
rm -rf /var/lib/apt/lists/*

# install verible. Move executables to a location on PATH and remove
# downloaded files.
RUN \
apt-get update && apt-get install -y wget && \
wget https://github.com/chipsalliance/verible/releases/download/v0.0-3303-gd87f2420/verible-v0.0-3303-gd87f2420-linux-static-x86_64.tar.gz && \
tar xzf verible-v*.tar.gz && \
rm verible-v*.tar.gz && \
mv verible-v* verible && \
cp -a verible/bin/* /usr/local/bin && \
rm -rf verible

# install Verilator.  the final remove in the same RUN command
# is important to keep the docker image size low
# https://verilator.org/guide/latest/install.html#git-quick-install
RUN \
apt update -y && \
apt install -y git help2man perl python3 make autoconf g++ flex bison \
    ccache libgoogle-perftools-dev numactl perl-doc && \
apt install -y libfl2 && \
apt install -y libfl-dev && \
git clone https://github.com/verilator/verilator && \
cd verilator && \
git pull && \
git checkout v5.018 && \
autoconf && \
./configure && \
make -j `nproc` && \
make install && \
cd .. && \
rm -rf verilator && \
apt clean && \
rm -rf /var/lib/apt/lists/*

# install Icarus Verilog.  the final remove in the same RUN command
# is important to keep the docker image size low
# https://iverilog.fandom.com/wiki/Installation_Guide#Obtaining_Source_From_git
RUN \
apt update -y && \
apt install -y autoconf gperf && \
git clone https://github.com/steveicarus/iverilog.git && \
cd iverilog && \
git pull && \
git checkout v12_0 && \
sh autoconf.sh && \
./configure && \
make -j `nproc` && \
make install && \
cd .. && \
rm -rf iverilog && \
apt clean && \
rm -rf /var/lib/apt/lists/*

# set environment
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
