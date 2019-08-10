#!/bin/bash
echo search zippyops.com > /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo nameserver 192.168.0.1 >> /etc/resolv.conf
sudo hostnamectl set-hostname saltstackcentosphp.zippyops.com
sudo exec bash
sudo setenforce 0
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install ntp -y
sudo systemctl start ntpd
sudo systemctl enable ntpd
sudo yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm -y
sudo yum install salt-minion -y
sed -i --follow-symlinks 's/#master: salt/master: 10.0.0.27/g' /etc/salt/minion
echo "saltstackcentosphp.zippyops.com" > /etc/salt/minion_id
systemctl start salt-minion.service
systemctl enable salt-minion.service
