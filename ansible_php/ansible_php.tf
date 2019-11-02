resource "openstack_compute_instance_v2" "Bamboo_Ansible_php_centos" {
  name            = "Bamboo_Ansible_php_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_php/ansible_php_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_Ansible_php_ubuntu" {
  name            = "Bamboo_Ansible_php_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_php/ansible_php_ubuntu.sh")}"
        }
resource "openstack_compute_instance_v2" "Bamboo_Ansible_php_windows12" {
  name            = "Bamboo_Ansible_php_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "9"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_php/ansible_php_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_7" {
    pool = "external_network"
#    address = "192.168.2.110"
    }
resource "openstack_networking_floatingip_v2" "fip_8" {
    pool = "external_network"
#    address = "192.168.2.121"
    }

resource "openstack_networking_floatingip_v2" "fip_9" {
    pool = "external_network"
#   address = "192.168.2.126"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_7" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_7.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_Ansible_php_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_8" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_8.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_Ansible_php_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_9" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_9.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_Ansible_php_windows12.id}"
        }
#resource "null_resource" "Aphp" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/ansible_php.sh"
#  }
#}

resource "local_file" "Ansible_php_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_7.address}"
  filename = "Ansible_php_centos_ip"
}

resource "local_file" "Ansible_php_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_8.address}"
  filename = "Ansible_php_ubuntu_ip"
}

resource "local_file" "Ansible_php_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_9.address}"
  filename = "Ansible_php_windows_ip"
}

