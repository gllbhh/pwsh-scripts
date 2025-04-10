$remotePC = "LABTOP15"  # Replace with the actual device name
$desktopPath = "\\LABTOP15\C:\Users\Public\Desktop\testfile.txt"

Invoke-Command -ComputerName $remotePC -ScriptBlock {
    New-Item -Path $using:desktopPath -ItemType File -Value "Hello, this is a test file!" -Force
} -Credential $cred