resource "openstack_compute_instance_v2" "Bamboo_pepuppet_java_centos" {
  name            = "Bamboo_pepuppet_java_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","puppet-ports"]
  user_data          = "${file("pepuppet_java/pepuppet_java_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_pepuppet_java_ubuntu" {
  name            = "Bamboo_pepuppet_java_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","puppet-ports"]
  user_data      = "${file("pepuppet_java/pepuppet_java_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_pepuppet_java_windows" {
  name            = "Bam_pepuppet_java_windows"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  security_groups = ["default","puppet-ports"]
  user_data      = "${file("pepuppet_java/pepuppet_java_windows.ps1")}"
                }

  resource "openstack_networking_floatingip_v2" "fip_25" {
    pool = "external_network"
#    address = "192.168.2.125"
    }
  resource "openstack_networking_floatingip_v2" "fip_26" {
    pool = "external_network"
#    address = "192.168.2.105"
    }
  resource "openstack_networking_floatingip_v2" "fip_27" {
    pool = "external_network"
#   address = "192.168.2.117"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_25" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_25.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_pepuppet_java_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_26" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_26.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_pepuppet_java_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_27" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_27.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_pepuppet_java_windows.id}"
        }

#resource "null_resource" "Pphp" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/puppet_php.sh"
#  }
#}

resource "local_file" "pePuppet_java_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_25.address}"
  filename = "pePuppet_java_centos_ip"
}

resource "local_file" "pePuppet_java_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_26.address}"
  filename = "pePuppet_java_ubuntu_ip"
}

resource "local_file" "pePuppet_java_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_27.address}"
  filename = "pePuppet_java_windows_ip"
}
