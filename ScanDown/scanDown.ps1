<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

## ABOUT
# This code is intended to automatically take a second look at downloaded files and return a result based off VirusTotal analysis.
# >NOTE< This application is NOT intended to circumvent security measures. When running this application ensure the system is physically supervised and protected.

#region Global Variables

[string]$apiKey = "<replaceMe>"





#endregion Global Variables

#Get-VTResult example $> Get-VTResult -FilePath "C:\Users\Admin\Downloads\file.txt"
function Get-Hash {
    [CmdletBinding()]
    param (
        $FilePath
    )
    #hashObject
    $global:hash = [PSCustomObject]@{
        MD5     = certutil -hashfile $FilePath MD5
        SHA1    = certutil -hashfile $FilePath SHA1
        SHA256  = certutil -hashfile $FilePath SHA256
    }
    Write-Host $hash.MD5
    Write-Host $hash.SHA1
    Write-Host $hash.SHA256
}

function initWatcher {
    [CmdletBinding()]
    param (
        $WatchDir
    )
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $WatchDir
    $watcher.EnableRaisingEvents = $true
    $action = {
        $global:path = $event.SourceEventArgs.FullPath
        $changetype = $event.SourceEventArgs.ChangeType
        Write-Host "`n"
        Write-Host "                                                                 " -BackgroundColor "Green"
        Write-Warning -Message "NEW FILE DETECTED $path"
        Write-Host "Press enter to begin scan (Be sure the file is DONE downloading)" -ForegroundColor "RED"
        PAUSE
        Write-Host "`n"
        Write-Host "Beginning Scan Process..." -ForegroundColor "Blue" -BackgroundColor "Black"
        $global:hash = [PSCustomObject]@{
            MD5     = certutil -hashfile $global:path MD5
            SHA1    = certutil -hashfile $global:path SHA1
            SHA256  = certutil -hashfile $global:path SHA256
        }
        $md5 = $hash.MD5[1]
        $sha1 = $hash.SHA1[1]
        $sha256 = $hash.SHA256[1]
        Write-Host "MD5: "$md5 -ForegroundColor "Yellow"
        Write-Host "SHA1: "$sha1 -ForegroundColor "Yellow"
        Write-Host "SHA256: "$sha256 -ForegroundColor "Yellow"
        Write-Host "Results can be found here: " -ForegroundColor "GREEN"
        Write-Host "https://www.virustotal.com/gui/file/$sha256" -ForegroundColor "Magenta"
        Write-Host "                                                                 " -BackgroundColor "Green"
        Write-Host "`n"
        Write-Host "`n"
        Write-Host "`n"
    }
    Register-ObjectEvent $watcher 'Created' -Action $action

}
Clear-Host
Write-Host "Starting Watcher..." -ForegroundColor "Yellow"
Write-Host "`n"
initWatcher -WatchDir "C:\Users\local.adm\Downloads"
Write-Host "`n"
Write-Host "Watcher Started! Press a key to begin monitoring" -ForegroundColor "GREEN"
PAUSE
Clear-Host