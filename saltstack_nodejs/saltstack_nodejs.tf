resource "openstack_compute_instance_v2" "Bamboo_saltstack_nodejs_centos" {
  name            = "Bamboo_saltstack_nodejs_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_nodejs/saltstack_nodejs_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_saltstack_nodejs_ubuntu" {
  name            = "Bamboo_saltstack_nodejs_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_nodejs/saltstack_nodejs_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_saltstack_nodejs_windows12" {
  name            = "Bamboo_saltstack_nodejs_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_nodejs/saltstack_nodejs_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_35" {
    pool = "external_network"
#    address = "192.168.2.124"
    }

resource "openstack_networking_floatingip_v2" "fip_36" {
    pool = "external_network"
#    address = "192.168.2.118"
    }

resource "openstack_networking_floatingip_v2" "fip_37" {
    pool = "external_network"
#    address = "192.168.2.139"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_35" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_35.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_nodejs_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_36" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_36.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_nodejs_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_37" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_37.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_saltstack_nodejs_windows12.id}"
        }

#resource "null_resource" "Ajava" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/ansible_java.sh"
#  }
#}

resource "local_file" "saltstack_nodejs_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_35.address}"
  filename = "saltstack_nodejs_centos_ip"
}

resource "local_file" "saltstack_nodejs_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_36.address}"
  filename = "saltstack_nodejs_ubuntu_ip"
}

resource "local_file" "saltstack_nodejs_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_37.address}"
  filename = "saltstack_nodejs_windows_ip"
}

