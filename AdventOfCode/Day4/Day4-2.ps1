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
    $passport -Match "(byr:\d\d\d\d)\b"
    $passportBYR = $Matches[0].Split(":")
    Write-Host $passportBYR[1]
    IF ($passportBYR[1] -ge 1920 -and $passportBYR[1] -ile 2002){
        Write-Host "True BYR"
        $hasBYR = $true
    }
    ELSEIF (!($passportBYR[1] -ge 1920 -and $passportBYR[1] -ile 2002)){
        Write-Host "FALSE BYR"
        $hasBYR = $false
    }
    ELSE {
        Write-Host "Error getting BYR"
    }

    $passport -Match "(iyr:\d\d\d\d)\b"
    $passportIYR = $Matches[0].Split(":")
    Write-Host $passportIYR[1]
    IF ($passportIYR[1] -ge 2010 -and $passportIYR[1] -ile 2020){
        Write-Host "True IYR"
        $hasIYR = $true
    }
    ELSEIF (!($passportIYR[1] -ge 2010 -and $passportIYR[1] -ile 2020)){
        Write-Host "False IYR"
        $hasIYR = $false
    }
    ELSE {
        Write-Host "Error getting IYR"
    }

    $passport -Match "(eyr:\d\d\d\d)\b"
    $passportEYR = $Matches[0].Split(":")
    Write-Host $passportEYR[1]
    IF ($passportEYR[1] -ge 2020 -and $passportEYR[1] -ile 2030){
        Write-Host "True EYR"
        $hasEYR = $true
    }
    ELSEIF (!($passportEYR[1] -ge 2020 -and $passportEYR[1] -ile 2030)){
        Write-Host "False EYR"
        $hasEYR = $false
    }
    ELSE {
        Write-Host "Error getting EYR"
    }
   
    $passport -Match "((hgt:\d\din)|(hgt:\d\d\din)|(hgt:\d\dcm)|(hgt:\d\d\dcm))\b"
    $passportHGT = $Matches[0].Split(":")
    Write-Host $passportHGT[1]
    IF ($passportHGT[1] -clike "*cm"){
        $passportHGT1 = $passportHGT[1] -Replace "cm"
        IF ($passportHGT1 -ige 150 -and $passportHGT1 -ile 193) {
            Write-Host "TrueCM- $passportHGT1"
            $hasHGT = $true
        }
        ELSEIF (!($passportHGT1 -ige 150 -and $passportHGT1 -ile 193)) {
            Write-Host "FalseCM- $passportHGT1"
            $hasHGT = $false
        }
    }
    ELSEIF ($passportHGT[1] -clike "*in"){
        $passportHGT1 = $passportHGT[1] -Replace "in"
        IF ($passportHGT1 -ige 59 -and $passportHGT1 -ile 76) {
            Write-Host "TrueIn- $passportHGT1"
            $hasHGT = $true
        }
        ELSEIF (!($passportHGT1 -ige 59 -and $passportHGT1 -ile 76)) {
            Write-Host "FalseIn- $passportHGT1"
            $hasHGT = $false
        }

    }
    ELSEIF (!($passportHGT[1] -clike "*cm" -or $passportHGT[1] -clike "*in")){
        Write-Host "FalseHGT"
        $hasHGT = $false
    }
    ELSE {
        Write-Host "Error getting HGT"
    }

    $passport -Match "(hcl:#[a-f|0-9]{6})\b"
    $passportHCL = $Matches[0].Split(":")
    Write-Host $passportHCL[1]
    IF ($passportHCL[1] -imatch "(#[a-f|0-9]{6})\b"){
        Write-Host "True HCL"
        $hasHCL = $true
    }
    ELSEIF (!($passportHCL[1] -imatch "(#[a-f|0-9]{6})\b")){
        Write-Host "False HCL"
        $hasHCL = $false
    }
    ELSE {
        Write-Host "Error getting HCL"
    }

    $passport -Match "ecl:((amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth))\b"
    $passportECL = $Matches[0].Split(":")
    Write-Host $passportECL[1]
    IF ($passportECL[1] -imatch "((amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth))\b"){
        Write-Host "True ECL"
        $hasECL = $true
    }
    ELSEIF (!($passportECL[1] -imatch "((amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth))\b")){
        Write-Host "False ECL"
        $hasECL = $false
    }
    ELSE {
        Write-Host "Error getting ECL"
    }

    $passport -Match "pid:(\d{9})\b"
    $passportPID = $Matches[0].Split(":")
    Write-Host $passportPID[1]
    IF ($passportPID[1] -imatch "(\d{9})\b"){
        Write-Host "True PID"
        $hasPID = $true
    }
    ELSEIF (!($passportPID[1] -imatch "(\d{9})\b")){
        Write-Host "False PID"
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