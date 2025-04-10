# set user name
$user = "user"
# path to downlads folder
$dl = "env:USERPROFILE\Downloads"
# path to MFL network drive
Write-Host "Starting setup on $env:COMPUTERNAME..." -ForegroundColor Cyan

# Enable PSRemoting
Write-Host "Enabling PowerShell Remoting..." -ForegroundColor Yellow
Enable-PSRemoting -Force

#Add user to "Remote Management Users" group
Write-Host "Adding $user to Remote Management Users group..." -ForegroundColor Yellow
Add-LocalGroupMember -Group "Remote Management Users" -Member $user

# Ensure WinRM service is enabled and running
Write-Host "Configuring WinRM service..." -ForegroundColor Yellow
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM

# Allow inbound WinRM traffic in the firewall
Write-Host "Configuring Windows Firewall for remote access..." -ForegroundColor Yellow
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=Yes

# Allow ICMP (ping) in firewall
Write-Host "Allowing Ping requests in Windows Firewall..." -ForegroundColor Yellow
netsh advfirewall firewall add rule name="Allow Ping" protocol=ICMPv4 dir=in action=allow


# Remove password expiration
Write-Host "Removing Password expiration..." -ForegroundColor Yellow
net accounts /maxpwage:unlimited

#Clear downloads folder
Write-Host "Cleaning downloads Folder" -ForegroundColor Yellow
rm $dl\* -Force

# Copy Everything From the \installers folder to \downloads folder
cp Z:\installers $dl

