<#
Author: 		Blinchik
Version: 		1.1
Description:		This Script checks via the ebesucher API if the surfbar is active
			if not it will restart the browser(s)
#>

# The default windows policies does not allow you to execute (unsigned) powershell scripts directly 
# You can run the Script by bypassing the Script via Cmd/Batch file with following command:
# powershell -ExecutionPolicy ByPass -File WatchdogEBesucher.ps1

# you can find your api key here https://www.ebesucher.de/restarter (only if logged in)
$code = "" # <===== HERE YOUR CODE

# you can define more browsers if they support the same start parameters eg. firefox or chrome
# make sure every Browser you use has an unique surflink, don't use it twice or more! 
# ========> ADD YOUR SURFBAR BROWSERS HERE
$surbarBrowsers = @(@{
    SurfUser = 'username.surfbar' # <======= HERE YOUR SURFBAR USER
    Application = 'msedge'
    ApplicationPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    CustomCode = ""
 }
 ,@{
    SurfUser = 'username.surfbar2'
    Application = 'opera'
    ApplicationPath = "C:\Program Files\Opera\opera.exe"
    CustomCode = ""
 }
 #,@{
 #   SurfUser = 'username.surfbar3'
 #   Application = 'firefox'
 #   ApplicationPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
 #   CustomCode = ""
 #}
)

# set to $true if you want to restart the whole system on errors
$restartSystemOnError = $false
$maxStartErrorCount = 5

# define your custom timeout in seconds how long it has to wait before check if a timeout occured
# you can play with this value, it varies per system
$customTimeout = 120

# restart interval in seconds of every browser
# 0 = disabled
# >0 = enabled
$restartInterval = 7200

# the interval in seconds for checking whether the surfbar is active or not
$checkInterval = 60


#Functions
<#-------------------------------------------------------#>

<# Begin IsSurfbarActive #>
function IsSurfbarActive
{ 	param([string]$surfbarUser, [string]$customCode)

	$format = 'yyyy-MM-dd HH:mm:ss'

	# extracted from official EBesucher Restarter Application
	$response = (Invoke-WebRequest -URI "http://www.ebesucher.de/index.php?link=restarterzugriff&username=$surfbarUser&code=$customCode").Content
    $data = $response | ConvertFrom-Stringdata
	$last_Time = [Datetime]::ParseExact($data.Last_Time.Replace('"',''), $format, $null)
	$now = [Datetime]::ParseExact($data.Now.Replace('"',''), $format, $null)
	$timeout = [boolean]$data.Timeout_reached

	return -Not (($now-$last_Time).TotalSeconds -gt $customTimeout -and $timeout)
}
<# End Method: IsSurfbarActive #>

<# Begin ProcessIsRunning #>
function ProcessIsRunning
{ 	param([string]$application)
	$processes = Get-Process $application -ErrorAction SilentlyContinue
	return $processes.count -gt 0
}
<# End IsSurfbarActive #>

<# Begin CheckSurfbar #>
function CheckSurfbar
{ 	param([string]$surfbarUser, [string]$application, [string]$applicationPath, [string]$customCode, [boolean]$restart)

    $isActive = $false
    $processIsRunning = ProcessIsRunning -application $application

    if ($processIsRunning -and -not $restart)
    {
	    try
	    {
		    $isActive = IsSurfbarActive -surfbarUser $surfbarUser -customCode $customCode
	    }
	    catch [System.Net.WebException],[System.Management.Automation.ErrorRecord]
	    {
	      # internet disconnected
	      Write-Host $Error[0].exception.Message -ForegroundColor red
	      Write-Host "Request failed. Please check your internet connection."
	      return 
	    }
    }


	$startErrorCount = 0
	if (-Not $isActive) 
	{ 
		$date = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
		if ($restart)
		{
			Write-Host "$date - $application execute auto restart" -ForegroundColor yellow
		}
		else
		{
			Write-Host "$date - $application Surfbar not active, restart now" -ForegroundColor yellow
		}
		Get-Process $application -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() | Out-Null }
                Start-Sleep 10 
		
		do 
		{
			Stop-Process -Name $application -ErrorAction SilentlyContinue
			Start-Sleep 5
			Start-Process -FilePath $applicationPath -ArgumentList "https://www.ebesucher.de/surfbar/$surfbarUser"
			Start-Sleep 5
			
			if (-Not (ProcessIsRunning -application $application)) 
			{
			    # wait and check again
			    Start-Sleep 10
			    if (-Not (ProcessIsRunning -application $application))
			    {
			       $startErrorCount++;
			    }
			}	
			$processIsRunning = ProcessIsRunning -application $application
		} 
		while ((-Not ($processIsRunning)) -and $startErrorCount -lt $maxStartErrorCount)


		if (-Not $processIsRunning -and $startErrorCount -eq $maxStartErrorCount) 
		{
		   Write-Host "Max error count of $maxStartErrorCount reached!" -ForegroundColor red
		   if (restartSystemOnError)
		   { 
		     	Write-Host "System will be restarted!" -ForegroundColor red
		     	shutdown /r /t 30
		   }
		   else
		   {
		     	Write-Host "Please check your system!" -ForegroundColor red
		   }
		}
	}
}
<# End Method: CheckSurfbar #>

<#-------------------------------------------------------#>

# Main
<#-------------------------------------------------------#>
$date = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
Write-Host "$date - EBesucher Watchdog started"

$stopwatch =  [system.diagnostics.stopwatch]::New()
$restart = $false

if ($restartInterval -gt 0)
{
    $stopwatch.Start()
    Write-Host "$date - Auto restart active, every $restartInterval seconds"
}

# endless loop
while (1 -eq 1) 
{  
  if ($stopwatch.IsRunning -and ($stopwatch.Elapsed.TotalSeconds -gt $restartInterval))
  {
        $restart = $true
        $stopwatch.Restart()
  }
  
  foreach ($surbarBrowser in $surbarBrowsers)
  {
        CheckSurfbar -surfbarUser $surbarBrowser.SurfUser -application $surbarBrowser.Application -applicationPath $surbarBrowser.ApplicationPath -customCode $surbarBrowser.CustomCode -restart $restart
  }
  
  $restart = $false
  Start-Sleep $checkInterval
}
<#-------------------------------------------------------#>
