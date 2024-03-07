# Docker container for emulation testing

# Copyright (c) 2023 Zero ASIC Corporation
# This code is licensed under Apache License 2.0 (see LICENSE for details)

FROM python:3.11

# copy in reconfiguration files
COPY reconfigure-trilinos /root/reconfigure-trilinos
COPY reconfigure-xyce /root/reconfigure-xyce

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
apt-get update -y && \
apt-get install -y wget && \
wget https://github.com/chipsalliance/verible/releases/download/v0.0-3303-gd87f2420/verible-v0.0-3303-gd87f2420-linux-static-x86_64.tar.gz && \
tar xzf verible-v*.tar.gz && \
rm verible-v*.tar.gz && \
mv verible-v* verible && \
cp -a verible/bin/* /usr/local/bin && \
rm -rf verible && \
apt clean && \
rm -rf /var/lib/apt/lists/*

# install prereqs for Xyce
RUN \
apt update -y && \
apt install -y gcc g++ gfortran make cmake bison flex libfl-dev \
    libfftw3-dev libsuitesparse-dev libblas-dev liblapack-dev libtool \
    autoconf automake git && \
apt clean && \
rm -rf /var/lib/apt/lists/*

# install Trilinos
RUN \
cd /root && \
mkdir Trilinos12.12 && \
cd Trilinos12.12 && \
wget https://github.com/trilinos/Trilinos/archive/refs/tags/trilinos-release-12-12-1.tar.gz && \
tar xzf trilinos-release-12-12-1.tar.gz && \
rm trilinos-release-12-12-1.tar.gz && \
mkdir -p /root/XyceLibs/Serial && \
cd Trilinos-trilinos-release-12-12-1 && \
mkdir -p build && \
cd build && \
mv /root/reconfigure-trilinos reconfigure && \
chmod u+x reconfigure && \
./reconfigure && \
make && \
make install && \
cd /root && \
rm -rf Trilinos12.12

# install Xyce
RUN \
cd /root && \
wget https://xyce.sandia.gov/files/xyce/Xyce-7.8.tar.gz && \
tar xzf Xyce-7.8.tar.gz && \
rm Xyce-7.8.tar.gz && \
cd Xyce-7.8 && \
mkdir -p build && \
cd build && \
mv /root/reconfigure-xyce reconfigure && \
chmod u+x reconfigure && \
./reconfigure && \
make && \
make install && \
cd /root && \
rm -rf Xyce-7.8

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
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LD_LIBRARY_PATH=/usr/local/lib
