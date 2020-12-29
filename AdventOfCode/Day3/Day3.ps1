<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 - Advent of Code // https://adventofcode.com

    #// Get content from input
$map = Get-Content -Path MapInput.txt
    #// Set values to default 0
[int]$LineNum = 0
[int]$sledPos = 0
[int]$treeHit = 0
[int]$treeMiss = 0

    #// For each line in map do the following
ForEach ($mapLine in $map) {
        #// Set SledContact based on sled position on line
    $SledContact = $mapLine[$sledPos]
        #// Write info to console
    Write-Host "MapLine:$LineNum   $mapLine"
    Write-Host "Sled Position: $sledPos"
    Write-Host "Sled Contact: $SledContact"
        #// Add 3 to sled position
    $sledPos = $sledPos+3
        #// If sled position corresponds to a '#' drop into statement
    IF ($SledContact -eq '#') {
        Write-Host "Tree hit"
        #// Add count to trees hit
        $treeHit++
    }
        #// If sled position corresponds to a '.' drop into statement
    ELSEIF ($SledContact -eq '.') {
        Write-Host "No Contact"
        #// Add content to trees missed
        $treeMiss++
    }
        #// Final catch if previous conditions are not met
    ELSE {
        Write-Host "Out-of-Bounds"
    }
        #// Summarize trees hit / trees missed (during iteration)
    Write-Host "TreeContact: $treeHit / $treeMiss"
        #// Add count to line number
    $LineNum++
}
    #// Summarize trees hit / trees missed
Write-Host "Trees Hit: $treeHit"
Write-Host "Trees Missed: $treeMiss"