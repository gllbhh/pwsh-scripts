param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string[]]$Targets
)

# List of computers
$ComputerList = @("LABTOP1", "LABTOP2", "LABTOP3", "LABTOP4", "LABTOP5", "LABTOP6", "LABTOP7", "LABTOP8", "LABTOP9", "LABTOP10", 
                  "LABTOP11", "LABTOP12", "LABTOP13", "LABTOP14", "LABTOP15", "LABTOP16", "LABTOP17", "LABTOP18", "LABTOP19", "LABTOP20")

# Select computers based on the argument
if ($Targets -contains "all") {
    $SelectedComputers = $ComputerList
} else {
    $SelectedComputers = @()
    foreach ($target in $Targets) {
        if ($target -match '^\d+$' -and [int]$target -ge 1 -and [int]$target -le $ComputerList.Count) {
            $SelectedComputers += $ComputerList[[int]$target - 1]
        } else {
            Write-Host "Invalid target: $target. Please use numbers between 1 and $($ComputerList.Count), or 'all'."
            exit
        }
    }
}

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Loop through selected computers
foreach ($Computer in $SelectedComputers) {
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
        Write-Host "$Computer is online. Running script..."

        try {
            $session = New-PSSession -ComputerName $Computer -Credential $Credential

            Invoke-Command -Session $session -ScriptBlock {
                Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
                Start-Process explorer
                cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
            }

            Remove-PSSession $session
            Write-Host "Successfully executed script on $Computer"
        } catch {
            Write-Host "Failed to execute script on $Computer. Error: $_"
        }
    } else {
        Write-Host "$Computer is offline. Skipping..."
    }
    Start-Sleep -Seconds 1
}
