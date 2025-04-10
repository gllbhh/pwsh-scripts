param (
    [string]$ComputerName
)

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Execute remote command
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    Write-Host "Connected to: $env:COMPUTERNAME" -ForegroundColor Cyan
    Get-LocalUser
}