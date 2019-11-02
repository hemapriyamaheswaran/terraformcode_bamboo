resource "openstack_compute_instance_v2" "Bamboo_pepuppet_dotnet_windows" {
 name            = "Bam_pepuppet_dotnet_windows"
 image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
 flavor_id       = "8"
 admin_pass      = "2!ppy0ps"
 security_groups = ["default","puppet-ports"]
 user_data          = "${file("pepuppet_dotnet/pepuppet_dotnet_windows.ps1")}"
        }

  resource "openstack_networking_floatingip_v2" "fip_28" {
    pool = "external_network"
#    address = "192.168.2.144"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_28" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_28.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_pepuppet_dotnet_windows.id}"
        }

resource "local_file" "pePuppet_dotnet_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_28.address}"
  filename = "pePuppet_dotnet_windows_ip"
}

