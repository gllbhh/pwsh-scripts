param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string[]]$Targets
)

# List of computers
$ComputerList = @("LABTOP1", "LABTOP2", "LABTOP3", "LABTOP4", "LABTOP5", "LABTOP6", "LABTOP7", "LABTOP8", "LABTOP9", "LABTOP10", 
                  "LABTOP11", "LABTOP12", "LABTOP13", "LABTOP14", "LABTOP15", "LABTOP16", "LABTOP17", "LABTOP18", "LABTOP19", "LABTOP20")

# Select target computers
if ($Targets -contains "all") {
    $SelectedComputers = $ComputerList
} else {
    $SelectedComputers = @()
    foreach ($target in $Targets) {
        if ($target -match '^\d+$' -and [int]$target -ge 1 -and [int]$target -le $ComputerList.Count) {
            $SelectedComputers += $ComputerList[[int]$target - 1]
        } else {
            Write-Host "Invalid target: $target. Please use numbers 1 to $($ComputerList.Count) or 'all'."
            exit
        }
    }
}

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Loop through selected computers and shut down
foreach ($Computer in $SelectedComputers) {
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
        Write-Host "$Computer is online. Sending shutdown command..."
        try {
            Invoke-Command -ComputerName $Computer -Credential $Credential -ScriptBlock {
                Stop-Computer -Force
            }
            Write-Host "$Computer is shutting down."
        } catch {
            Write-Host "Failed to shut down $Computer. Error: $_"
        }
    } else {
        Write-Host "$Computer is offline or unreachable. Skipping..."
    }
}
