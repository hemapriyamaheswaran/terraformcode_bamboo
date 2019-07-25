#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzjknXyU8rT0u6nZPUwOb3Bz8xMn+v6VUBvgOXmui9M7Fc97VFDvLqp5riCel348vWD2KgVBQVOc01+0JFBQfG+NTzXMHPG57Swujsj4b2SKyA/3+/SR9+8KJi0AH6dfyOdhVyeW3D6s7rxjhElK/EF5Q19RyVNUPQ4DNLGLzq2wpBl7agg71eS8Eh2OaueqdZzGNSoN5npn21hA/CwxNhLlAkdF62JtbK/Ox2WzO91CQ0Qloy05MhS5qUd72KlImIC99Sffi9FtVFDRC2uxzPhMJXZpkLP02uEdvj5S2vFMb5kPzfzrR+DZDyVsx3n10bB5jmhedc4+KzsmGwaJhh jenkins@jenkin.zippyops.com" >> /root/.ssh/authorized_keys
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo 192.168.2.7 puppetserver.zippyops.com >> /etc/hosts
sudo apt-get update -y
sudo hostnamectl set-hostname puppetubuntunodejs.zippyops.com
sudo timedatectl set-timezone Asia/Kolkata
sudo apt-get install ntp -y
sudo systemctl start ntp
sudo systemctl enable ntp
sudo wget https://apt.puppetlabs.com/puppet6-release-xenial.deb
sudo dpkg -i puppet6-release-xenial.deb
sudo apt-get update -y
sudo apt-get install puppet-agent -y
echo -e "[main]\nserver=puppetserver.zippyops.com \nreport=true\n" >> /etc/puppetlabs/puppet/puppet.conf
/opt/puppetlabs/bin/puppet agent -t
exec bash
