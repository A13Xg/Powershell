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
#// Function to write to the command line
    function Write-CmdLine {
        param(
            [string] $Message,
            [string] $Color = 'White'
        )
       # Colors "Black","Blue","Cyan","DarkBlue","DarkCyan","DarkGray","DarkGreen","DarkMagenta","DarkRed","DarkYellow","Gray","Green","Magenta","Red","White","Yellow"
       Write-Host $Message -ForegroundColor $Color 
    }
#endregion /\ FUNCTIONS /\