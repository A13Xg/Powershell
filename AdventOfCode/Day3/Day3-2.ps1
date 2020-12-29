<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 (Part2) - Advent of Code // https://adventofcode.com

$map = Get-Content -Path MapInput.txt
[int]$LineNum = 0
[int]$sledPos = 0
[int]$treeHit = 0
[int]$treeMiss = 0
[int]$slopeRight = 0
[int]$slopeDown = 0

Function Slope {
    [CmdletBinding()]
    param (
    [int]$slopeRight,
    [int]$slopeDown
    )
    ForEach ($mapLine in $map) {
        $SledContact = $mapLine[$sledPos]
        Write-Host "MapLine:$LineNum   $mapLine"
        Write-Host "Sled Position: $sledPos"
        Write-Host "Sled Contact: $SledContact"
        IF ($SledContact -eq '#') {
            Write-Host "Tree hit"
            $treeHit++
            $sledPos = $sledPos+$slopeRight
        }
        ELSEIF ($SledContact -eq '.') {
            Write-Host "No Contact"
            $treeMiss++
            $sledPos = $sledPos+$slopeRight
        }
        ELSE {
            Write-Host "Out-of-Bounds"
        }
        Write-Host "TreeContact: $treeHit / $treeMiss"
        $LineNum++
    }
    Write-Host "Trees Hit: $treeHit"
    Write-Host "Trees Missed: $treeMiss"
}

Slope -slopeRight 1 -slopeDown 1
Pause
Slope -slopeRight 3 -slopeDown 1
Pause
Slope -slopeRight 5 -slopeDown 1
Pause
Slope -slopeRight 7 -slopeDown 1
Pause
Slope -slopeRight 1 -slopeDown 2