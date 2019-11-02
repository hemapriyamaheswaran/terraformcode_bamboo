#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtw6ZBkxQMJ9D99cgSevQ9Pco6oV/aEvRrzdAEh5yLBL36fq+GLo49icTA+U0P0/2NB4atl+Cmwu1EwtPbEB2I1kIUzIjU0/1ksPzl/fH83DxWiXKW2bQ8sAg6JwwvG74w/gUOvB2bRbkIT8ipy5lRIvLmCowAHzOuxyvqGsMmtbGMAf9dY5XqiMqo0TZFl1uJOEve3hmp0hcuOuitEkCWH7t+PC2ZkIuFKaeqNom3jpbwyVRQHgb5nbjduPW5bxLhDH/a2tUZ8asJMibPeE3+k3BTnySSe8jV+jRVKdNl68UMkXZIUJTKn6XLstXPy+kkDKB5icbmyWPrKAFgWleH root@bamboo.zippyops.com" >> /root/.ssh/authorized_keys
echo search zippyops.com > /etc/resolv.conf
echo nameserver 192.168.1.5 >> /etc/resolv.conf
echo nameserver 192.168.0.1 >> /etc/resolv.conf
sudo hostnamectl set-hostname saltstackubuntubamboophp.zippyops.com
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
echo "saltstackubuntubamboophp.zippyops.com" > /etc/salt/minion_id
systemctl restart salt-minion

