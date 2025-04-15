@echo off
setlocal ENABLEDELAYEDEXPANSION
echo Running reset.bat at %date% %time% >> C:\Users\lab_user\reset_log.txt

:: Redirect input from `nul` to prevent errors
taskkill /F /IM "inkscape.exe" <nul >nul 2>&1
taskkill /F /IM "Arduino IDE.exe" <nul >nul 2>&1
taskkill /F /IM "chrome.exe" <nul >nul 2>&1
:: Clean Chrome cache
echo **** Deleting Chrome History, Cache, etc. ****

set "ChromeDataDir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default"
set "ChromeCache=%ChromeDataDir%\Cache"
if exist "%ChromeCache%" (
    del /q /s /f "%ChromeCache%\*.*" >nul 2>&1
    del /q /f "%ChromeDataDir%\*Cookies*.*" >nul 2>&1
    del /q /f "%ChromeDataDir%\*History*.*" >nul 2>&1
)

echo **** Chrome cache cleanup DONE ****
 

:: Clean desktop
echo **** Cleaning Desktop ****
set "desktopDir=%userProfile%\Desktop"
for %%F in (pdf png jpg jpeg stl svg) do (
    if exist "%desktopDir%\*.%%F" del /q "%desktopDir%\*.%%F"
)
if exist "%desktopDir%\Aurora*" del /q "%desktopDir%\Aurora*"

:: Ensure network drive is available
echo **** Mapping Network Drive ****
net use Z: /delete >nul 2>&1
net use Z: "\\LAPTOP-LASER\MFL network drive" /user:lab_user salasana /persistent:no

:: Copy files from network drive
echo **** Copying files from network drive ****
xcopy /s/e/y "\\LAPTOP-LASER\MFL network drive\Templates" "C:\Users\lab_user\Desktop"
:: xcopy /s/e/y "\\NetworkDrive\Share\CuraProfiles" "%appdata%\cura\5.5\quality_changes"

echo Script execution finished at %date% %time% >> C:\Users\lab_user\reset_log.txt
exit /b
