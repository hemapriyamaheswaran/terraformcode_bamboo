<script>
Set-ExecutionPolicy unrestricted -scope Process -Force 
NET USER demo "2!ppy0ps" /ADD
NET LOCALGROUP "Administrators" "demo" /ADD
netsh int ip set dns "Ethernet" static 192.168.0.1
netsh advfirewall set allprofiles state off
tzutil /s "India Standard Time"
winrm quickconfig -q
Set-NetConnectionProfile –NetworkCategory private
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
</script>
