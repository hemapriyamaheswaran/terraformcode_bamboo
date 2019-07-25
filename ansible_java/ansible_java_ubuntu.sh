#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzjknXyU8rT0u6nZPUwOb3Bz8xMn+v6VUBvgOXmui9M7Fc97VFDvLqp5riCel348vWD2KgVBQVOc01+0JFBQfG+NTzXMHPG57Swujsj4b2SKyA/3+/SR9+8KJi0AH6dfyOdhVyeW3D6s7rxjhElK/EF5Q19RyVNUPQ4DNLGLzq2wpBl7agg71eS8Eh2OaueqdZzGNSoN5npn21hA/CwxNhLlAkdF62JtbK/Ox2WzO91CQ0Qloy05MhS5qUd72KlImIC99Sffi9FtVFDRC2uxzPhMJXZpkLP02uEdvj5S2vFMb5kPzfzrR+DZDyVsx3n10bB5jmhedc4+KzsmGwaJhh jenkins@jenkin.zippyops.com" >> /root/.ssh/authorized_keys
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo 192.168.2.9 ansibletower.zippyops.com >> /etc/hosts
sudo hostnamectl set-hostname ansibleubuntujava.zippyops.com
apt-get update 
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo setenforce 0
sudo timedatectl set-timezone Asia/Kolkata
sudo apt-get install ntp -y
sudo systemctl start ntp
sudo systemctl enable ntp
sudo exec bash
