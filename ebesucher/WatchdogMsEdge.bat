:: Description: This batch file will restart msedge.exe every 30 minutes 
:: Authors: roin93 & Blinchik
:: Tested on Windows 11 Pro

@ECHO OFF
title Watchdog for MS Edge
SET P=msedge.exe

ECHO %date% %time% - Every 30 minutes this script will close msedge.exe and will start it again.

:Beginning
:: List all Processes which contain P, but do not show in terminal
TASKLIST | FINDSTR /I "%P%" > NUL

IF ERRORLEVEL 1 (GOTO :Starting)
:: Sleep for 1800 seconds / 30 minutes
timeout /t 1800 /nobreak > NUL

ECHO %date% %time% - Close Edge browser
:: After Sleeping, now close msedge and wait for a restart
Powershell -C "Get-Process msedge | ForEach-Object { $_.CloseMainWindow() | Out-Null}" > NUL
timeout /t 10 /nobreak > NUL

:: Kill dead processes to clear memory
taskkill /IM msedge.exe /F /T 2> nul
timeout /t 10 /nobreak > NUL 

:Starting
ECHO %date% %time% - Starting Edge Browser
Start msedge "https://www.ebesucher.de/surfbar/[surfbar]"
timeout /t 10 /nobreak > NUL
GOTO :Beginning
