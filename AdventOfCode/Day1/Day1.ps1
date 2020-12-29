<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day1 - Advent of Code // https://adventofcode.com

    #// Get content from text file to use as input
[int[]]$inputReport = (Get-Content ExpenseReport.txt)

#Write-Host $inputReport

    #// For every line in the input do this -per line-
ForEach ($value in $inputReport) {
    #// For every line in the input do this -per line-
    ForEach ($value1 in $inputReport) {
            #// If one line plus another line = 2020 then print those numbers and then multiply them.
                # NOTE: Since this function compares every value to itself and eachother, this will happen twice.
        IF (($value + $value1) -eq 2020) {
            Write-Host $value $value1
            $value * $value1
        }
    }
}