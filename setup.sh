#!/bin/bash
export CURRENT_USER="$USER"
export TECTONIC_LATEST_ZIP="tectonic_1.8.9-tectonic.2.zip"
export TECTONIC_INSTALLER_PATH=${pwd}

# USER_HOME will be set based on the OSTYPE
USER_HOME="/"

# Identify the OSTYPE and set the home directory
case "$OSTYPE" in
  darwin*)  USER_HOME="/Users/${CURRENT_USER}/" ;; 
  linux*)   echo "LINUX" ;;
  # bsd*)     echo "BSD" ;;
  # msys*)    echo "WINDOWS" ;;
  # *)        echo "unknown: $OSTYPE" ;;
esac

# Prepare the tectonic installer
cd $USER_HOME

# Download Tectonic installer
curl -O https://releases.tectonic.com/releases/${TECTONIC_LATEST_ZIP}
curl -O https://releases.tectonic.com/releases/${TECTONIC_LATEST_ZIP}.sig

# Verify if the download is valid
gpg2 --keyserver pgp.mit.edu --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
gpg2 --verify ${TECTONIC_LATEST_ZIP}.sig $TECTONIC_LATEST_ZIP

rm -Rf tectonic/
mkdir tectonic
unzip -d tectonic/ /${TECTONIC_LATEST_ZIP}

