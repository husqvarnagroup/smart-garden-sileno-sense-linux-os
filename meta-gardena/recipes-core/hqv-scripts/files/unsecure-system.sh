#!/bin/sh

sudo systemctl enable --now sshd.socket

sudo sh -c 'echo 1 > /etc/developer_mode'

sudo systemctl unmask getty@tty1.service
sudo systemctl enable getty@tty1.service
sudo systemctl start getty@tty1.service

sudo systemctl unmask serial-getty@ttyS0.service
sudo systemctl enable serial-getty@ttyS0.service
sudo systemctl start serial-getty@ttyS0.service

sudo sync
