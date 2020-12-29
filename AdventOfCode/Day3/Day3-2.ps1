<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 (Part2) - Advent of Code // https://adventofcode.com

    #// Get map input
$map = Get-Content -Path MapInput.txt

    #// Set default/base values of variables
[int]$LineNum = 0
[int]$sledPos = 0
[int]$treeHit = 0
[int]$treeMiss = 0
[int]$slopeRight = 0
[int]$slopeDown = 0

    #Function SLOPE - Usage PS:> Slope -slopeRight <number> -slopeDown <number>
Function Slope {
    [CmdletBinding()]
    param (
            #// Variables to be passed into function
        [int]$slopeRight,
        [int]$slopeDown
    )
        #// For each line in the map do the following
    ForEach ($mapLine in $map) {
            #// Set the position of the sled to the corresponding character on the map
        $SledContact = $mapLine[$sledPos]
            #// Write info to console
        Write-Host "MapLine:$LineNum   $mapLine"
        Write-Host "Sled Position: $sledPos"
        Write-Host "Sled Contact: $SledContact"
            #// If position is a '#' and the line is divisible by the slope down then drop into statement
        IF ($SledContact -eq '#' -and $LineNum%$slopeDown -eq 0) {
            Write-Host "Tree hit"
                #// Add count to tree hit
            $treeHit++
                #// Add slope amount to sled position
            $sledPos = $sledPos+$slopeRight
        }
            #// If position is a '.' and the line is divisible by the slope down then drop into statement
        ELSEIF ($SledContact -eq '.' -and $LineNum%$slopeDown -eq 0) {
            Write-Host "No Contact"
                #// Add count to tree miss
            $treeMiss++
                #// Add slope amount to sled position
            $sledPos = $sledPos+$slopeRight
        }
            #// If position is neither '#' or '.' then drop into statement
        ELSE {
            Write-Host "Out-of-Bounds"
        }
            #// Summarize hit / miss count
        Write-Host "TreeContact: $treeHit / $treeMiss"
            #// Add count to line number
        $LineNum++
    }
        #// Write host summary
    Write-Host "Trees Hit: $treeHit"
    Write-Host "Trees Missed: $treeMiss"
}

    #// Functions called based on slopes given
Slope -slopeRight 1 -slopeDown 1
Pause
Slope -slopeRight 3 -slopeDown 1
Pause
Slope -slopeRight 5 -slopeDown 1
Pause
Slope -slopeRight 7 -slopeDown 1
Pause
Slope -slopeRight 1 -slopeDown 2