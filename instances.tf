provider "openstack" {
  user_name   = "zippyops"
  tenant_name = "internal"
  password    = "zippyops"
  auth_url    = "http://192.168.1.200:5000/v3"
  region      = "RegionOne"

        }

module "Ansible_java" {
  source = "ansible_java"
}
module "Ansible_nodejs" {
  source = "ansible_nodejs"
}
module "Ansible_php" {
  source = "ansible_php"
}

module "Chef_java" {
  source = "chef_java"
}
module "Chef_nodejs" {
  source = "chef_nodejs"
}
module "Chef_php" {
  source = "chef_php"
}

module "Puppet_java" {
  source = "puppet_java"
}
module "Puppet_nodejs" {
  source = "puppet_nodejs"
}
module "Puppet_php" {
  source = "puppet_php"
}

