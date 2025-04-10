$folder = "C:\git\pwsh_scripts\deathStar"
$pattern = "trooper*"
Get-ChildItem -Path $folder -Filter $pattern -File | Remove-Item -Force
