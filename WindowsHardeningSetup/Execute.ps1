<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

<# CODE VERSION: Ver 0.1 #>
<# 10 May 2022 @ 1000 #>

## ABOUT
# This code is designed to automate a majority of Windows10 hardening.
# Most of the controls are set based on common 'Best Practices' or STIGs refrenced by DISA.

#region \/ GLOBAL VARIABLES \/

$global:logLocation = "C:\Users\$env:USERNAME\WinHardeningLog.txt"
$global:workingDir = "C:\Utils\Scripts\Win10Hardening\"
$global:currentVersion = "Ver 0.1"

#endregion /\ GLOBAL VARIABLES /\

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
function WriteCmdLine {
        param(
            [string] $Message,
            [string] $Color = 'White'
        )
       # Colors "Black","Blue","Cyan","DarkBlue","DarkCyan","DarkGray","DarkGreen","DarkMagenta","DarkRed","DarkYellow","Gray","Green","Magenta","Red","White","Yellow"
       Write-Host $Message -ForegroundColor $Color 
    }
#// Function to print date in specified format
function DateStamp {
        Get-Date -Format "MM/dd/yyyy-HH:mm"
    }
#// Function to write to a log
function Loginator {
        param (
            [string] $Message,
            [string] $Path = $global:logLocation
        )
        $Date = (pingDate)
        "[$Date] ~   $Message" | Out-File -FilePath $Path -Append
    }
#endregion /\ FUNCTIONS /\

WriteCmdLine -Message "Initializing Script" -Color "YELLOW"
