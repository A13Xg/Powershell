<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day2 - Advent of Code // https://adventofcode.com

$map = Get-Content -Path MapInput.txt
[int]$LineNum = 0
[int]$sledPos = 0
[int]$treeHit = 0
[int]$treeMiss = 0
ForEach ($mapLine in $map) {
    $SledContact = $mapLine[$sledPos]
    Write-Host "MapLine:$LineNum   $mapLine"
    Write-Host "Sled Position: $sledPos"
    Write-Host "Sled Contact: $SledContact"
    $sledPos = $sledPos+3
    IF ($SledContact -eq '#') {
        Write-Host "Tree hit"
        $treeHit++
    }
    ELSEIF ($SledContact -eq '.') {
        Write-Host "No Contact"
        $treeMiss++
    }
    ELSE {
        Write-Host "Out-of-Bounds"
    }
    Write-Host "TreeContact: $treeHit / $treeMiss"
    $LineNum++
}
Write-Host "Trees Hit: $treeHit"
Write-Host "Trees Missed: $treeMiss"