param (
    [string]$ComputerName,
    [string]$ProgramName
)

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Execute remote command
Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    param ($ProgramName)

    # Define registry paths where installed programs are listed
    $RegistryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
    )

    # Find the program and get uninstall command
    $UninstallString = $null
    foreach ($Path in $RegistryPaths) {
        $Program = Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object { $_.DisplayName -like "*$ProgramName*" }
        if ($Program) {
            $UninstallString = $Program.UninstallString
            break
        }
    }

    if ($UninstallString) {
        Write-Host "Found $ProgramName. Attempting to uninstall..." -ForegroundColor Yellow

        # If UninstallString is in quotes, remove them
        $UninstallString = $UninstallString -replace '"', ''

        # Check if it's an MSI uninstall command
        if ($UninstallString -match "MsiExec.exe") {
            # Convert /I (install) to /X (uninstall)
            $UninstallString = $UninstallString -replace "/I", "/X"
            Start-Process -FilePath "msiexec.exe" -ArgumentList "/X $($Program.PSChildName) /quiet /norestart" -Wait -NoNewWindow
        } else {
            # Handle EXE-based uninstallers
            if ($UninstallString -match "unins.*\.exe") {
                Start-Process -FilePath $UninstallString -ArgumentList "/silent /norestart" -Wait -NoNewWindow
            } else {
                Start-Process -FilePath "cmd.exe" -ArgumentList "/c $UninstallString /quiet /norestart" -Wait -NoNewWindow
            }
        }

        Write-Host "$ProgramName uninstalled successfully." -ForegroundColor Green
    } else {
        Write-Host "$ProgramName is NOT installed on $env:COMPUTERNAME." -ForegroundColor Red
    }
} -ArgumentList $ProgramName
