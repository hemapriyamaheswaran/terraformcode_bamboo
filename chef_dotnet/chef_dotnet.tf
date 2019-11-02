resource "openstack_compute_instance_v2" "Bamboo_chef_dotnet_windows" {
  name            = "Bamboo_chef_dotnet_windows"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","chef"]
  user_data      = "${file("chef_dotnet/chef_dotnet_windows.ps1")}"
        }

 resource "openstack_networking_floatingip_v2" "fip_30" {
    pool = "external_network"
#    address = "192.168.2.133"
    }


resource "openstack_compute_floatingip_associate_v2" "fip_30" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_30.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_chef_dotnet_windows.id}"
}

resource "local_file" "Chef_dotnet_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_30.address}"
  filename = "Chef_dotnet_windows_ip"
}

