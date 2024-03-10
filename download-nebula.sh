#!/bin/sh
set -e

VERSION=$1
DEST_DIR=$2


if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version> <dest dir>"
  exit 1
fi

if [ -z "$DEST_DIR" ]; then
  echo "Usage: $0 <version> <dest dir>"
  exit 1
fi

echo "Downloading Nebula $VERSION to $DEST_DIR"
mkdir -p "$DEST_DIR"

cd "$DEST_DIR"

wget "https://github.com/slackhq/nebula/releases/download/$VERSION/SHASUM256.txt" -O SHASUM256.txt

ARCH="$(uname -m)"
if [ "$ARCH" = "x86_64" ]; then
  ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
fi

wget "https://github.com/slackhq/nebula/releases/download/$VERSION/nebula-linux-$ARCH.tar.gz" -O "nebula-linux-$ARCH.tar.gz"

# Verify the checksum, skipping files inside the tarball
grep "nebula-linux-$ARCH.tar.gz$" SHASUM256.txt | sha256sum -c

tar -xzf "nebula-linux-$ARCH.tar.gz"
