resource "openstack_compute_instance_v2" "chef_java_centos" {
  name            = "chef_java_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data          = "${file("chef_java/chef_java_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "chef_java_ubuntu" {
  name            = "chef_java_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_java/chef_java_ubuntu.sh")}"
        }
resource "openstack_compute_instance_v2" "chef_java_windows" {
  name            = "chef_java_windows"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_java/chef_java_windows.ps1")}"
        }

  resource "openstack_networking_floatingip_v2" "fip_10" {
    pool = "external_network"
#    address = "192.168.2.107"
    }
 resource "openstack_networking_floatingip_v2" "fip_11" {
    pool = "external_network"
#    address = "192.168.2.102"
    }

  resource "openstack_networking_floatingip_v2" "fip_12" {
    pool = "external_network"
#    address = "192.168.2.106"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_10" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_10.address}"
  instance_id = "${openstack_compute_instance_v2.chef_java_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_11" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_11.address}"
  instance_id = "${openstack_compute_instance_v2.chef_java_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_12" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_12.address}"
  instance_id = "${openstack_compute_instance_v2.chef_java_windows.id}"
        }

#resource "null_resource" "Cjava" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/chef_java.sh"
#  }
#}

resource "local_file" "Chef_java_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_10.address}"
  filename = "Chef_java_centos_ip"
}

resource "local_file" "Chef_java_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_11.address}"
  filename = "Chef_java_ubuntu_ip"
}

resource "local_file" "Chef_java_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_12.address}"
  filename = "Chef_java_windows_ip"
}

