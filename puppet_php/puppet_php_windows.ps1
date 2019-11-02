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
Add-content -Path C:\Windows\System32\drivers\etc\hosts. -value "192.168.2.7 puppetserver.zippyops.com"
$url = "http://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
$output = "C:\puppet-agent-1.9.3-x86.msi"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
msiexec /qn /norestart /i C:\puppet-agent-1.9.3-x86.msi PUPPET_MASTER_SERVER=puppetserver.zippyops.com
</powershell>

