param (
    [string]$ComputerName,
    [string]$ProgramName
)

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Execute remote command to check if the program is installed and get its version
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    param ($ProgramName)

    # Define registry paths where installed programs are listed
    $RegistryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
    )

    # Check both registry locations for the program
    $Program = $null
    foreach ($Path in $RegistryPaths) {
        $Program = Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object { $_.DisplayName -like "*$ProgramName*" }
        if ($Program) { break }  # Stop searching if found
    }

    # Output results
    if ($Program) {
        $Version = $Program.DisplayVersion
        Write-Host "$ProgramName is installed on $env:COMPUTERNAME. Version: $Version" -ForegroundColor Green
        return @{
            ProgramName = $ProgramName
            Version = $Version
            Installed = $true
        }
    } else {
        Write-Host "$ProgramName is NOT installed on $env:COMPUTERNAME." -ForegroundColor Red
        return @{
            ProgramName = $ProgramName
            Version = $null
            Installed = $false
        }
    }
} -ArgumentList $ProgramName
