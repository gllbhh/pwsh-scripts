# Remote Administration for Mobile Fab Lab laptops

#

To manage laptops remotely, PowerShell Remoting must be enabled on each device (needed to be done only once):

```PowerShell
Enable-PSRemoting -Force
```

Find all Devices in the local network
Display name and ip-address for each device

```PowerShell
1..254 | ForEach-Object {
    $ip = "192.168.1.$_"
    $name = (Resolve-DnsName -Name $ip -ErrorAction SilentlyContinue).NameHost
    if ($name) { Write-Output "$ip - $name" }
}

```

Add the current user (lab_admin) to "Remote

Commad to run a resetRemote.bat file on LABTOP15

```PowerShell
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

Invoke-Command -ComputerName LABTOP15 -Credential $Credential -ScriptBlock {
    cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
    Stop-Process -Name explorer -Force
    Start-Process explorer
}

```

## Commads for preparing machine for remote control

**Start PowerShell as administrator and run following commands:**

### 0. Change Script execution policy

```PowerShell
# check execution policy
Get-ExecutionPolicy
# change the execution policy to RemoteSigned
Set-ExecutionPolicy RemoteSigned
```

### 1. Enable PowerShell Remoting

```PowerShell
Enable-PSRemoting -Force
```

### 2. Add user to "Remote Management Users" group

```PowerShell
# add user "user" to local group "Remote Management Users"
Add-LocalGroupMember -Group "Remote Management Users" -Member "user"
# check that user is added
Get-LocalGroupMember "Remote Management Users"
```

### 3. Remove password expiration

```PowerShell
net accounts #show local account settings
net accounts /maxpwage:unlimited
```

## Coomads on Host Machine

To run a PowerShell script, you can either copy and paste the code directly into a PowerShell session and execute it, or save the script as a file (e.g., script.ps1) and run it from PowerShell.

```PowerShell
# To run a PS script just open the .ps1 file from PowerShell
\path\to\your\script.ps1
```

Run command on a remote machine:

```PowerShell
# Set username and password to connect to the remote machine
# User here should be added to
$User = "REMOTE-USER"
$Password = ConvertTo-SecureString "REMOTE-USER-PASSWORD" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)
#Set the name of the Remote Computer
$ComputerName = "REMOTE-COMPURTER"

# Execute command on Remote Machine
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
	Write-Host "Connected to: $env:COMPUTERNAME" -ForegroundColor Cyan
	Get-LocalUser
}

```

Same script but the Computer name is defines as a parameter now
From PowerShell:

```PowerShell
\path\to\your\script.ps1 -ComputerName "REMOTE-COMPUTER"
```

```PowerShell
param (
    [string]$ComputerName
)

# Credentials
$User = "REMOTE-USER"
$Password = ConvertTo-SecureString "REMOTE-USER-PASSWORD" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Execute remote command
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    Write-Host "Connected to: $env:COMPUTERNAME" -ForegroundColor Cyan
    Get-LocalUser
}
```

## PcExec use (alternative to WinRemote)

Run command on a remote machine using PsExec
Install PcExec

```PowerShell
PsExec \\REMOTE-COMPUTER -u REMOTE-USER -p REMOTE-PASSWORD -i cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
```
