# Invoke-Command -ComputerName LABTOP15 -Credential $cred -ScriptBlock {
#     Start-Process -FilePath "C:\Users\lab_user\Desktop\reset.bat" #-WindowStyle Hidden
# }

Invoke-Command -ComputerName LABTOP15 -Credential $cred -ScriptBlock {
    cmd.exe /c "C:\Users\lab_user\Desktop\resetRemote.bat" 
}