#!/bin/sh

PLATFORM="linux"  #we're actually hardcoding this, since to many platforms and detection is a pain in the ass

ARCH() {
  case "$(uname -m)" in
     armv71|armv7l|armv7|arm|armhf) echo "arm";break;;
     arm64|aarch64)    echo "arm64";break;;
     x86_64|amd64)     echo "amd64";break;;
  esac
}

DOWNLOAD_PATH="$HOME/seaweedfs"
DOWNLOAD_FILE="latest.tar.gz"
DOWNLOAD_URL="https://github.com/chrislusf/seaweedfs/releases/latest/download/${PLATFORM}_$(ARCH).tar.gz"

INSTALL_PATH=/usr/bin

mkdir -p $DOWNLOAD_PATH
wget "$DOWNLOAD_URL" -O "$DOWNLOAD_PATH/$DOWNLOAD_FILE"
tar -xf "$DOWNLOAD_PATH/$DOWNLOAD_FILE" -C "$DOWNLOAD_PATH"
rm -f "$DOWNLOAD_PATH/$DOWNLOAD_FILE"

BIN="$(find $DOWNLOAD_PATH -executable -type f -print | head -n 1)"

if [ -f "$BIN" ]; then
  cp -f $BIN $INSTALL_PATH
  echo "Latest seaweedfs release downloaded and installed succesfully - try it with 'weed' (in case the binary-name didn't change)."
  exit 0 
else
  echo "Install of seaweedfs wasn't successfull. Check above log for details";
  exit -1
fi
