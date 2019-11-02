resource "openstack_compute_instance_v2" "Bamboo_puppet_java_centos" {
 name            = "Bamboo_puppet_java_centos"
 image_id        = "195be94b-4626-45ce-b331-511691cc1a57"
 flavor_id       = "9"
 key_pair        = "centos"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("/home/centos/Openstack_Terraform/bamboo_single_terraform_poc_module/puppet_java/puppet_java_centos.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_puppet_java_ubuntu" {
 name            = "Bamboo_puppet_java_ubuntu"
 image_id        = "b3f2ca8b-689d-4bca-921d-73d5f219d86a"
 flavor_id       = "9"
 key_pair        = "centos"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("/home/centos/Openstack_Terraform/bamboo_single_terraform_poc_module/puppet_java/puppet_java_ubuntu.sh")}"
        }

resource "openstack_compute_instance_v2" "Bamboo_puppet_java_windows" {
 name            = "Bamboo_puppet_java_windows"
 image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
 flavor_id       = "8"
 admin_pass      = "2!ppy0ps"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("puppet_java/puppet_java_windows.ps1")}"
        }

  resource "openstack_networking_floatingip_v2" "fip_19" {
    pool = "external_network"
#    address = "192.168.2.104"
    }
  resource "openstack_networking_floatingip_v2" "fip_20" {
    pool = "external_network"
#    address = "192.168.2.122"
    }
  resource "openstack_networking_floatingip_v2" "fip_21" {
    pool = "external_network"
#    address = "192.168.2.113"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_19" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_19.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_puppet_java_centos.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_20" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_20.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_puppet_java_ubuntu.id}"
        }

resource "openstack_compute_floatingip_associate_v2" "fip_21" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_21.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_puppet_java_windows.id}"
        }

#resource "null_resource" "Pjava" {
#  provisioner "local-exec" {
#    command = "sleep 600 && /root/puppet_java.sh"
#  }
#}

resource "local_file" "Puppet_java_centos_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_19.address}"
  filename = "Puppet_java_centos_ip"
}

resource "local_file" "Puppet_java_ubuntu_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_20.address}"
  filename = "Puppet_java_ubuntu_ip"
}

resource "local_file" "Puppet_java_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_21.address}"
  filename = "Puppet_java_windows_ip"
}


