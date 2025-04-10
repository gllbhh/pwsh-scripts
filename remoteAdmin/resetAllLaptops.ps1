# List of computers
$ComputerList = @("LABTOP1", "LABTOP2", "LABTOP3", "LABTOP4", "LABTOP5", "LABTOP6", "LABTOP7", "LABTOP8", "LABTOP9", "LABTOP10", 
                  "LABTOP11", "LABTOP12", "LABTOP13", "LABTOP14", "LABTOP15", "LABTOP16", "LABTOP17", "LABTOP18", "LABTOP19", "LABTOP20")

# Credentials
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Loop through each computer
foreach ($Computer in $ComputerList) {
    # Check if the computer is online
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
        Write-Host "$Computer is online. Running script..."
        
        try {
            Invoke-Command -ComputerName $Computer -Credential $Credential -ScriptBlock {
                Stop-Process -Name explorer -Force
                Start-Process explorer
                cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
            }
            Write-Host "Successfully executed script on $Computer"
        } catch {
            Write-Host "Failed to execute script on $Computer. Error: $_"
        }
    } else {
        Write-Host "$Computer is offline. Skipping..."
    }
}
