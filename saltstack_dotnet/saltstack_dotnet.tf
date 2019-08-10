resource "openstack_compute_instance_v2" "saltstack_dotnet_windows12" {
  name            = "saltstack_dotnet_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Saltstack"]
  user_data       = "${file("saltstack_dotnet/saltstack_dotnet_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_31" {
    pool = "external_network"
#    address = "192.168.2.139"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_31" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_31.address}"
  instance_id = "${openstack_compute_instance_v2.saltstack_dotnet_windows12.id}"
        }

resource "local_file" "saltstack_dotnet_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_31.address}"
  filename = "saltstack_dotnet_windows_ip"
}

