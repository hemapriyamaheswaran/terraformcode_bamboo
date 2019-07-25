<powershell>
Set-ExecutionPolicy unrestricted -scope Process -Force
NET USER demo "2!ppy0ps" /ADD
NET LOCALGROUP "Administrators" "demo" /ADD
netsh int ip set dns "Ethernet" static 192.168.0.1
netsh advfirewall set allprofiles state off
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
tzutil /s "India Standard Time"
winrm quickconfig -q
Set-NetConnectionProfile -NetworkCategory private
Add-content -Path C:\Windows\System32\drivers\etc\hosts. -value "192.168.1.127 puppetserver.zippyops.com"
Add-content -Path C:\Windows\System32\drivers\etc\hosts. -value "192.168.2.10 chefserver.zippyops.com"
$url = "http://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
$output = "C:\puppet-agent-x64-latest.msi"
</powershell>
