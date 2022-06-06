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
#// Function to test if script is currently elevated
function CheckAdmin {
    #// Declare WinSecurity Object
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    IF ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) = $TRUE) {
        WriteCmdLine -Message "Elevated Permissions Check:  PASSED" -Color "GREEN"
    }
    ELSEIF ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) = $FALSE) {
        WriteCmdLine -Message "ERROR - You are not running as ADMINISTRATOR" -Color "RED"
        WriteBlank -Message "Please try running the script again as Administrator." -Color "Yellow"
        Pause
        EXIT
    }
    ELSE {
        WriteCmdLine -Message "ERROR - You are not running as ADMINISTRATOR" -Color "RED"
        WriteBlank -Message "Please try running the script again as Administrator." -Color "Yellow"
        Pause
        EXIT
    }
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

#region \/ Test for Admin, setup Log File, inform user. \/
Clear-Host
#// Start script and initiate Log file.
WriteCmdLine -Message "ENSURE SCRIPT IS RUNNING AS ADMINISTRATOR!" -Color "RED"
WriteCmdLine -Message "Testing if Administrator..." -Color "YELLOW"
#// Testing for Elevated Permissions
CheckAdmin
Clear-Host
WriteCmdLine -Message "Initializing Script" -Color "YELLOW"
Loginator -Message "Script Initiated by $env:USERNAME"
WriteBlank
WriteCmdLine -Message "Beginning Process..." -Color "BLUE"
WriteCmdLine -Message "-------------------------" -Color "White"
WriteBlank
WriteBlank
#endregion /\ Test for Admin, setup Log File, inform user. /\

#region Configure Attack Surface Reduction Rules
WriteCmdLine -Message "Configuring Attack Surface Reduction Rules..."
Set-Title -Title "[InProgress - Setting ASR Rules]"
WriteBlank
[int]$RuleTotalCount = 10
#-RULE 1
#// Block executable content from email client and webmail
WriteCmdLine -Message "Setting Rule 1 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550 -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 1 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr01]"
}
#-RULE 2
#// Block all Office applications from creating child processes.
WriteCmdLine -Message "Setting Rule 2 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 2 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr02]"
}
#-RULE 3
#// Block all Office applications from creating executable content.
WriteCmdLine -Message "Setting Rule 3 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids 3B576869-A4EC-4529-8536-B80A7769E899 -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 3 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr03]"
}

#-RULE 4
#// Block all Office applications from injecting code into other processes.
WriteCmdLine -Message "Setting Rule 4 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 4 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr04]"
}

#-RULE 5
#// Block Win32 API calls from Office macro.
WriteCmdLine -Message "Setting Rule 5 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids 92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 5 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr05]"
}

#-RULE 6
#// Block Office communication application from creating child processes.
WriteCmdLine -Message "Setting Rule 6 of $RuleTotalCount..." -Color "Blue"
try {
    Set-MpPreference -AttackSurfaceReductionRules_Ids 26190899-1602-49E8-8B27-EB1D0A1CE869 -AttackSurfaceReductionRules_Actions Enabled
    WriteCmdLine -Message "ASR Rule 6 of $RuleTotalCount set successfully!" -Color "GREEN"
    WriteBlank
}
catch {
    WriteCmdLine -Message "ERROR: Unable to set ASR Rule [x00asr06]"
}
WriteCmdLine -Message "Process Completed Successfully!" -Color "Green"
Pause