<powershell>
Set-ExecutionPolicy unrestricted -scope Process -Force
NET USER demo "2!ppy0ps" /ADD
NET LOCALGROUP "Administrators" "demo" /ADD
netsh interface ip set dns "Ethernet" static 192.168.0.1
netsh advfirewall set allprofiles state off
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
tzutil /s "India Standard Time"
Add-content -Path C:\Windows\System32\drivers\etc\hosts. -value "192.168.2.6 puppetmaster.zippyops.com"
[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; $webClient = New-Object System.Net.WebClient; $webClient.DownloadFile('https://puppetmaster.zippyops.com:8140/packages/current/install.ps1', 'install.ps1'); .\install.ps1 -v
</powershell>

