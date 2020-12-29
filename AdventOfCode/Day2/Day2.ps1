<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 - Advent of Code // https://adventofcode.com


    #// Get content from password input
$inputPasswords = (Get-Content passwordInput.txt)
    #// Set valid and invalid count to 0
$validCount = 0
$invalidCount = 0

    #// For each line in input do the following
ForEach ($line in $inputPasswords) {
        #//Split the line into sections
    $lineSplit = ($line).Split("")
        #// Further split the line from ruleset and password
    $lineLetterString = $lineSplit[1].Split(":")
        #// Get number for ruleset
    $lineNumber = $lineSplit[0]
        #// Get first and second number
    $lineNumberRange = $lineNumber.Split("-")
        #// Set min and max from number range
    [int]$lineNumMin = $lineNumberRange[0]
    [int]$lineNumMax = $lineNumberRange[1]
        #// Get letter for ruleset
    $lineLetter = $lineLetterString[0]
        #// Get password
    $linePass = $lineSplit[2]
        #// Extract all characters that match the letter specified in ruleset
    $filteredPass = $linePass -Replace "[^$lineLetter]"
        #// Get the occurences of the letter
    [int]$passCount = ($filteredPass).Length
        #// Set number range based on Min/Max
    $lineRange = $lineNumMin..$lineNumMax
        #// If the occurences of the letter fall within the specified range, drop into the statement
    IF (($lineRange).Contains($passCount)){
        #// Set validity to true and increase valid count
        $valid = $TRUE
        $validCount++
    }
    ELSEIF (!($lineRange).Contains($passCount)){
        #// Set validity to false and increase invalid count
        $valid = $FALSE
        $invalidCount++
    }
    ELSE {
        #// The previous condition statements both did not trigger- something went wrong, write error.
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

    #// Write the valid and invalid counts
Write-Host "ValidCount: $validCount"
Write-Host "InvalidCount: $invalidCount"