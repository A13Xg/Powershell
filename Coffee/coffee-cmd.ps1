<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
# This code prevents a system from going to sleep due to a forced Group Policy or other machine settings.
# This is accomplished by toggling the 'Scroll Lock' key on and off every 45 seconds.
# >NOTE< This application is NOT intended to circumvent security measures. When running this application ensure the system is physically supervised and protected.


#region \/ FUNCTIONS \/
    #// Function to start a job and run a Wscript to press the scroll-lock key every 45sec which keeps the computer awake
function StayAwake {
        Start-Job -Name Coffee {
        Write-Host functionRan
            $WShell = New-Object -Com Wscript.Shell
            while (1) {$WShell.SendKeys("{SCROLLLOCK}{SCROLLLOCK}"); sleep 45}
            Write-Host functionRan2
        }
    }
    
    #// Function to kill the Wscript process and stop the job
function KillAwake {
        Try {
            Stop-Job -Name Coffee -ErrorAction Stop
            Remove-Job -Name Coffee -ErrorAction Stop
            }
        Catch {
            Write-Warning -Message "No Coffee Job is currently running."
        }
        Finally {
        }
    }
    function Coffee {
        #//Function Documentation
    <#
.Synopsis
  This function prevents a system from going to sleep due to a forced Group Policy or other machine settings.
.Description
	This is accomplished by toggling the 'Scroll Lock' key on and off every 45 seconds.
    >NOTE< This application is NOT intended to circumvent security measures. When running this application ensure the system is physically supervised and protected.
.Example
	C:\PS> Coffee -Status "Start | Stop"
.Notes
	Name: Coffee
	Author: §- A13Xg // Alexander Goodman
	Last Edit: 12/3/2020
	Keywords: Coffee
.Link
https://github.com/A13Xg/Powershell
https://github.com/A13Xg/Powershell/tree/main/Coffee
#>


    param (
        [STRING]$Status
    )
    IF ($Status -eq 'start' -or $Status -eq 'Start' -or $Status -eq 'START') {
        Try {(StayAwake -ErrorAction Stop)} Catch {Write-Error -Message "ERROR: Unable to start [Coffee] process."}
        Write-Host "Coffee running..."
    }
    ELSEIF ($Status -eq 'stop' -or $Status -eq 'Stop' -or $Status -eq 'STOP') {
        Try {(KillAwake -ErrorAction Stop)} Catch {Write-Error -Message "ERROR: Unable to terminate [Coffee] process."}
        Write-Host "Coffee stopped."
    }
    ELSE {
        Write-Error -Message "You did not specify a correct action for [-Status] parameter"
    }
}
#endregion /\ FUNCTIONS /\

    #// Calling of main function
function MainCall {
    Clear-Host
    Write-Host "-> Coffee Script Loaded <-"
    Write-Host " "
    $Action = Read-Host -Prompt "Would you like to [Start] or [Stop] Coffee?"
    (Coffee -Status $Action)
}
(MainCall)