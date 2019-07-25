#!/bin/bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzjknXyU8rT0u6nZPUwOb3Bz8xMn+v6VUBvgOXmui9M7Fc97VFDvLqp5riCel348vWD2KgVBQVOc01+0JFBQfG+NTzXMHPG57Swujsj4b2SKyA/3+/SR9+8KJi0AH6dfyOdhVyeW3D6s7rxjhElK/EF5Q19RyVNUPQ4DNLGLzq2wpBl7agg71eS8Eh2OaueqdZzGNSoN5npn21hA/CwxNhLlAkdF62JtbK/Ox2WzO91CQ0Qloy05MhS5qUd72KlImIC99Sffi9FtVFDRC2uxzPhMJXZpkLP02uEdvj5S2vFMb5kPzfzrR+DZDyVsx3n10bB5jmhedc4+KzsmGwaJhh jenkins@jenkin.zippyops.com" >> /root/.ssh/authorized_keys
echo nameserver 192.168.0.1 >> /etc/resolv.conf
echo nameserver 192.168.1.4 >> /etc/resolv.conf
echo 192.168.2.6 puppetmaster.zippyops.com >> /etc/hosts
sudo hostnamectl set-hostname puppetcentosphp.zippyops.com
sudo setenforce 0
export PATH=/opt/puppetlabs/bin:$PATH
export MANPATH=/opt/puppetlabs/client/tools/share/man:$MANPATH
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install ntp -y
sudo systemctl start ntpd
sudo systemctl enable ntpd
curl -k https://puppetmaster.zippyops.com:8140/packages/current/install.bash | sudo bash
sudo exec bash
