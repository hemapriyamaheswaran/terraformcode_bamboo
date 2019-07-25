#!/bin/bash
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo 192.168.2.9 ansibletower.zippyops.com >> /etc/hosts
sudo hostnamectl set-hostname ansibleubuntuphp.zippyops.com
sudo setenforce 0
sudo timedatectl set-timezone Asia/Kolkata
sudo apt-get install ntp -y
sudo systemctl start ntp
sudo systemctl enable ntp
sudo exec bash
