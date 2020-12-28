<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
#This script's purpose is to allow an easier perform quick repair tasks across many computers.

#region GLOBAL-VARIABLES
$RunningDir = (Get-Location).Path
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
         $testHash = HashItem -FilePath "repair-launch.ps1" -HashType MD5
         $testHash1 = $testHash[1]
         $realHash = Get-Content -Path "VerifyIntegrity.dat"
         Write-CmdLine -Message "File Hash: $testHash1" -Color "Cyan"
         Loginator -Message "File Hash: $testHash1" -Path "$RunningDir\Repair_Log.log"
         IF ($testHash1 -eq $realHash[3]) {
             Write-CmdLine -Message "Hash Verification: Success" -Color "Green"
             Loginator -Message "Hash Verification: Success" -Path "$RunningDir\Repair_Log.log"
         }
         ELSE {
             Write-CmdLine -Message "Hash Verification: FAILURE" -Color "Red"
             Loginator -Message "Hash Verification: FAILURE" -Path "$RunningDir\Repair_Log.log"
             Exit
         }
    }
    ELSE {
        $testHash = HashItem -FilePath "repair-launch.ps1" -HashType MD5
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
function CheckAlive {
    Test-Connection -ComputerName $Target -Count 2 -Quiet
}
function InitRepair {
    param (
        [string]$Target
    )
    .\psexec \\$Target -acceptEULA -d cmd /c powershell.exe -ExecutionPolicy Bypass -File "$RunningDir\repairScript.ps1"
}
function InitiateUplink {
    Write-CmdLine -Message "Testing Connection to $Target... `n" -Color "White"
    IF(CheckAlive -eq $True) {
        Write-CmdLine -Message "Uplink Established" -Color "Green"
        Write-CmdLine -Message "Starting Repair on $Target..." -Color "Yellow"
    }
    ELSE {
        Write-CmdLine -Message "Error: Unable to contact target $Target" -Color "Red"
        LaunchLoop
    }
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
function LaunchLoop {
    Clear-Host
    Banner
    LineSkip -Lines 3
    Write-Host "Choose an option:"
    Write-Host "(1) Local Machine"
    Write-Host "(2) Remote Machine"
    Write-Host "[Ctrl+C to Exit]"
    $Option = Read-Host -Prompt " "
    LineSkip -Lines 10
    IF ($Option -eq 1) {
        Write-CmdLine -Message "LOCAL HOST"
        Write-CmdLine -Message "Running on $env:COMPUTERNAME ..."
        InitRepair -Target $env:COMPUTERNAME
        LaunchLoop
    }
    ELSEIF ($Option -eq 2) {
        Write-CmdLine "Please specify the target:" -FColor "Yellow" -BColor "BLACK"
        $Target = Read-Host -Prompt " "
        InitiateUplink
        InitRepair -Target $Target
        LaunchLoop
    }
    ELSE {
        Write-CmdLine -Message "ERROR: You did not enter a correct response" -FColor "RED" -BColor "BLACK"
        LaunchLoop
    }
}
#endregion FUNCTIONS
Banner
Loginator -Message "Script ran by $env:USERNAME" -Path "$RunningDir\Repair_Log.log"
VerifyIntegrity
LaunchLoop
