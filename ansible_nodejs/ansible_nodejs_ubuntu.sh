#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkMCCQV+xKncZBunhMcw1FKBHwvLmo9Ga8UnUWIZQvV0eZ0miI9ubOgKRCijbVIEkA8+kuWaAC0MSySY/HPVOq8xf6DksKla4PPA/oDiQln3HqiKlreKmws5AJ8YFOba9fap7tsfbZMQLFpQ0vYr3vcAVPBD7+tbWz76aY65T0Wt2cm2vB8+6xEnP+yJ4pP/2DxTjXeC63LJRDHjvbMtlFBpU5Qo5VC9etKdyIZzvKkLlH/zuFd8km5RmyT7EkTgDKqjSizewBKhTR00Z5woTkUY2XaGnIhap9sAdx+yqcgn9AilYjYPb3Ee8nLRt+cY80vZgThcIwKufIykHFLULH jenkins@jenkins.zippyops.com" >> /root/.ssh/authorized_keys
echo search zippyops.com > /etc/resolv.conf
echo nameserver 192.168.1.5 >> /etc/resolv.conf
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo 192.168.2.9 ansibletower.zippyops.com >> /etc/hosts
sudo hostnamectl set-hostname bambooansibleubuntunodejs.zippyops.com
apt-get update 
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo setenforce 0
sudo timedatectl set-timezone Asia/Kolkata
sudo apt-get install ntp -y
sudo systemctl start ntp
sudo systemctl enable ntp
sudo exec bash
