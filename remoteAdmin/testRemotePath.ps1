param (
    [string]$RemoteComputer,
    [string]$RemotePath
)

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Check if PowerShell Remoting is enabled
if (!(Test-Connection -ComputerName $RemoteComputer -Count 1 -Quiet)) {
    Write-Host "Error: Cannot reach $RemoteComputer. Check network connection." -ForegroundColor Red
    exit 1
}

# Run command on the remote machine
Invoke-Command -ComputerName $RemoteComputer -Credential $Credential -ScriptBlock {
    param ($Path)

    # Provide network credentials to access the share
    $UserRemote = "FabLab_Admin"  
    $PasswordRemote = ConvertTo-SecureString "P5)fag6" -AsPlainText -Force    
    $CredentialRemote = New-Object System.Management.Automation.PSCredential ($UserRemote, $PasswordRemote)

    # Authenticate to the network share
    net use \\LAPTOP-LASER\ /user:$UserRemote $SecurePassword /persistent:no | Out-Null

    # Check if the path exists
    Test-Path -Path $Path
} -ArgumentList "$RemotePath"

