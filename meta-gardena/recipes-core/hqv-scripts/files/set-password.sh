#!/bin/sh
set -eu
USER_NAME=$1
NEW_PASSWORD=$2

# remove any backup files or it will block passwd command
sudo rm -f /etc/shadow+
sudo rm -f /etc/shadow-
sudo rm -f /etc/passwd+
sudo rm -f /etc/passwd-

sudo chpasswd <<EOF
${USER_NAME}:${NEW_PASSWORD}
EOF
