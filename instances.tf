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
module "pePuppet_php" {
  source = "pepuppet_php"
}

module "Puppet_dotnet" {
  source = "puppet_dotnet"
}

module "Ansible_dotnet" {
  source = "ansible_dotnet"
}

module "Chef_dotnet" {
  source = "chef_dotnet"
}

module "Saltstack_java" {
  source = "saltstack_java"
}

module "Saltstack_nodejs" {
  source = "saltstack_nodejs"
}

module "Saltstack_php" {
  source = "saltstack_php"
}

module "Saltstack_dotnet" {
  source = "saltstack_dotnet"
}


module "pePuppet_java" {
  source = "pepuppet_java"
}

module "pePuppet_nodejs" {
  source = "pepuppet_nodejs"
}


module "pePuppet_dotnet" {
  source = "pepuppet_dotnet"
}

module "Puppet_php" {
  source = "puppet_php"
}

