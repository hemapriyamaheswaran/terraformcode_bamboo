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
$url = "https://repo.saltstack.com/windows/Salt-Minion-2019.2.0-Py2-AMD64-Setup.exe"
$output = "C:\Salt-Minion-2019.2.0-Py2-AMD64-Setup.exe"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath C:\Salt-Minion-2019.2.0-Py2-AMD64-Setup.exe -ArgumentList "/S /master=10.0.0.27 /minion-name=saltstackwindowsphp.zippyops.com"
</powershell>
