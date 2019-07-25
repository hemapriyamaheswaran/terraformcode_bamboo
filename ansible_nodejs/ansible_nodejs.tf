resource "openstack_compute_instance_v2" "Ansible_nodejs_centos" {
  name            = "Ansible_nodejs_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_nodejs/ansible_nodejs_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Ansible_nodejs_ubuntu" {
  name            = "Ansible_nodejs_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_nodejs/ansible_nodejs_ubuntu.sh")}"
        }
resource "openstack_compute_instance_v2" "Ansible_nodejs_windows12" {
  name            = "Ansible_nodejs_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_nodejs/ansible_nodejs_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_4" {
    pool = "external_network"
#    address = "192.168.2.123"
    }
resource "openstack_networking_floatingip_v2" "fip_5" {
    pool = "external_network"
#    address = "192.168.2.143"
    }
resource "openstack_networking_floatingip_v2" "fip_6" {
    pool = "external_network"
#    address = "192.168.2.142"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_4" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_4.address}"
  instance_id = "${openstack_compute_instance_v2.Ansible_nodejs_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_5" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_5.address}"
  instance_id = "${openstack_compute_instance_v2.Ansible_nodejs_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_6" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_6.address}"
  instance_id = "${openstack_compute_instance_v2.Ansible_nodejs_windows12.id}"
        }

#resource "null_resource" "Anodejs" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/ansible_nodejs.sh"
#  }
#}

resource "local_file" "Ansible_nodejs_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_4.address}"
  filename = "Ansible_nodejs_centos_ip"
}

resource "local_file" "Ansible_nodejs_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_5.address}"
  filename = "Ansible_nodejs_ubuntu_ip"
}

resource "local_file" "Ansible_nodejs_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_6.address}"
  filename = "Ansible_nodejs_windows_ip"
}

