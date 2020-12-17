<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
#This script's purpose is to allow an easier way to check the current status of internet resources in sequence 
#   without having to manually run the commands.

#region GLOBAL VARIABLES
$UseVerification = $True
$global:loop = 'TRUE'
$global:PauseTime = 250 #In seconds
$Targets = [PSCustomObject]@{
    1 = '172.18.10.1'
    2 = '172.18.10.1'
    3 = '8.8.8.8'
    4 = '1.1.1.1'
    5 = ''
    6 = ''
    7 = ''
    8 = ''
    9 = ''
    10 = ''
    11 = ''
    12 = ''
    13 = ''
    14 = ''
    15 = ''
}
#endregion GLOBAL VARIABLES

#region FUNCTIONS
function Write-CmdLine {
    param(
        [string] $Message,
        [string] $Color = 'White'
    )
   # Colors "Black","Blue","Cyan","DarkBlue","DarkCyan","DarkGray","DarkGreen","DarkMagenta","DarkRed","DarkYellow","Gray","Green","Magenta","Red","White","Yellow"
   Write-Host $Message -ForegroundColor $Color 
}

#Compare the hash of a running script to that of a saved 'Control' hash to ensure script has not been modified. *Hash is stored in MD5*
        #Inputs -ControlHashPath <Path to a file containing your expected correct hash>
        #       -RunningPath <Path to current script that is being ran to compare against control hash>
        #Outputs [BOOLEAN] True / False 

    #//Usage: PS:\> VerifyIntegrity -ControlHashPath <Path to File> -RunningPath <Path to script>
function HashItem {
    param (
        [STRING] $FilePath,
        [STRING] $HashType
    )
    Certutil.exe -HashFile $FilePath $HashType
}
function VerifyIntegrity {
    IF ($UseVerification -eq $True) {
         $testHash = HashItem -FilePath "statusCheck.ps1" -HashType MD5
         $testHash1 = $testHash[1]
         $realHash = Get-Content -Path "VerifyIntegrity.dat"
         Write-CmdLine -Message "File Hash: $testHash1" -Color "Cyan"
         IF ($testHash1 -eq $realHash[3]) {
             Write-CmdLine -Message "Hash Verification: Success" -Color "Green"
         }
         ELSE {
             Write-CmdLine -Message "Hash Verification: FAILURE" -Color "Red"
             Exit
         }
    }
    ELSE {
        $testHash = HashItem -FilePath "statusCheck.ps1" -HashType MD5
        $testHash1 = $testHash[1]
        Write-CmdLine -Message "File Hash: $testHash1" -Color "Cyan"
        Write-Host "Verification Disabled"
        Write-CmdLine "Warning: Verification Disabled" -Color "RED"
    }
}

function LifeCheck {
    param(
        [string] $CheckTarget
    )
    Try {Test-Connection $CheckTarget -Count 1 -ErrorAction Stop} Catch {Write-CmdLine -Message "$CheckTarget is offline." -Color "RED"}
}
#endregion FUNCTIONS

VerifyIntegrity

[ARRAY]$Tars = $Targets.1,
$Targets.2,
$Targets.3,
$Targets.4,
$Targets.5,
$Targets.6,
$Targets.7,
$Targets.8,
$Targets.9,
$Targets.10,
$Targets.11,
$Targets.12,
$Targets.13,
$Targets.14,
$Targets.15

While ($loop -eq $True){
    Clear-Host
    Write-CmdLine -Message "===RRU STATUS===" -Color "Yellow"
ForEach ($Target in $Tars) {
    $Online = Try {Test-Connection $Target -Count 1 -Quiet} Catch {}
    $Status = LifeCheck -CheckTarget $Target
    $Delay = $Status.ResponseTime
    IF ($Online -eq $True) {
        Write-CmdLine -Message "-$Target-" -Color "Cyan"
        Write-CmdLine -Message "Online" -Color "Green"
        Write-CmdLine -Message "Delay: $Delay ms" -Color "White"
        Write-CmdLine -Message " "
    }
    Else {
        Write-CmdLine -Message "-$Target-" -Color "White"
        Write-CmdLine -Message "OFFLINE" -Color "Red"
        Write-CmdLine -Message " "
    }
}
Write-CmdLine -Message "Scan Delay $PauseTime seconds..."
Start-Sleep -Seconds $global:PauseTime
}