<#
/3 = Fizz
/5 = Buzz
/3+5 = FizzBuzz
#>
$end = Read-Host -Prompt "Specify Target"

[ARRAY]$num = 1..$end
<#
ForEach ($number in $num) {
    $Fizz1 = $number % 3
    $Buzz1 = $number % 5
    IF ($Fizz1 -eq 0) {
        $Fizz = "Fizz"
        $number = ''
    }
    ELSE {
        $Fizz = ''
    }
    IF ($Buzz1 -eq 0) {
        $Buzz = "Buzz"
        $number = ''
    }
    ELSE {
        $Buzz = ''
    }
    Write-Host "$Fizz" "$Buzz" "$Number"
}
#>

ForEach ($number in $num) {
    IF ($number % 3 -eq 0 -and $number % 5 -eq 0) {
        Write-Host "Fizz Buzz"
    }
    ELSEIF ($number % 3 -eq 0) {
        Write-Host "Fizz"
    }
    ELSEIF ($number % 5 -eq 0) {
        Write-Host "Buzz"
    }
    ELSE {
        Write-Host $number
    }
}

