:: Description: This batch file will restart opera.exe every 30 minutes 
:: Authors: roin93 & Blinchik
:: Tested on Windows 11 Pro

@ECHO OFF
title Watchdog for opera
SET P=opera.exe

ECHO %date% %time%- Every 30 minutes this script will close opera.exe and will start it again.

:Beginning
:: List all Processes which contain P, but do not show in terminal
TASKLIST | FINDSTR /I "%P%" > NUL

IF ERRORLEVEL 1 (GOTO :Starting)
:: Sleep for 1800 seconds / 30 minutes
timeout /t 1800 /nobreak > NUL

ECHO %date% %time% - Close Opera Browser
:: After Sleeping, now close opera and wait for a restart
Powershell -C "Get-Process opera | ForEach-Object { $_.CloseMainWindow() | Out-Null}" > NUL
timeout /t 10 /nobreak > NUL

:: kill dead processes to clear memory
taskkill /IM opera.exe /F /T 2> nul
timeout /t 10 /nobreak > NUL

:Starting
ECHO %date% %time% - Starting Opera Browser
Start "[FullPath]\opera.exe" "https://www.ebesucher.de/surfbar/[surflink]"
timeout /t 10 /nobreak > NUL
GOTO :Beginning
