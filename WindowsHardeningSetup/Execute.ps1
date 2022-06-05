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

$global:logLocation = "C:\WinHardeningLog.txt"
$global:workingDir = "C:\Utils\Scripts\Win10Hardening\"
$global:currentVersion = "Ver 0.1"
$host.ui.RawUI.WindowTitle = "Windows10 Hardening"
[int]$taskTotal = 10

#endregion /\ GLOBAL VARIABLES /\

#region \/ FUNCTIONS \/


#// Function to start a job and run a Wscript to press the scroll-lock key every 45sec which keeps the computer awake
function StayAwake {
    try {
        Start-Job -Name Coffee {
        Write-Host functionRan
            $WShell = New-Object -Com Wscript.Shell
            while (1) {$WShell.SendKeys("{SCROLLLOCK}{SCROLLLOCK}"); sleep 45}
            Write-Host functionRan2
        }
    }
    catch {Write-Error -Message "There was a failure in the StayAwake Function. [x001]"}
    }
function Set-Title {
    [CmdletBinding()]
    param (
        [string] $Title = "Powershell"
    )
    try {
        $Host.UI.RawUI.WindowTitle = $Title
    }
    catch {Write-Error -Message "There was a failure in the SET-TITLE Function. [x002]"}
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
#// Function to write blank line
function WriteBlank {
    WriteCmdLine -Message "`n" -Color "YELLOW"
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
        $Date = (DateStamp)
        "[$Date] ~   $Message" | Out-File -FilePath $Path -Append
    }
#// Function To Run a Process
    function ProcRun {
        param (
            [string] $Name,
            [string] $CodeAction
        )
        [int]$taskVal = $taskVal + 1
        WriteCmdLine -Message "Starting Action: $Name" -Color "Blue"
        WriteCmdLine -Message "Task $taskVal of $taskTotal"
        Start-Process powershell.exe $CodeAction
        Loginator -Message "Executed: $CodeAction"
    }
#endregion /\ FUNCTIONS /\

#// Start script and initiate Log file.
WriteCmdLine -Message "ENSURE SCRIPT IS RUNNING AS ADMINISTRATOR!" -Color "RED"
PAUSE
WriteCmdLine -Message "Initializing Script" -Color "YELLOW"
Loginator -Message "Script Initiated by $env:USERNAME"
WriteBlank
WriteCmdLine -Message "Beginning Process..." -Color "BLUE"
WriteCmdLine -Message "-------------------------" -Color "White"
WriteBlank
WriteBlank
WriteCmdLine -Message "Configuring Attack Surface Reduction Rules..."
Set-Title -Title "[InProgress - Setting ASR Rules]"



WriteCmdLine -Message "Process Completed Successfully!" -Color "Green"
Pause