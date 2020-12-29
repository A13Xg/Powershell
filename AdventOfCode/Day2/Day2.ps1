<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 - Advent of Code // https://adventofcode.com

$inputPasswords = (Get-Content passwordInput.txt)
$validCount = 0
$invalidCount = 0

ForEach ($line in $inputPasswords) {
    $lineSplit = ($line).Split("")
    $lineLetterString = $lineSplit[1].Split(":")
    $lineNumber = $lineSplit[0]
    $lineNumberRange = $lineNumber.Split("-")
    [int]$lineNumMin = $lineNumberRange[0]
    [int]$lineNumMax = $lineNumberRange[1]
    $lineLetter = $lineLetterString[0]
    $linePass = $lineSplit[2]
    $filteredPass = $linePass -Replace "[^$lineLetter]"
    [int]$passCount = ($filteredPass).Length
    $lineRange = $lineNumMin..$lineNumMax
    IF (($lineRange).Contains($passCount)){
        $valid = $TRUE
        $validCount++
    }
    ELSEIF (!($lineRange).Contains($passCount)){
        $valid = $FALSE
        $invalidCount++
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
    Write-Host "Filtered Pass: $filteredPass"
    Write-Host "Valid: $valid"
    Write-Host "$invalidCount / $validCount"
    Write-Host "-------------------------"
    #>
}
Write-Host "ValidCount: $validCount"
Write-Host "InvalidCount: $invalidCount"