resource "openstack_compute_instance_v2" "Bamboo_saltstack_php_centos" {
  name            = "Bamboo_saltstack_php_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_php/saltstack_php_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_saltstack_php_ubuntu" {
  name            = "Bamboo_saltstack_php_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_php/saltstack_php_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_saltstack_php_windows12" {
  name            = "Bamboo_saltstack_php_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_php/saltstack_php_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_38" {
    pool = "external_network"
#    address = "192.168.2.124"
    }

resource "openstack_networking_floatingip_v2" "fip_39" {
    pool = "external_network"
#    address = "192.168.2.118"
    }

resource "openstack_networking_floatingip_v2" "fip_40" {
    pool = "external_network"
#    address = "192.168.2.139"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_38" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_38.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_php_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_39" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_39.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_php_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_40" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_40.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_php_windows12.id}"
        }

#resource "null_resource" "Ajava" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/ansible_java.sh"
#  }
#}

resource "local_file" "saltstack_php_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_38.address}"
  filename = "saltstack_php_centos_ip"
}

resource "local_file" "saltstack_php_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_39.address}"
  filename = "saltstack_php_ubuntu_ip"
}

resource "local_file" "saltstack_php_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_40.address}"
  filename = "saltstack_php_windows_ip"
}

