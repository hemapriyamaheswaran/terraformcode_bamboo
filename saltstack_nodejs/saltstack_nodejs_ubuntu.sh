#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzjknXyU8rT0u6nZPUwOb3Bz8xMn+v6VUBvgOXmui9M7Fc97VFDvLqp5riCel348vWD2KgVBQVOc01+0JFBQfG+NTzXMHPG57Swujsj4b2SKyA/3+/SR9+8KJi0AH6dfyOdhVyeW3D6s7rxjhElK/EF5Q19RyVNUPQ4DNLGLzq2wpBl7agg71eS8Eh2OaueqdZzGNSoN5npn21hA/CwxNhLlAkdF62JtbK/Ox2WzO91CQ0Qloy05MhS5qUd72KlImIC99Sffi9FtVFDRC2uxzPhMJXZpkLP02uEdvj5S2vFMb5kPzfzrR+DZDyVsx3n10bB5jmhedc4+KzsmGwaJhh jenkins@jenkin.zippyops.com" >> /root/.ssh/authorized_keys
echo search zippyops.com > /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo nameserver 192.168.0.1 >> /etc/resolv.conf
sudo hostnamectl set-hostname saltstackubuntunodejs.zippyops.com
apt-get update 
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo setenforce 0
sudo timedatectl set-timezone Asia/Kolkata
sudo apt-get install ntp -y
sudo systemctl start ntp
sudo systemctl enable ntp
sudo exec bash
wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main" >> /etc/apt/sources.list.d/saltstack.list
apt-get update -y
apt-get install salt-minion -y
sed -i --follow-symlinks 's/#master: salt/master: 10.0.0.27/g' /etc/salt/minion
echo "saltstackubuntunodejs.zippyops.com" > /etc/salt/minion_id
systemctl restart salt-minion
