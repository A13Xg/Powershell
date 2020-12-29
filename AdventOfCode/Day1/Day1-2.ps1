<#
Code written by A13Xg
Property of Alexander Goodman
A13Xg Industries
#>

#Day1 (Part2) - Advent of Code // https://adventofcode.com

[int[]]$inputReport = (Get-Content ExpenseReport.txt)

    #// For every line in the input do this -per line-
ForEach ($value in $inputReport) {
        #// For every line in the input do this -per line-
    ForEach ($value1 in $inputReport) {
            #// For every line in the input do this -per line-
        ForEach ($value2 in $inputReport) {
                #// If one line plus another line plus another line = 2020 then print those numbers and then multiply them.
                    # NOTE: Since this function compares every value to itself and eachother, this will happen three times.
            IF (($value + $value1 + $value2) -eq 2020) {
                Write-Host $value $value1 $value2
                $value * $value1 * $value2
            }
        }
    }
}