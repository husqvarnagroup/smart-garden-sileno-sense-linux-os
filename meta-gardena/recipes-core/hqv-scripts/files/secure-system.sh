#!/bin/sh

sudo systemctl disable --now sshd.socket
sudo systemctl stop 'sshd@*.service'

sudo sh -c 'echo 0 > /etc/developer_mode'

sudo systemctl mask getty@tty1.service
sudo systemctl stop getty@tty1.service

sudo systemctl mask serial-getty@ttyS0.service
sudo systemctl stop serial-getty@ttyS0.service

sudo sync
