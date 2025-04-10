# Remote Administration for Mobile Fab Lab laptops

### 1. Enable PowerShell Remoting

To manage laptops remotely, PowerShell Remoting must be enabled on each device (needed to be done only once):

```PowerShell
# Allow script ecesution
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force


# Enable remoting
Enable-PSRemoting -Force

```

Add the current user (lab_admin) to "Remote

Find all Devices in the local network
Display name and ip-address for each device

```PowerShell


```

Commad to run a resetRemote.bat file on LABTOP15

using PsExec

```PowerShell
PsExec \\LABTOP15 -u lab_user -p salasana -i cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
```

### Remove password expiration

Run command prompt as administrator

```PowerShell
net accounts
```

```PowerShell
net accounts /maxpwage:unlimited
```

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
