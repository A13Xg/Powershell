<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 (Part2) - Advent of Code // https://adventofcode.com

$inputPasswords = (Get-Content passwordInput.txt)
$validCount = 0
$invalidCount = 0

ForEach ($line in $inputPasswords) {
    $lineSplit = ($line).Split("")
    $lineLetterString = $lineSplit[1].Split(":")
    $lineNumber = $lineSplit[0]
    $lineNumberRange = $lineNumber.Split("-")
    [int]$linePos1 = $lineNumberRange[0] - 1
    [int]$linePos2 = $lineNumberRange[1] - 1
    $lineLetter = $lineLetterString[0]
    $linePass = $lineSplit[2]

    IF ($linePass[$linePos1] -eq $lineLetter){
        IF ($linePass[$linePos2] -eq $lineLetter) {
            $valid = $false
            $invalidCount ++
        }
        ELSE {
            $valid = $true
            $validCount ++
        }
    }
    ELSEIF ($linePass[$linePos1] -ne $lineLetter){
        IF ($linePass[$linePos2] -eq $lineLetter) {
            $valid = $true
            $validCount ++
        }
        ELSE {
            $valid = $false
            $invalidCount ++
        }
    }
    ELSE {
        Write-Host "ERROR"
    }
    #   // Uncomment this block if you want to see the individual processing (slower)
    <#
    Write-Host " "
    Write-Host "-------------------------"
    Write-Host "Letter: $lineLetter"
    Write-Host "Min count: $lineNumMin"
    Write-Host "Max count: $lineNumMax"
    Write-Host "Password: $linePass"
    Write-Host "Positions:" $linePass[$linePos1] $linePass[$linePos2]
    Write-Host "Valid: $valid"
    Write-Host "$invalidCount / $validCount"
    Write-Host "-------------------------"
    #>
}
Write-Host "ValidCount: $validCount"
Write-Host "InvalidCount: $invalidCount"