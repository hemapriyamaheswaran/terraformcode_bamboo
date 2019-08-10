resource "openstack_compute_instance_v2" "saltstack_java_centos" {
  name            = "saltstack_java_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_java/saltstack_java_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "saltstack_java_ubuntu" {
  name            = "saltstack_java_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_java/saltstack_java_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "saltstack_java_windows12" {
  name            = "saltstack_java_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_java/saltstack_java_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_32" {
    pool = "external_network"
#    address = "192.168.2.124"
    }

resource "openstack_networking_floatingip_v2" "fip_33" {
    pool = "external_network"
#    address = "192.168.2.118"
    }

resource "openstack_networking_floatingip_v2" "fip_34" {
    pool = "external_network"
#    address = "192.168.2.139"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_32" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_32.address}"
  instance_id = "${openstack_compute_instance_v2.saltstack_java_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_33" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_33.address}"
  instance_id = "${openstack_compute_instance_v2.saltstack_java_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_34" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_34.address}"
  instance_id = "${openstack_compute_instance_v2.saltstack_java_windows12.id}"
        }

#resource "null_resource" "Ajava" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/ansible_java.sh"
#  }
#}

resource "local_file" "saltstack_java_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_32.address}"
  filename = "saltstack_java_centos_ip"
}

resource "local_file" "saltstack_java_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_33.address}"
  filename = "saltstack_java_ubuntu_ip"
}

resource "local_file" "saltstack_java_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_34.address}"
  filename = "saltstack_java_windows_ip"
}

