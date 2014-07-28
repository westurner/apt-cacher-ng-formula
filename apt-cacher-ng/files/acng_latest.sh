#!/bin/sh
# Patch the latest apt-cacher-ng binary in
# without recompiling
# for Ubuntu 12.04 LTS

# (Primarily for APT HTTPS support)

# NOTE: This will cause debsums to fail on
# /usr/sbin/apt-cacher-ng

# TODO: proper dpkg-divert of /usr/sbin/apt-cacher-ng

# http://packages.ubuntu.com/trusty/amd64/apt-cacher-ng/download 

set -e
set -x

MIRROR="http://ftp.osuosl.org/pub/ubuntu"
VER="{{ version }}"
BIN="/usr/sbin/apt-cacher-ng"
BKP="${BIN}.bkp"

if [ -f "${BKP}" ]; then
  echo "${BKP} already exists. Exiting..."
  exit
fi

ARCH=$(dpkg-architecture -qDEB_BUILD_ARCH) 
PKG="apt-cacher-ng_${VER}_${ARCH}.deb"
URL="${MIRROR}/pool/universe/a/apt-cacher-ng/${PKG}"
TMP="./acng_latest"
DIR="${TMP}/acng"


mkdir -p "${TMP}/acng"
cd ${TMP}
wget "${URL}"
dpkg -x ./${PKG} ./acng
cd ./acng
sudo cp "${BIN}" "${BKP}"
sudo /etc/init.d/apt-cacher-ng stop
sudo cp ".${BIN}" "${BIN}"
rm -rfv "${TMP}"
sudo /etc/init.d/apt-cacher-ng start
