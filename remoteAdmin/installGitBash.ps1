# Define remote computer name
$ComputerName = "LABTOP2"

# Path to Git installer on your admin PC (must be in a shared folder)
$InstallerPath = "\\Z:\installers\Git-2.48.1-64-bit.exe"

# Path where the installer will be copied on LABTOP2
$RemotePath = "C:\Users\lab_user\Downloads\Git-2.48.1-64-bit.exe"

# Installation Arguments (Silent Mode)
$InstallArgs = '/SILENT /NORESTART'

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Check if LABTOP2 is online
if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
    Write-Host "$ComputerName is online. Installing Git Bash..."

    try {
        # Copy installer to LABTOP2
        Copy-Item -Path $InstallerPath -Destination $RemotePath -Force -Credential $Credential

        # Execute the installer remotely
        Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
            Start-Process -FilePath $RemotePath -ArgumentList "/SILENT /NORESTART" -Wait -PassThru
        }

        Write-Host "Git Bash successfully installed on $ComputerName!" -ForegroundColor Green
    } catch {
        Write-Host "Installation failed on $ComputerName. Error: $_" -ForegroundColor Red
    }
} else {
    Write-Host "$ComputerName is offline. Skipping installation." -ForegroundColor Yellow
}