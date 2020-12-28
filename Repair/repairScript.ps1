<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
#This script's purpose is to allow an easier perform quick repair tasks across many computers.

#region GLOBAL-VARIABLES
$Target = $env:COMPUTERNAME
$RunningDir = "C:\Users\Admin\Documents\GitHub\Powershell\Repair"
$UseVerification = $True
#Classification of Workstation/Network
    #// UNCLASSIFIED, SECRET, TOP SECRET, TS/SCI (Any other value will give the proper label and a blue banner)
[STRING]$global:Classification = "UNCLASSIFIED"
                #// These IF Statements color the banner according to the setting specified above.
        IF ($Classification -eq "UNCLASSIFIED") {
            [STRING]$global:BannerColor = "Green"
        }
        ELSEIF ($Classification -eq "SECRET") {
            [STRING]$global:BannerColor = "Red"
        
        }
        ELSEIF ($Classification -eq "TOP SECRET") {
            [STRING]$global:BannerColor = "DarkOrange"
        }
        ELSEIF ($Classification -eq "TS/SCI") {
            [STRING]$global:BannerColor = "Yellow"
        }
        ELSE {
            [STRING]$global:BannerColor = "Blue"
        }
$LogLocation = "$RunningDir\Repair_Log.log"
#endregion GLOBAL-VARIABLES

#region FUNCTIONS

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
         $testHash = HashItem -FilePath "$RunningDir\repairScript.ps1" -HashType MD5
         $testHash1 = $testHash[1]
         $realHash = Get-Content -Path "$RunningDir\VerifyIntegrity.dat"
         Write-CmdLine -Message "File Hash: $testHash1" -Color "Cyan"
         Loginator -Message "File Hash: $testHash1" -Path "$RunningDir\Repair_Log.log"
         IF ($testHash1 -eq $realHash[6]) {
             Write-CmdLine -Message "Hash Verification: Success" -Color "Green"
             Loginator -Message "Hash Verification: Success" -Path "$RunningDir\Repair_Log.log"
         }
         ELSE {
             Write-CmdLine -Message "Hash Verification: FAILURE" -Color "Red"
             Loginator -Message "Hash Verification: FAILURE" -Path "$RunningDir\Repair_Log.log"
             PAUSE
             Exit
         }
    }
    ELSE {
        $testHash = HashItem -FilePath "$RunningDir\repairScript.ps1" -HashType MD5
        $testHash1 = $testHash[1]
        Write-CmdLine -Message "File Hash: $testHash1" -Color "Cyan"
        Write-Host "Verification Disabled"
        Write-CmdLine "Warning: Verification Disabled" -Color "RED"
        Loginator -Message "File Hash: $testHash1" -Path "$RunningDir\Repair_Log.log"
        Loginator -Message "Warning: Verification Disabled" -Path "$RunningDir\Repair_Log.log"
        
    }
}
function Write-CmdLine {
    param(
        [string] $Message,
        [string] $FColor = 'White',
        [string] $BColor = 'DarkCyan'
    )
   # Colors "Black","Blue","Cyan","DarkBlue","DarkCyan","DarkGray","DarkGreen","DarkMagenta","DarkRed","DarkYellow","Gray","Green","Magenta","Red","White","Yellow"
   Write-Host $Message -ForegroundColor $FColor -BackgroundColor $BColor
}
function TimeStamp {
    Get-Date -Format "MM/dd/yyyy-HH:mm"
}
function Loginator {
    param (
        [STRING] $Message,
        [STRING] $Path
    )
    $Date = (TimeStamp)
    "[$Date] ~   $Message" | Out-File -FilePath $Path -Append
}
function RepairMe {
    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "Starting DISM Operation" -FColor "Yellow"
    Loginator -Message "    $Target- Beginning DISM Operation" -Path $LogLocation
    DISM /Online /Cleanup-Image /RestoreHealth

    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "Starting SFC Operation" -FColor "Yellow"
    Loginator -Message "    $Target- Beginning SFC Operation" -Path $LogLocation
    SFC /scannow

    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "Starting Defrag Operation" -FColor "Yellow"
    Loginator -Message "    $Target- Beginning Defrag Operation" -Path $LogLocation
    Defrag.exe /h /u /v /c

    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "Starting ChkDsk Operation" -FColor "Yellow"
    Loginator -Message "    $Target- Scheduling ChkDsk" -Path $LogLocation
    echo y | chkdsk.exe /f /x

    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "OPERATION COMPLETED" -FColor "Green" -BColor "BLACK"
    Loginator -Message "    $Target- Repair Completed" -Path $LogLocation

    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-CmdLine -Message "Press Any Key to Reboot" -FColor "Yellow"
    Loginator -Message "    $Target- Rebooting..." -Path $LogLocation
    PAUSE

}
function Banner {
    Write-CmdLine -Message "                            $Classification                           " -FColor "BLACK" -BColor "$BannerColor"
}
function LineSkip {
    param (
        [int]$Lines
    )
    foreach($i in 1..$Lines) {
        Write-Host " "
    }
}
    
#endregion FUNCTIONS
Banner
LineSkip -Lines 2
VerifyIntegrity
Loginator -Message "Repair Script Started on $Target" -Path $LogLocation
RepairMe
PAUSE
Shutdown -r -t 00