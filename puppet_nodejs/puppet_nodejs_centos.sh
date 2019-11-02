#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtw6ZBkxQMJ9D99cgSevQ9Pco6oV/aEvRrzdAEh5yLBL36fq+GLo49icTA+U0P0/2NB4atl+Cmwu1EwtPbEB2I1kIUzIjU0/1ksPzl/fH83DxWiXKW2bQ8sAg6JwwvG74w/gUOvB2bRbkIT8ipy5lRIvLmCowAHzOuxyvqGsMmtbGMAf9dY5XqiMqo0TZFl1uJOEve3hmp0hcuOuitEkCWH7t+PC2ZkIuFKaeqNom3jpbwyVRQHgb5nbjduPW5bxLhDH/a2tUZ8asJMibPeE3+k3BTnySSe8jV+jRVKdNl68UMkXZIUJTKn6XLstXPy+kkDKB5icbmyWPrKAFgWleH root@bamboo.zippyops.com" >> /root/.ssh/authorized_keys
echo search zippyops.com > /etc/resolv.conf
echo nameserver 192.168.1.5 >> /etc/resolv.conf
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo 192.168.2.7 puppetserver.zippyops.com >> /etc/hosts
sudo hostnamectl set-hostname puppetcentosbamboonodejs.zippyops.com
sudo setenforce 0
sudo rpm -Uvh https://yum.puppetlabs.com/puppet/el/7/x86_64/puppet-agent-6.4.2-1.el7.x86_64.rpm
sudo yum install puppet-agent -y
echo -e "[main]\nserver=puppetserver.zippyops.com \nreport=true\n" >> /etc/puppetlabs/puppet/puppet.conf
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install ntp -y
sudo systemctl start ntpd
sudo systemctl enable ntpd
/opt/puppetlabs/bin/puppet agent -t
sudo exec bash
