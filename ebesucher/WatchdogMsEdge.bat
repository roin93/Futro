:: Description: This batch file will restart msedge.exe every 30 minutes 
:: Authors: roin93 & Blinchik
:: Tested on Windows 11 Pro

@ECHO OFF
title Watchdog for MS Edge
SET P=msedge.exe
:: Waittime in seconds
SET WAITTIME=1800
:: Seconds to wait after heavy commands
SET GIVETIME=10

:Beginning
ECHO %date% %time% - Every 30 minutes this script will close msedge.exe and will start it again.
:: List all Processes which contain P, but do not show in terminal
TASKLIST | FINDSTR /I "%P%" > NUL

IF ERRORLEVEL 1 (GOTO :Starting)
:: Sleep for seconds specified in waittime
timeout /t %WAITTIME% /nobreak > NUL

ECHO %date% %time% - Close Edge browser
:: After Sleeping, now close msedge and wait for a restart
Powershell -C "Get-Process msedge | ForEach-Object { $_.CloseMainWindow() | Out-Null}" > NUL
timeout /t %GIVETIME% /nobreak > NUL

:: Kill dead processes to clear memory
taskkill /IM msedge.exe /F /T 2> nul
timeout /t %GIVETIME% /nobreak > NUL 

:Starting
ECHO %date% %time% - Starting Edge Browser
Start msedge "https://www.ebesucher.de/surfbar/[surfbar]"
timeout /t %GIVETIME% /nobreak > NUL
GOTO :Beginning
