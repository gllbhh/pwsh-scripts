For ($counter = 0; $counter -le 6; $counter++){
    $fileName = "trooper" + $counter.ToString() + ".txt"
    $path = "C:\git\pwsh_scripts\deathStar\" + $fileName
    if (-not (Test-Path $path)){

    New-Item -Name $fileName -Path "C:\git\pwsh_scripts\deathStar"
    }
    "Trooper$counter" | Out-File -FilePath $path -Encoding UTF8
    # New-Item -Path .\dethStar -ItemType file
}

