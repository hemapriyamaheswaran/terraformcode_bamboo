resource "openstack_compute_instance_v2" "Bamboo_Ansible_dotnet_windows12" {
  name            = "Bamboo_Ansible_dotnet_windows12"
  image_id        = "4471ea20-4caf-46e9-910d-85421a56426d"
  flavor_id       = "8"
  admin_pass      = "2!ppy0ps"
  security_groups = ["default","Ansible"]
  user_data       = "${file("ansible_dotnet/ansible_dotnet_windows.ps1")}"
        }

resource "openstack_networking_floatingip_v2" "fip_29" {
    pool = "external_network"
#    address = "192.168.2.142"
    }

resource "openstack_compute_floatingip_associate_v2" "fip_29" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_29.address}"
  instance_id = "${openstack_compute_instance_v2.Bamboo_Ansible_dotnet_windows12.id}"
        }

resource "local_file" "Ansible_dotnet_windows_ip" {
  content  = "${openstack_networking_floatingip_v2.fip_29.address}"
  filename = "Ansible_dotnet_windows_ip"
}

