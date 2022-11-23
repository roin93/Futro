@echo off
Powershell -C "Get-Process msedge | ForEach-Object { $_.CloseMainWindow() | Out-Null}"
timeout /T 5 /NoBreak
taskkill /IM msedge.exe /F > null
start msedge
