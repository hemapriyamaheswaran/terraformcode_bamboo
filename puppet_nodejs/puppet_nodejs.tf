resource "openstack_compute_instance_v2" "puppet_nodejs_centos" {
 name            = "puppet_nodejs_centos"
 image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
 flavor_id       = "9"
 key_pair        = "centos"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("puppet_nodejs/puppet_nodejs_centos.sh")}"
        }
resource "openstack_compute_instance_v2" "puppet_nodejs_ubuntu" {
 name            = "puppet_nodejs_ubuntu"
 image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
 flavor_id       = "9"
 key_pair        = "centos"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("puppet_nodejs/puppet_nodejs_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "puppet_nodejs_windows" {
 name            = "puppet_nodejs_windows"
 image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
 flavor_id       = "8"
 admin_pass      = "2!ppy0ps"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("puppet_nodejs/puppet_nodejs_windows.ps1")}"
        }
  resource "openstack_networking_floatingip_v2" "fip_22" {
    pool = "external_network"
#    address = "192.168.2.136"
    }
  resource "openstack_networking_floatingip_v2" "fip_23" {
    pool = "external_network"
#    address = "192.168.2.137"
    }
  resource "openstack_networking_floatingip_v2" "fip_24" {
    pool = "external_network"
#    address = "192.168.2.144"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_22" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_22.address}"
  instance_id = "${openstack_compute_instance_v2.puppet_nodejs_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_23" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_23.address}"
  instance_id = "${openstack_compute_instance_v2.puppet_nodejs_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_24" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_24.address}"
  instance_id = "${openstack_compute_instance_v2.puppet_nodejs_windows.id}"
        }

#resource "null_resource" "Pnodejs" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/puppet_nodejs.sh"
#  }
#}

resource "local_file" "Puppet_nodejs_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_22.address}"
  filename = "Puppet_nodejs_centos_ip"
}

resource "local_file" "Puppet_nodejs_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_23.address}"
  filename = "Puppet_nodejs_ubuntu_ip"
}

resource "local_file" "Puppet_nodejs_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_24.address}"
  filename = "Puppet_nodejs_windows_ip"
}

