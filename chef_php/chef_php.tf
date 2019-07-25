resource "openstack_compute_instance_v2" "chef_php_centos" {
  name            = "chef_php_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data          = "${file("chef_php/chef_php_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "chef_php_ubuntu" {
  name            = "chef_php_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_php/chef_php_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "chef_php_windows" {
  name            = "chef_php_windows"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_php/chef_php_windows.ps1")}"
        }
  resource "openstack_networking_floatingip_v2" "fip_16" {
    pool = "external_network"
#    address = "192.168.2.119"
    }
  resource "openstack_networking_floatingip_v2" "fip_17" {
    pool = "external_network"
#    address = "192.168.2.116"
    }
  resource "openstack_networking_floatingip_v2" "fip_18" {
    pool = "external_network"
#    address = "192.168.2.135"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_16" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_16.address}"
  instance_id = "${openstack_compute_instance_v2.chef_php_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_17" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_17.address}"
  instance_id = "${openstack_compute_instance_v2.chef_php_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_18" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_18.address}"
  instance_id = "${openstack_compute_instance_v2.chef_php_windows.id}"
        }

#resource "null_resource" "Cphp" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/chef_php.sh"
#  }
#}

resource "local_file" "Chef_php_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_16.address}"
  filename = "Chef_php_centos_ip"
}

resource "local_file" "Chef_php_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_17.address}"
  filename = "Chef_php_ubuntu_ip"
}

resource "local_file" "Chef_php_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_18.address}"
  filename = "Chef_php_windows_ip"
}




