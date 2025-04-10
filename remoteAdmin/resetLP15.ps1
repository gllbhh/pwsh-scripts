$User = "user"
$Password = ConvertTo-SecureString "salasana" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

Invoke-Command -ComputerName LABTOP15 -Credential $Credential -ScriptBlock {
    Stop-Process -Name explorer -Force
    Start-Process explorer
	cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat"
}