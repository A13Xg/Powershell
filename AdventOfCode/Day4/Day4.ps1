<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day4 - Advent of Code // https://adventofcode.com

#region REQUIREMENTS
[string]$BirthYear = "byr"
[string]$IssueYear = "iyr"
[string]$ExpirationYear = "eyr"
[string]$Height = "hgt"
[string]$HairColor = "hcl"
[string]$EyeColor = "ecl"
[string]$PassportID = "pid"
[string]$CountryID = "cid" #// Optional
#endregion REQUIREMENTS
[int]$passNum = 0
[int]$validCount = 0
[int]$invalidCount = 0

    #// Data input
$dataInput = Get-Content -Path Day4_Input.txt -Raw
    #// Ingest and format data
$joinedData = $dataInput -Join "`n"
$ingestedData = $joinedData -Split '\n\s+?\n?'


ForEach ($passport in $ingestedData) {
    Write-Host "Passport# $passNum"
    $passportBYR = $passport -Match "byr:"
    $passportIYR = $passport -Match "iyr:"
    $passportEYR = $passport -Match "eyr:"
    $passportHGT = $passport -Match "hgt:"
    $passportHCL = $passport -Match "hcl:"
    $passportECL = $passport -Match "ecl:"
    $passportPID = $passport -Match "pid:"

    IF ($passportBYR -ne $false){
        Write-Host "true"
        $hasBYR = $true
    }
    ELSEIF ($passportBYR -eq $false){
        Write-Host "false"
        $hasBYR = $false
    }
    ELSE {
        Write-Host "Error getting BYR"
    }

    IF ($passportIYR -ne $false){
        Write-Host "true"
        $hasIYR = $true
    }
    ELSEIF ($passportIYR -eq $false){
        Write-Host "false"
        $hasIYR = $false
    }
    ELSE {
        Write-Host "Error getting IYR"
    }

    IF ($passportEYR -ne $false){
        Write-Host "true"
        $hasEYR = $true
    }
    ELSEIF ($passportEYR -eq $false){
        Write-Host "false"
        $hasEYR = $false
    }
    ELSE {
        Write-Host "Error getting EYR"
    }

    IF ($passportHGT -ne $false){
        Write-Host "true"
        $hasHGT = $true
    }
    ELSEIF ($passportHGT -eq $false){
        Write-Host "false"
        $hasHGT = $false
    }
    ELSE {
        Write-Host "Error getting HGT"
    }

    IF ($passportHCL -ne $false){
        Write-Host "true"
        $hasHCL = $true
    }
    ELSEIF ($passportHCL -eq $false){
        Write-Host "false"
        $hasHCL = $false
    }
    ELSE {
        Write-Host "Error getting HCL"
    }

    IF ($passportECL -ne $false){
        Write-Host "true"
        $hasECL = $true
    }
    ELSEIF ($passportECL -eq $false){
        Write-Host "false"
        $hasECL = $false
    }
    ELSE {
        Write-Host "Error getting ECL"
    }

    IF ($passportPID -ne $false){
        Write-Host "true"
        $hasPID = $true
    }
    ELSEIF ($passportPID -eq $false){
        Write-Host "false"
        $hasPID = $false
    }
    ELSE {
        Write-Host "Error getting PID"
    }
    IF($hasBYR -ne $false -and $hasIYR -ne $false -and $hasHGT -ne $false -and $hasECL -ne $false -and $hasEYR -ne $false -and $hasHCL -ne $false -and $hasPID -ne $false) {
        $passportValid = $true
        $validCount++
    }
    ELSE {
        $passportValid = $false
        $invalidCount++
    }
    Write-Host "Passport Valid: $passportValid"
    Write-Host "Valid/Invalid: $validCount / $invalidCount"
    $passNum++
}