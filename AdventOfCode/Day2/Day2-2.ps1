<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 (Part2) - Advent of Code // https://adventofcode.com

    #// Get content from provided input
$inputPasswords = (Get-Content passwordInput.txt)
    #// Set count of Valid and Invalid passwords to 0
$validCount = 0
$invalidCount = 0

    #// For each line in the list do the following
ForEach ($line in $inputPasswords) {
        #// Split the line into sections
    $lineSplit = ($line).Split("")
        #// Split the line further to get the specified letter
    $lineLetterString = $lineSplit[1].Split(":")
        #// Split the line further to get the specified number range
    $lineNumber = $lineSplit[0]
    $lineNumberRange = $lineNumber.Split("-")
        #// Set the first and second number to seperate variables
    [int]$linePos1 = $lineNumberRange[0] - 1
    [int]$linePos2 = $lineNumberRange[1] - 1
    $lineLetter = $lineLetterString[0]
    $linePass = $lineSplit[2]
        #// If the line letter matches the ruleset drop into statement
    IF ($linePass[$linePos1] -eq $lineLetter){
            #// If the second line letter matches the ruleset set validity to false
        IF ($linePass[$linePos2] -eq $lineLetter) {
            $valid = $false
            $invalidCount ++
        }   
            #// If the second line letter doesnt match the ruleset set validity to true
        ELSE {
            $valid = $true
            $validCount ++
        }
    }
        #// If the first line letter doesnt match the ruleset drop into statement
    ELSEIF ($linePass[$linePos1] -ne $lineLetter){
            #// If the second line letter matches the ruleset set validity to true
        IF ($linePass[$linePos2] -eq $lineLetter) {
            $valid = $true
            $validCount ++
        }
            #// If the second line letter doesnt match the ruleset set validity to false
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