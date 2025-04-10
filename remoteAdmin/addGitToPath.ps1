$ComputerName = "LABTOP15"
$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)
# Define the Git installation path

$GitPath = "C:\Program Files\Git\bin"

Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    $UserName = "lab_user"  # Change this if needed
    $GitPath = "C:\Program Files\Git\bin"

    # Get the current PATH for lab_user
    $UserPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

    # Check if Git is already in PATH
    if ($UserPath -notlike "*$GitPath*") {
        $NewPath = "$UserPath;$GitPath"

        # Set the new PATH for lab_user
        [System.Environment]::SetEnvironmentVariable("Path", $NewPath, [System.EnvironmentVariableTarget]::User)

        Write-Host "Git added to PATH for lab_user."
    } else {
        Write-Host "Git is already in PATH for lab_user."
    }
	$UserPath
	git -v
}