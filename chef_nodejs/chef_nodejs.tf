resource "openstack_compute_instance_v2" "Bamboo_chef_nodejs_centos" {
  name            = "Bamboo_chef_nodejs_centos"
  image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data          = "${file("chef_nodejs/chef_nodejs_centos.sh")}"
        }
resource "openstack_compute_instance_v2" "Bamboo_chef_nodejs_ubuntu" {
  name            = "Bamboo_chef_nodejs_ubuntu"
  image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
  flavor_id       = "9"
  key_pair        = "centos"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_nodejs/chef_nodejs_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_chef_nodejs_windows" {
  name            = "Bamboo_chef_nodejs_windows"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_nodejs/chef_nodejs_windows.ps1")}"
        }

  resource "openstack_networking_floatingip_v2" "fip_13" {
    pool = "external_network"
#    address = "192.168.2.131"
    }
  resource "openstack_networking_floatingip_v2" "fip_14" {
    pool = "external_network"
#    address = "192.168.2.132"
    }
 resource "openstack_networking_floatingip_v2" "fip_15" {
    pool = "external_network"
#    address = "192.168.2.133"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_13" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_13.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_chef_nodejs_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_14" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_14.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_chef_nodejs_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_15" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_15.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_chef_nodejs_windows.id}"
}

#resource "null_resource" "Cnodejs" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/chef_nodejs.sh"
#  }
#}

resource "local_file" "Chef_nodejs_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_13.address}"
  filename = "Chef_nodejs_centos_ip"
}

resource "local_file" "Chef_nodejs_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_14.address}"
  filename = "Chef_nodejs_ubuntu_ip"
}

resource "local_file" "Chef_nodejs_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_15.address}"
  filename = "Chef_nodejs_windows_ip"
}

