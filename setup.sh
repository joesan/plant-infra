#!/bin/bash
export CURRENT_USER="$USER"
export TECTONIC_LATEST="tectonic_1.8.9-tectonic.2"

# USER_HOME will be set based on the OSTYPE
USER_HOME="/"

# Identify the OSTYPE and set the home directory
case "$OSTYPE" in
  darwin*)  USER_HOME="/Users/${CURRENT_USER}/" ;; 
  linux*)   USER_HOME="/home/${CURRENT_USER}/" ;; 
  # bsd*)     echo "BSD" ;;
  *)        USER_HOME=${pwd} ;;
esac

# Navigate to current users home dir
cd $USER_HOME

# Download Tectonic installer
curl -O https://releases.tectonic.com/releases/${TECTONIC_LATEST}.zip

# Prepare the installation
rm -Rf tectonic/
mkdir tectonic
unzip -d tectonic/ ${TECTONIC_LATEST}.zip

# Set terraform in the PATH
export PATH=$PATH:$USER_HOME/tectonic/${TECTONIC_LATEST}/tectonic-installer/linux

